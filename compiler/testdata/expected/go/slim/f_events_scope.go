// Autogenerated by Frugal Compiler (3.16.13)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

package variety

import (
	"context"
	"fmt"

	frugal "github.com/Workiva/frugal/lib/go"
	"github.com/apache/thrift/lib/go/thrift"
)

// This docstring gets added to the generated code because it has
// the @ sign. Prefix specifies topic prefix tokens, which can be static or
// variable.
type EventsPublisher interface {
	Open() error
	Close() error
	PublishEventCreated(fctx frugal.FContext, user string, req *Event) error
	PublishSomeInt(fctx frugal.FContext, user string, req int64) error
	PublishSomeStr(fctx frugal.FContext, user string, req string) error
	PublishSomeList(fctx frugal.FContext, user string, req []map[ID]*Event) error
}

type eventsPublisher struct {
	client  frugal.FClient
	methods map[string]*frugal.Method
}

func NewEventsPublisher(provider *frugal.FScopeProvider, middleware ...frugal.ServiceMiddleware) EventsPublisher {
	publisher := &eventsPublisher{
		client:  frugal.NewFScopeClient(provider),
		methods: make(map[string]*frugal.Method),
	}
	middleware = append(middleware, provider.GetMiddleware()...)
	publisher.methods["publishEventCreated"] = frugal.NewMethod(publisher, publisher.publishEventCreated, "publishEventCreated", middleware)
	publisher.methods["publishSomeInt"] = frugal.NewMethod(publisher, publisher.publishSomeInt, "publishSomeInt", middleware)
	publisher.methods["publishSomeStr"] = frugal.NewMethod(publisher, publisher.publishSomeStr, "publishSomeStr", middleware)
	publisher.methods["publishSomeList"] = frugal.NewMethod(publisher, publisher.publishSomeList, "publishSomeList", middleware)
	return publisher
}

func (p eventsPublisher) Open() error  { return p.client.Open() }
func (p eventsPublisher) Close() error { return p.client.Close() }

// This is a docstring.
func (p *eventsPublisher) PublishEventCreated(fctx frugal.FContext, user string, req *Event) error {
	ret := p.methods["publishEventCreated"].Invoke([]interface{}{fctx, user, req})
	if ret[0] != nil {
		return ret[0].(error)
	}
	return nil
}

func (p *eventsPublisher) publishEventCreated(fctx frugal.FContext, user string, req *Event) error {
	fctx.AddRequestHeader("_topic_user", user)
	prefix := fmt.Sprintf("foo.%s.", user)
	op := "EventCreated"
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	return p.client.Publish(fctx, op, topic, req)
}

func (p *eventsPublisher) PublishSomeInt(fctx frugal.FContext, user string, req int64) error {
	ret := p.methods["publishSomeInt"].Invoke([]interface{}{fctx, user, req})
	if ret[0] != nil {
		return ret[0].(error)
	}
	return nil
}

func (p *eventsPublisher) publishSomeInt(fctx frugal.FContext, user string, req int64) error {
	fctx.AddRequestHeader("_topic_user", user)
	prefix := fmt.Sprintf("foo.%s.", user)
	op := "SomeInt"
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	return p.client.Publish(fctx, op, topic, eventsSomeIntMessage(req))
}

type eventsSomeIntMessage int64

func (p eventsSomeIntMessage) Write(ctx context.Context, oprot thrift.TProtocol) error {
	if err := oprot.WriteI64(ctx, int64(p)); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T. (0) field write error: ", p), err)
	}
	return nil
}

func (p eventsSomeIntMessage) Read(ctx context.Context, iprot thrift.TProtocol) error {
	panic("Not Implemented!")
}

func (p *eventsPublisher) PublishSomeStr(fctx frugal.FContext, user string, req string) error {
	ret := p.methods["publishSomeStr"].Invoke([]interface{}{fctx, user, req})
	if ret[0] != nil {
		return ret[0].(error)
	}
	return nil
}

func (p *eventsPublisher) publishSomeStr(fctx frugal.FContext, user string, req string) error {
	fctx.AddRequestHeader("_topic_user", user)
	prefix := fmt.Sprintf("foo.%s.", user)
	op := "SomeStr"
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	return p.client.Publish(fctx, op, topic, eventsSomeStrMessage(req))
}

type eventsSomeStrMessage string

func (p eventsSomeStrMessage) Write(ctx context.Context, oprot thrift.TProtocol) error {
	if err := oprot.WriteString(ctx, string(p)); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T. (0) field write error: ", p), err)
	}
	return nil
}

func (p eventsSomeStrMessage) Read(ctx context.Context, iprot thrift.TProtocol) error {
	panic("Not Implemented!")
}

func (p *eventsPublisher) PublishSomeList(fctx frugal.FContext, user string, req []map[ID]*Event) error {
	ret := p.methods["publishSomeList"].Invoke([]interface{}{fctx, user, req})
	if ret[0] != nil {
		return ret[0].(error)
	}
	return nil
}

func (p *eventsPublisher) publishSomeList(fctx frugal.FContext, user string, req []map[ID]*Event) error {
	fctx.AddRequestHeader("_topic_user", user)
	prefix := fmt.Sprintf("foo.%s.", user)
	op := "SomeList"
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	return p.client.Publish(fctx, op, topic, eventsSomeListMessage(req))
}

type eventsSomeListMessage []map[ID]*Event

func (p eventsSomeListMessage) Write(ctx context.Context, oprot thrift.TProtocol) error {
	if err := oprot.WriteListBegin(ctx, thrift.MAP, len(p)); err != nil {
		return thrift.PrependError("error writing list begin: ", err)
	}
	for _, v := range p {
		if err := oprot.WriteMapBegin(ctx, thrift.I64, thrift.STRUCT, len(v)); err != nil {
			return thrift.PrependError("error writing map begin: ", err)
		}
		for k, v := range v {
			if err := oprot.WriteI64(ctx, int64(k)); err != nil {
				return thrift.PrependError(fmt.Sprintf("%T. (0) field write error: ", p), err)
			}
			if err := v.Write(ctx, oprot); err != nil {
				return thrift.PrependError(fmt.Sprintf("%T error writing struct: ", v), err)
			}
		}
		if err := oprot.WriteMapEnd(ctx); err != nil {
			return thrift.PrependError("error writing map end: ", err)
		}
	}
	if err := oprot.WriteListEnd(ctx); err != nil {
		return thrift.PrependError("error writing list end: ", err)
	}
	return nil
}

func (p eventsSomeListMessage) Read(ctx context.Context, iprot thrift.TProtocol) error {
	panic("Not Implemented!")
}

// This docstring gets added to the generated code because it has
// the @ sign. Prefix specifies topic prefix tokens, which can be static or
// variable.
type EventsSubscriber interface {
	SubscribeEventCreated(user string, handler func(frugal.FContext, *Event)) (*frugal.FSubscription, error)
	SubscribeSomeInt(user string, handler func(frugal.FContext, int64)) (*frugal.FSubscription, error)
	SubscribeSomeStr(user string, handler func(frugal.FContext, string)) (*frugal.FSubscription, error)
	SubscribeSomeList(user string, handler func(frugal.FContext, []map[ID]*Event)) (*frugal.FSubscription, error)
}

// This docstring gets added to the generated code because it has
// the @ sign. Prefix specifies topic prefix tokens, which can be static or
// variable.
type EventsErrorableSubscriber interface {
	SubscribeEventCreatedErrorable(user string, handler func(frugal.FContext, *Event) error) (*frugal.FSubscription, error)
	SubscribeSomeIntErrorable(user string, handler func(frugal.FContext, int64) error) (*frugal.FSubscription, error)
	SubscribeSomeStrErrorable(user string, handler func(frugal.FContext, string) error) (*frugal.FSubscription, error)
	SubscribeSomeListErrorable(user string, handler func(frugal.FContext, []map[ID]*Event) error) (*frugal.FSubscription, error)
}

type eventsSubscriber struct {
	provider   *frugal.FScopeProvider
	middleware []frugal.ServiceMiddleware
}

func NewEventsSubscriber(provider *frugal.FScopeProvider, middleware ...frugal.ServiceMiddleware) EventsSubscriber {
	middleware = append(middleware, provider.GetMiddleware()...)
	return &eventsSubscriber{provider: provider, middleware: middleware}
}

func NewEventsErrorableSubscriber(provider *frugal.FScopeProvider, middleware ...frugal.ServiceMiddleware) EventsErrorableSubscriber {
	middleware = append(middleware, provider.GetMiddleware()...)
	return &eventsSubscriber{provider: provider, middleware: middleware}
}

// This is a docstring.
func (l *eventsSubscriber) SubscribeEventCreated(user string, handler func(frugal.FContext, *Event)) (*frugal.FSubscription, error) {
	return l.SubscribeEventCreatedErrorable(user, func(fctx frugal.FContext, arg *Event) error {
		handler(fctx, arg)
		return nil
	})
}

// This is a docstring.
func (l *eventsSubscriber) SubscribeEventCreatedErrorable(user string, handler func(frugal.FContext, *Event) error) (*frugal.FSubscription, error) {
	op := "EventCreated"
	prefix := fmt.Sprintf("foo.%s.", user)
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	transport, protocolFactory := l.provider.NewSubscriber()
	cb := l.recvEventCreated(op, protocolFactory, handler)
	if err := transport.Subscribe(topic, cb); err != nil {
		return nil, err
	}

	sub := frugal.NewFSubscription(topic, transport)
	return sub, nil
}

func (l *eventsSubscriber) recvEventCreated(op string, pf *frugal.FProtocolFactory, handler func(frugal.FContext, *Event) error) frugal.FAsyncCallback {
	method := frugal.NewMethod(l, handler, "SubscribeEventCreated", l.middleware)
	return func(transport thrift.TTransport) error {
		iprot := pf.GetProtocol(transport)
		fctx, err := iprot.ReadRequestHeader()
		if err != nil {
			return err
		}

		ctx, cancelFn := frugal.ToContext(fctx)
		defer cancelFn()

		name, _, _, err := iprot.ReadMessageBegin(ctx)
		if err != nil {
			return err
		}

		if name != op {
			iprot.Skip(ctx, thrift.STRUCT)
			iprot.ReadMessageEnd(ctx)
			return thrift.NewTApplicationException(frugal.APPLICATION_EXCEPTION_UNKNOWN_METHOD, "Unknown function"+name)
		}
		req := NewEvent()
		if err := req.Read(ctx, iprot); err != nil {
			return thrift.PrependError(fmt.Sprintf("%T error reading struct: ", req), err)
		}
		iprot.ReadMessageEnd(ctx)

		return method.Invoke([]interface{}{fctx, req}).Error()
	}
}

func (l *eventsSubscriber) SubscribeSomeInt(user string, handler func(frugal.FContext, int64)) (*frugal.FSubscription, error) {
	return l.SubscribeSomeIntErrorable(user, func(fctx frugal.FContext, arg int64) error {
		handler(fctx, arg)
		return nil
	})
}

func (l *eventsSubscriber) SubscribeSomeIntErrorable(user string, handler func(frugal.FContext, int64) error) (*frugal.FSubscription, error) {
	op := "SomeInt"
	prefix := fmt.Sprintf("foo.%s.", user)
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	transport, protocolFactory := l.provider.NewSubscriber()
	cb := l.recvSomeInt(op, protocolFactory, handler)
	if err := transport.Subscribe(topic, cb); err != nil {
		return nil, err
	}

	sub := frugal.NewFSubscription(topic, transport)
	return sub, nil
}

func (l *eventsSubscriber) recvSomeInt(op string, pf *frugal.FProtocolFactory, handler func(frugal.FContext, int64) error) frugal.FAsyncCallback {
	method := frugal.NewMethod(l, handler, "SubscribeSomeInt", l.middleware)
	return func(transport thrift.TTransport) error {
		iprot := pf.GetProtocol(transport)
		fctx, err := iprot.ReadRequestHeader()
		if err != nil {
			return err
		}

		ctx, cancelFn := frugal.ToContext(fctx)
		defer cancelFn()

		name, _, _, err := iprot.ReadMessageBegin(ctx)
		if err != nil {
			return err
		}

		if name != op {
			iprot.Skip(ctx, thrift.STRUCT)
			iprot.ReadMessageEnd(ctx)
			return thrift.NewTApplicationException(frugal.APPLICATION_EXCEPTION_UNKNOWN_METHOD, "Unknown function"+name)
		}
		var req int64
		if v, err := iprot.ReadI64(ctx); err != nil {
			return thrift.PrependError("error reading field 0: ", err)
		} else {
			req = v
		}
		iprot.ReadMessageEnd(ctx)

		return method.Invoke([]interface{}{fctx, req}).Error()
	}
}

func (l *eventsSubscriber) SubscribeSomeStr(user string, handler func(frugal.FContext, string)) (*frugal.FSubscription, error) {
	return l.SubscribeSomeStrErrorable(user, func(fctx frugal.FContext, arg string) error {
		handler(fctx, arg)
		return nil
	})
}

func (l *eventsSubscriber) SubscribeSomeStrErrorable(user string, handler func(frugal.FContext, string) error) (*frugal.FSubscription, error) {
	op := "SomeStr"
	prefix := fmt.Sprintf("foo.%s.", user)
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	transport, protocolFactory := l.provider.NewSubscriber()
	cb := l.recvSomeStr(op, protocolFactory, handler)
	if err := transport.Subscribe(topic, cb); err != nil {
		return nil, err
	}

	sub := frugal.NewFSubscription(topic, transport)
	return sub, nil
}

func (l *eventsSubscriber) recvSomeStr(op string, pf *frugal.FProtocolFactory, handler func(frugal.FContext, string) error) frugal.FAsyncCallback {
	method := frugal.NewMethod(l, handler, "SubscribeSomeStr", l.middleware)
	return func(transport thrift.TTransport) error {
		iprot := pf.GetProtocol(transport)
		fctx, err := iprot.ReadRequestHeader()
		if err != nil {
			return err
		}

		ctx, cancelFn := frugal.ToContext(fctx)
		defer cancelFn()

		name, _, _, err := iprot.ReadMessageBegin(ctx)
		if err != nil {
			return err
		}

		if name != op {
			iprot.Skip(ctx, thrift.STRUCT)
			iprot.ReadMessageEnd(ctx)
			return thrift.NewTApplicationException(frugal.APPLICATION_EXCEPTION_UNKNOWN_METHOD, "Unknown function"+name)
		}
		var req string
		if v, err := iprot.ReadString(ctx); err != nil {
			return thrift.PrependError("error reading field 0: ", err)
		} else {
			req = v
		}
		iprot.ReadMessageEnd(ctx)

		return method.Invoke([]interface{}{fctx, req}).Error()
	}
}

func (l *eventsSubscriber) SubscribeSomeList(user string, handler func(frugal.FContext, []map[ID]*Event)) (*frugal.FSubscription, error) {
	return l.SubscribeSomeListErrorable(user, func(fctx frugal.FContext, arg []map[ID]*Event) error {
		handler(fctx, arg)
		return nil
	})
}

func (l *eventsSubscriber) SubscribeSomeListErrorable(user string, handler func(frugal.FContext, []map[ID]*Event) error) (*frugal.FSubscription, error) {
	op := "SomeList"
	prefix := fmt.Sprintf("foo.%s.", user)
	topic := fmt.Sprintf("%sEvents.%s", prefix, op)
	transport, protocolFactory := l.provider.NewSubscriber()
	cb := l.recvSomeList(op, protocolFactory, handler)
	if err := transport.Subscribe(topic, cb); err != nil {
		return nil, err
	}

	sub := frugal.NewFSubscription(topic, transport)
	return sub, nil
}

func (l *eventsSubscriber) recvSomeList(op string, pf *frugal.FProtocolFactory, handler func(frugal.FContext, []map[ID]*Event) error) frugal.FAsyncCallback {
	method := frugal.NewMethod(l, handler, "SubscribeSomeList", l.middleware)
	return func(transport thrift.TTransport) error {
		iprot := pf.GetProtocol(transport)
		fctx, err := iprot.ReadRequestHeader()
		if err != nil {
			return err
		}

		ctx, cancelFn := frugal.ToContext(fctx)
		defer cancelFn()

		name, _, _, err := iprot.ReadMessageBegin(ctx)
		if err != nil {
			return err
		}

		if name != op {
			iprot.Skip(ctx, thrift.STRUCT)
			iprot.ReadMessageEnd(ctx)
			return thrift.NewTApplicationException(frugal.APPLICATION_EXCEPTION_UNKNOWN_METHOD, "Unknown function"+name)
		}
		_, size, err := iprot.ReadListBegin(ctx)
		if err != nil {
			return thrift.PrependError("error reading list begin: ", err)
		}
		req := make([]map[ID]*Event, 0, size)
		for i := 0; i < size; i++ {
			_, _, size, err := iprot.ReadMapBegin(ctx)
			if err != nil {
				return thrift.PrependError("error reading map begin: ", err)
			}
			elem25 := make(map[ID]*Event, size)
			for i := 0; i < size; i++ {
				var elem26 ID
				if v, err := iprot.ReadI64(ctx); err != nil {
					return thrift.PrependError("error reading field 0: ", err)
				} else {
					temp := ID(v)
					elem26 = temp
				}
				elem27 := NewEvent()
				if err := elem27.Read(ctx, iprot); err != nil {
					return thrift.PrependError(fmt.Sprintf("%T error reading struct: ", elem27), err)
				}
				(elem25)[elem26] = elem27
			}
			if err := iprot.ReadMapEnd(ctx); err != nil {
				return thrift.PrependError("error reading map end: ", err)
			}
			req = append(req, elem25)
		}
		if err := iprot.ReadListEnd(ctx); err != nil {
			return thrift.PrependError("error reading list end: ", err)
		}
		iprot.ReadMessageEnd(ctx)

		return method.Invoke([]interface{}{fctx, req}).Error()
	}
}
