// Autogenerated by Frugal Compiler (3.11.0)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

package variety

import (
	"fmt"

	"github.com/Workiva/frugal/lib/gopherjs/frugal"
	"github.com/Workiva/frugal/lib/gopherjs/thrift"
	"github.com/Workiva/frugal/test/expected/gopherjs/intermediate_include"
)

type FFooTransitiveDeps interface {
	intermediate_include.FIntermediateFoo

	Ping(ctx frugal.FContext) (err error)
}

type FFooTransitiveDepsClient struct {
	*intermediate_include.FIntermediateFooClient
	methods map[string]*frugal.Method
}

func NewFFooTransitiveDepsClient(provider *frugal.FServiceProvider, middleware ...frugal.ServiceMiddleware) *FFooTransitiveDepsClient {
	methods := make(map[string]*frugal.Method)
	client := &FFooTransitiveDepsClient{
		FIntermediateFooClient: intermediate_include.NewFIntermediateFooClient(provider, middleware...),
		methods:                methods,
	}
	middleware = append(middleware, provider.GetMiddleware()...)
	methods["ping"] = frugal.NewMethod(client, client.ping, "ping", middleware)
	return client
}

func (f *FFooTransitiveDepsClient) Ping(ctx frugal.FContext) (err error) {
	ret := f.methods["ping"].Invoke([]interface{}{ctx})
	if len(ret) != 1 {
		panic(fmt.Sprintf("Middleware returned %d arguments, expected 1", len(ret)))
	}
	if ret[0] != nil {
		err = ret[0].(error)
	}
	return err
}

func (f *FFooTransitiveDepsClient) ping(ctx frugal.FContext) (err error) {
	args := FooTransitiveDepsPingArgs{}
	result := FooTransitiveDepsPingResult{}
	err = f.Client_().Call(ctx, "ping", &args, &result)
	if err != nil {
		return
	}
	return
}

type FFooTransitiveDepsProcessor struct {
	*intermediate_include.FIntermediateFooProcessor
}

func NewFFooTransitiveDepsProcessor(handler FFooTransitiveDeps, middleware ...frugal.ServiceMiddleware) *FFooTransitiveDepsProcessor {
	p := &FFooTransitiveDepsProcessor{intermediate_include.NewFIntermediateFooProcessor(handler, middleware...)}
	p.AddToProcessorMap("ping", &footransitivedepsFPing{frugal.NewFBaseProcessorFunction(p.GetWriteMutex(), frugal.NewMethod(handler, handler.Ping, "Ping", middleware))})
	return p
}

type footransitivedepsFPing struct {
	*frugal.FBaseProcessorFunction
}

func (p *footransitivedepsFPing) Process(ctx frugal.FContext, iprot, oprot *frugal.FProtocol) error {
	args := FooTransitiveDepsPingArgs{}
	err := args.Read(iprot)
	iprot.ReadMessageEnd()
	if err != nil {
		return p.SendError(ctx, oprot, frugal.APPLICATION_EXCEPTION_PROTOCOL_ERROR, "ping", err.Error())
	}
	result := FooTransitiveDepsPingResult{}
	ret := p.InvokeMethod([]interface{}{ctx})
	if len(ret) != 1 {
		panic(fmt.Sprintf("Middleware returned %d arguments, expected 1", len(ret)))
	}
	if ret[0] != nil {
		err = ret[0].(error)
	}
	if err != nil {
		if typedError, ok := err.(thrift.TApplicationException); ok {
			p.SendError(ctx, oprot, typedError.TypeId(), "ping", typedError.Error())
			return nil
		}
		return p.SendError(ctx, oprot, frugal.APPLICATION_EXCEPTION_INTERNAL_ERROR, "ping", "Internal error processing ping: "+err.Error())
	}
	return p.SendReply(ctx, oprot, "ping", &result)
}

type FooTransitiveDepsPingArgs struct {
}

func NewFooTransitiveDepsPingArgs() *FooTransitiveDepsPingArgs {
	return &FooTransitiveDepsPingArgs{}
}

func (p *FooTransitiveDepsPingArgs) Read(iprot thrift.TProtocol) error {
	if _, err := iprot.ReadStructBegin(); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T read error: ", p), err)
	}

	for {
		_, fieldTypeId, fieldId, err := iprot.ReadFieldBegin()
		if err != nil {
			return thrift.PrependError(fmt.Sprintf("%T field %d read error: ", p, fieldId), err)
		}
		if fieldTypeId == thrift.STOP {
			break
		}
		if err := iprot.Skip(fieldTypeId); err != nil {
			return err
		}
		if err := iprot.ReadFieldEnd(); err != nil {
			return err
		}
	}
	if err := iprot.ReadStructEnd(); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T read struct end error: ", p), err)
	}
	return nil
}

func (p *FooTransitiveDepsPingArgs) Write(oprot thrift.TProtocol) error {
	if err := oprot.WriteStructBegin("ping_args"); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T write struct begin error: ", p), err)
	}
	if err := oprot.WriteFieldStop(); err != nil {
		return thrift.PrependError("write field stop error: ", err)
	}
	if err := oprot.WriteStructEnd(); err != nil {
		return thrift.PrependError("write struct stop error: ", err)
	}
	return nil
}

func (p *FooTransitiveDepsPingArgs) String() string {
	if p == nil {
		return "<nil>"
	}
	return fmt.Sprintf("FooTransitiveDepsPingArgs(%+v)", *p)
}

type FooTransitiveDepsPingResult struct {
}

func NewFooTransitiveDepsPingResult() *FooTransitiveDepsPingResult {
	return &FooTransitiveDepsPingResult{}
}

func (p *FooTransitiveDepsPingResult) Read(iprot thrift.TProtocol) error {
	if _, err := iprot.ReadStructBegin(); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T read error: ", p), err)
	}

	for {
		_, fieldTypeId, fieldId, err := iprot.ReadFieldBegin()
		if err != nil {
			return thrift.PrependError(fmt.Sprintf("%T field %d read error: ", p, fieldId), err)
		}
		if fieldTypeId == thrift.STOP {
			break
		}
		if err := iprot.Skip(fieldTypeId); err != nil {
			return err
		}
		if err := iprot.ReadFieldEnd(); err != nil {
			return err
		}
	}
	if err := iprot.ReadStructEnd(); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T read struct end error: ", p), err)
	}
	return nil
}

func (p *FooTransitiveDepsPingResult) Write(oprot thrift.TProtocol) error {
	if err := oprot.WriteStructBegin("ping_result"); err != nil {
		return thrift.PrependError(fmt.Sprintf("%T write struct begin error: ", p), err)
	}
	if err := oprot.WriteFieldStop(); err != nil {
		return thrift.PrependError("write field stop error: ", err)
	}
	if err := oprot.WriteStructEnd(); err != nil {
		return thrift.PrependError("write struct stop error: ", err)
	}
	return nil
}

func (p *FooTransitiveDepsPingResult) String() string {
	if p == nil {
		return "<nil>"
	}
	return fmt.Sprintf("FooTransitiveDepsPingResult(%+v)", *p)
}
