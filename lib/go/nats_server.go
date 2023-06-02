/*
 * Copyright 2017 Workiva
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package frugal

import (
	"bytes"
	"sync"
	"time"

	"github.com/apache/thrift/lib/go/thrift"
	"github.com/nats-io/nats.go"
)

const (
	defaultWorkQueueLen = 64
	defaultWatermark    = 5 * time.Second

	RequestReceivedTimeKey = "request_received_time"
)

type frameWrapper struct {
	frameBytes          []byte
	reply               string
	ephemeralProperties map[interface{}]interface{}
}

// FNatsServerBuilder configures and builds NATS server instances.
type FNatsServerBuilder struct {
	conn              *nats.Conn
	processor         FProcessor
	protoFactory      *FProtocolFactory
	subjects          []string
	queue             string
	workerCount       uint
	queueLen          uint
	highWatermark     time.Duration
	onRequestReceived func(map[interface{}]interface{})
	onRequestStarted  func(map[interface{}]interface{})
	onRequestFinished func(map[interface{}]interface{})
}

// var for testing purposes
var timeNow = time.Now

// DefaultFNatsServerOnRequestReceived is the default handler called when an
// FNatsServer receives a message. It adds the time the request was received
// to the passed in properties.
func DefaultFNatsServerOnRequestReceived(properties map[interface{}]interface{}) {
	properties[RequestReceivedTimeKey] = timeNow()
}

// NewDefaultFNatsServerOnRequestStarted constructs a default handler for when
// an FNatsServer starts processing a message. It checks the current time
// against a start time in the passed in properties, and logs a warning if the
// difference is over a threshold.
func NewDefaultFNatsServerOnRequestStarted(highWatermark time.Duration) func(map[interface{}]interface{}) {
	return func(properties map[interface{}]interface{}) {
		if start, ok := properties[RequestReceivedTimeKey]; ok {
			dur := time.Since(start.(time.Time))
			if dur > highWatermark {
				logger().Warnf("frugal: request spent %+v in the transport buffer, your consumer might be backed up", dur)
			}
		}
	}
}

// DefaultFNatsServerOnRequestFinished is the default handler called when an
// FNatsServer finishes processing a message. If does nothing
func DefaultFNatsServerOnRequestFinished(properties map[interface{}]interface{}) {}

// NewFNatsServerBuilder creates a builder which configures and builds NATS
// server instances.
func NewFNatsServerBuilder(conn *nats.Conn, processor FProcessor,
	protoFactory *FProtocolFactory, subjects []string) *FNatsServerBuilder {
	return &FNatsServerBuilder{
		conn:          conn,
		processor:     processor,
		protoFactory:  protoFactory,
		subjects:      subjects,
		workerCount:   1,
		queueLen:      defaultWorkQueueLen,
		highWatermark: defaultWatermark,
	}
}

// WithRequestReceivedEventHandler sets a function to be called when the
// FNatsServer receives a message, but before it is put onto a work queue. The
// properties map will be set on the FContext before processing is started.
//
// If the same functionality can be accomplished through middleware, middleware
// is preferred as it is more flexible and more portable between different
// servers. This function should only handle events and behaviour specific to
// an FNatsServer that aren't applicable to other frugal servers.
func (f *FNatsServerBuilder) WithRequestReceivedEventHandler(handler func(map[interface{}]interface{})) *FNatsServerBuilder {
	f.onRequestReceived = handler
	return f
}

// WithRequestStartedEventHandler sets a function to be called before the
// FNatsServer processes a message. The properties map will be set on the
// FContext before processing begins.
//
// If the same functionality can be accomplished through middleware, middleware
// is preferred as it is more flexible and more portable between different
// servers. This function should only handle events and behaviour specific to
// an FNatsServer that aren't applicable to other frugal servers.
func (f *FNatsServerBuilder) WithRequestStartedEventHandler(handler func(map[interface{}]interface{})) *FNatsServerBuilder {
	f.onRequestStarted = handler
	return f
}

// WithRequestFinishedEventHandler sets a function to be called after the
// FNatsServer processes a message.
//
// If the same functionality can be accomplished through middleware, middleware
// is preferred as it is more flexible and more portable between different
// servers. This function should only handle events and behaviour specific to
// an FNatsServer that aren't applicable to other frugal servers.
func (f *FNatsServerBuilder) WithRequestFinishedEventHandler(handler func(map[interface{}]interface{})) *FNatsServerBuilder {
	f.onRequestFinished = handler
	return f
}

// WithQueueGroup adds a NATS queue group to receive requests on.
func (f *FNatsServerBuilder) WithQueueGroup(queue string) *FNatsServerBuilder {
	f.queue = queue
	return f
}

// WithWorkerCount controls the number of goroutines used to process requests.
func (f *FNatsServerBuilder) WithWorkerCount(workerCount uint) *FNatsServerBuilder {
	f.workerCount = workerCount
	return f
}

// WithQueueLength controls the length of the work queue used to buffer
// requests.
func (f *FNatsServerBuilder) WithQueueLength(queueLength uint) *FNatsServerBuilder {
	f.queueLen = queueLength
	return f
}

// WithHighWatermark controls the time duration requests wait in queue before
// triggering slow consumer logic.
func (f *FNatsServerBuilder) WithHighWatermark(highWatermark time.Duration) *FNatsServerBuilder {
	f.highWatermark = highWatermark
	return f
}

// Build a new configured NATS FServer.
func (f *FNatsServerBuilder) Build() FServer {
	if f.onRequestReceived == nil {
		f.onRequestReceived = DefaultFNatsServerOnRequestReceived
	}
	if f.onRequestStarted == nil {
		f.onRequestStarted = NewDefaultFNatsServerOnRequestStarted(f.highWatermark)
	}
	if f.onRequestFinished == nil {
		f.onRequestFinished = DefaultFNatsServerOnRequestFinished
	}

	return &fNatsServer{
		conn:              f.conn,
		processor:         f.processor,
		protoFactory:      f.protoFactory,
		subjects:          f.subjects,
		queue:             f.queue,
		workerCount:       f.workerCount,
		workC:             make(chan *frameWrapper, f.queueLen),
		quit:              make(chan struct{}),
		onRequestReceived: f.onRequestReceived,
		onRequestStarted:  f.onRequestStarted,
		onRequestFinished: f.onRequestFinished,
	}
}

// fNatsServer implements FServer by using NATS as the underlying transport.
// Clients must connect with the transport created by NewNatsFTransport.
type fNatsServer struct {
	conn         *nats.Conn
	processor    FProcessor
	protoFactory *FProtocolFactory
	subjects     []string
	queue        string
	workerCount  uint
	workC        chan *frameWrapper
	quit         chan struct{}

	onRequestReceived func(map[interface{}]interface{})
	onRequestStarted  func(map[interface{}]interface{})
	onRequestFinished func(map[interface{}]interface{})
}

// Serve starts the server.
func (f *fNatsServer) Serve() error {
	subscriptions := []*nats.Subscription{}
	for _, subject := range f.subjects {
		sub, err := f.conn.QueueSubscribe(subject, f.queue, f.handler)
		if err != nil {
			return err
		}
		subscriptions = append(subscriptions, sub)
	}

	var wg sync.WaitGroup
	wg.Add(int(f.workerCount))

	for i := uint(0); i < f.workerCount; i++ {
		go func() {
			f.worker()
			wg.Done()
		}()
	}

	logger().WithField(`subjects`, f.subjects).Info("frugal: server running...")
	<-f.quit
	logger().WithField(`subjects`, f.subjects).Info("frugal: server stopping...")

	// drain each subscription (allow handling of responses)
	for _, sub := range subscriptions {
		sub.Drain()
	}

	// wait for subs to finish draining (no good way to wait for shutting down subscriptions)
	for _, sub := range subscriptions {
		for sub.IsValid() {
			time.Sleep(20 * time.Millisecond)
		}
	}
	logger().WithField(`subjects`, f.subjects).Debug(`frugal: subscriptions drained`)

	// allow processes to wrap up
	close(f.workC)
	wg.Wait()
	logger().WithField(`subjects`, f.subjects).Debug(`frugal: workers drained`)

	return nil
}

// Stop the server.
func (f *fNatsServer) Stop() error {
	close(f.quit)
	return nil
}

// handler is invoked when a request is received. The request is placed on the
// work channel which is processed by a worker goroutine.
func (f *fNatsServer) handler(msg *nats.Msg) {
	ephemeralProperties := make(map[interface{}]interface{})
	f.onRequestReceived(ephemeralProperties)

	if msg.Reply == "" {
		logger().Warn("frugal: discarding invalid NATS request (no reply)")
		return
	}

	f.workC <- &frameWrapper{frameBytes: msg.Data, reply: msg.Reply, ephemeralProperties: ephemeralProperties}
}

// worker should be called as a goroutine. It reads requests off the work
// channel and processes them.
func (f *fNatsServer) worker() {
	for frame := range f.workC {
		f.processFrame(frame)
	}
}

// processFrame invokes the FProcessor and sends the response on the given
// subject.
func (f *fNatsServer) processFrame(frame *frameWrapper) {
	f.onRequestStarted(frame.ephemeralProperties)
	defer f.onRequestFinished(frame.ephemeralProperties)

	// Read and process frame.
	input := &thrift.TMemoryBuffer{Buffer: bytes.NewBuffer(frame.frameBytes[4:])} // Discard frame size
	// Only allow 1MB to be buffered.
	output := NewTMemoryOutputBuffer(natsMaxMessageSize)
	iprot := f.protoFactory.GetProtocol(input)
	iprot.ephemeralProperties = frame.ephemeralProperties
	oprot := f.protoFactory.GetProtocol(output)
	if err := f.processor.Process(iprot, oprot); err != nil {
		logger().WithError(err).Error(`frugal: error processing request`)
		return
	}

	if !output.HasWriteData() {
		return
	}

	// Send response.
	if err := f.conn.Publish(frame.reply, output.Bytes()); err != nil {
		logger().WithError(err).Error(`frugal: error publishing response`)
	}
}
