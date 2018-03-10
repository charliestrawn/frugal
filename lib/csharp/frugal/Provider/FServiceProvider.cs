using frugal.Protocol;
using frugal.Transport;

namespace frugal.Provider
{
    /// <summary>
    /// FServiceProvider produces FTransports and FProtocols for use by RPC service clients.
    /// The main purpose of this is to provide a shim for adding middleware to a client.
    /// </summary>
    public class FServiceProvider
    {
        private IFTransport Transport { get; }
        private IFProtocolFactory ProtocolFactory { get; }

        public FServiceProvider(IFTransport transport, IFProtocolFactory protocolFactory)
        {
            Transport = transport;
            ProtocolFactory = protocolFactory;
        }

        // TODO: Add Middleware
    }
}