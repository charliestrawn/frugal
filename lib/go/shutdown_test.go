package frugal

import (
	"runtime"
	"sync/atomic"
	"testing"
	"time"

	"github.com/apache/thrift/lib/go/thrift"
	"github.com/nats-io/nats-server/v2/server"
	"github.com/nats-io/nats.go"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
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

func TestShutdown(t *testing.T) {
	if testing.Short() {
		t.Skip(`not a short test`)
	}
	s, err := server.NewServer(&server.Options{
		/* defaults */
		Debug: true,
		Trace: true,
	})
	require.NoError(t, err)
	s.ConfigureLogger() // nice for debugging
	s.Start()
	defer s.Shutdown()

	const REQ = 10
	start := int32(0)
	proc := &testProcessor{count: &start}

	// Startup a generic nats processor
	conn, err := nats.Connect(nats.DefaultURL)
	require.NoError(t, err)
	srv := NewFNatsServerBuilder(
		conn,
		proc,
		NewFProtocolFactory(thrift.NewTJSONProtocolFactory()),
		[]string{"frugal.test.shutdown"},
	).WithWorkerCount(2).WithQueueLength(REQ).Build()

	// Start the server in the background and let us know when it exits
	serveDone := make(chan bool)
	go func() {
		require.NoError(t, srv.Serve())
		close(serveDone)
	}()
	time.Sleep(time.Millisecond * 10)
	runtime.Gosched() // wait for server to startup

	// Publish a bunch of messages (ignore frugal stack, just trigger nats processors)
	for i := 0; i < REQ; i++ {
		require.NoError(t, conn.PublishRequest("frugal.test.shutdown", "INBOX.round-file", []byte("work")))
	}
	require.NoError(t, conn.Flush())
	time.Sleep(time.Millisecond * 10)
	runtime.Gosched() // wait for some form of processing

	// Shutdown server, send a few more requests after server dies, and wait for shutdown
	require.NoError(t, srv.Stop())
	require.NoError(t, conn.PublishRequest("frugal.test.shutdown", "INBOX.round-file", []byte("work"))) // expect this to drop
	<-serveDone

	// Make some assertions about the state of things
	count := atomic.LoadInt32(proc.count)
	t.Logf("Received %d; Processed: %d; Remaining: %d", REQ, count, len(srv.(*fNatsServer).workC))
	assert.Equal(t, count, int32(REQ))
	s.Shutdown()
}
