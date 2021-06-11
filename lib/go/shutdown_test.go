package frugal

import (
	"fmt"
	"testing"
	"time"

	"github.com/apache/thrift/lib/go/thrift"
	"github.com/nats-io/nats.go"
)

type testProcessor struct {
}

func (*testProcessor) AddMiddleware(ServiceMiddleware)           {}
func (*testProcessor) Annotations() map[string]map[string]string { return nil }
func (proc *testProcessor) Process(in, out *FProtocol) error {
	fmt.Printf("Getting request: %v", in)
	time.Sleep(time.Second)
	return nil
}

func TestShutdown(t *testing.T) {
	const REQ = 100

	conn, err := nats.Connect(nats.DefaultURL)
	if err != nil {
		t.Log("docker run --rm -it -p 4222:4222 nats")
		panic(err)
	}

	proc := &testProcessor{}

	srv := NewFNatsServerBuilder(
		conn,
		proc,
		NewFProtocolFactory(thrift.NewTJSONProtocolFactory()),
		[]string{"frugal.test.shutdown"},
	).WithWorkerCount(2).WithQueueLength(100).Build()

	go func() {
		err := srv.Serve()
		if err != nil {
			panic(err)
		}
	}()

	// TODO: publish a bunch of messages
	for i := 0; i < REQ; i++ {
		err := conn.PublishRequest("frugal.test.shutdown", "_INBOX.round-file", []byte("work"))
		if err != nil {
			panic(err)
		}
	}
	time.Sleep(time.Second)

	if err = srv.Stop(); err != nil {
		panic(err)
	}
}
