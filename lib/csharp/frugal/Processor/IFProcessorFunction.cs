using frugal.Protocol;

namespace frugal.Processor
{
    public interface IFProcessorFunction
    {
        void Process(FContext context, FProtocol inProtocol, FProtocol outProtocol);
    }
}