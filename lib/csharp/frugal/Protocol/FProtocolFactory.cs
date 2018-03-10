using Thrift.Protocol;
using Thrift.Transport;

namespace frugal.Protocol
{
    public interface IFProtocolFactory
    {
        FProtocol GetProtocol(TTransport transport);
    }

    public class FProtocolFactory
    {
        private readonly TProtocolFactory _tProtocolFactory;

        public FProtocolFactory(TProtocolFactory protocolFactory)
        {
            _tProtocolFactory = protocolFactory;
        }

        public FProtocol GetProtocol(TTransport transport)
        {
            return new FProtocol(_tProtocolFactory.GetProtocol(transport));
        }
    }
}