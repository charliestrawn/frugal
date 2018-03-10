using Thrift.Transport;

namespace frugal.Protocol
{
    public interface FAsyncCallback
    {
        void OnMessage(TTransport transport);
    }
}