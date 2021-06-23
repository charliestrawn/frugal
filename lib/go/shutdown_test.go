package frugal

import (
	"runtime"
	"sync/atomic"
	"testing"
	"time"

	"github.com/apache/thrift/lib/go/thrift"
	"github.com/nats-io/nats.go"
	"github.com/stretchr/testify/assert"
)

type testProcessor struct {
	count *int32
}

func (*testProcessor) AddMiddleware(ServiceMiddleware)           {}
func (*testProcessor) Annotations() map[string]map[string]string { return nil }
func (proc *testProcessor) Process(in, out *FProtocol) error {
	atomic.AddInt32(proc.count, 1)
	time.Sleep(time.Millisecond * 100)
	return nil
}

func safe(tb testing.TB, err error) {
	if err != nil {
		tb.Fatalf("Failed: %v", err)
	}
}

func TestShutdown(t *testing.T) {
	const REQ = 10
	start := int32(0)
	proc := &testProcessor{count: &start}

	// Startup a generic nats processor
	conn, err := nats.Connect(nats.DefaultURL)
	if err != nil {
		t.Log("docker run --rm -it -p 4222:4222 nats")
		t.Skipf("Unable to connect to nats: %v", err)
	}
	srv := NewFNatsServerBuilder(
		conn,
		proc,
		NewFProtocolFactory(thrift.NewTJSONProtocolFactory()),
		[]string{"frugal.test.shutdown"},
	).WithWorkerCount(2).WithQueueLength(REQ).Build()

	// Start the server in the background and let us know when it exits
	serveDone := make(chan bool)
	go func() {
		safe(t, srv.Serve())
		close(serveDone)
	}()
	time.Sleep(time.Millisecond * 10)
	runtime.Gosched() // wait for server to startup

	// Publish a bunch of messages (ignore frugal stack, just trigger nats processors)
	for i := 0; i < REQ; i++ {
		safe(t, conn.PublishRequest("frugal.test.shutdown", "INBOX.round-file", []byte("work")))
	}
	safe(t, conn.Flush())
	time.Sleep(time.Millisecond * 10)
	runtime.Gosched() // wait for some form of processing

	// Shutdown server and wait for Serve to return
	safe(t, srv.Stop())
	<-serveDone

	// Make some assertions about the state of things
	count := atomic.LoadInt32(proc.count)
	t.Logf("Received %d; Processed: %d; Remaining: %d", REQ, count, len(srv.(*fNatsServer).workC))
	assert.Equal(t, count, int32(REQ))
}
