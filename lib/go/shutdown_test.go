package frugal

import (
	"fmt"
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
	fmt.Printf("Getting request: %v", in)
	time.Sleep(time.Second)
	return nil
}

func TestShutdown(t *testing.T) {
	const REQ = 10

	conn, err := nats.Connect(nats.DefaultURL)
	if err != nil {
		t.Log("docker run --rm -it -p 4222:4222 nats")
		panic(err)
	}

	start := int32(0)
	proc := &testProcessor{count: &start}

	srv := NewFNatsServerBuilder(
		conn,
		proc,
		NewFProtocolFactory(thrift.NewTJSONProtocolFactory()),
		[]string{"frugal.test.shutdown"},
	).WithWorkerCount(2).WithQueueLength(REQ).Build()

	go func() {
		err := srv.Serve()
		if err != nil {
			panic(err)
		}
	}()

	// TODO: publish a bunch of messages
	for i := 0; i < REQ; i++ {
		err := conn.PublishRequest("frugal.test.shutdown", "INBOX.round-file", []byte("work"))
		if err != nil {
			panic(err)
		}
	}
	time.Sleep(time.Second)

	if err = srv.Stop(); err != nil {
		panic(err)
	}

	assert.Equal(t, atomic.LoadInt32(proc.count), int32(REQ))
}
