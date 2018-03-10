using frugal.Protocol;

namespace frugal.Processor
{
    public interface IFProcessor
    {
        void Process(FProtocol inProtocol, FProtocol outProtocol);
        // TODO: Add AddMiddleware
    }
}