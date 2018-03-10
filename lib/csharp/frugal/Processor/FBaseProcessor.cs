using System.Collections.Generic;
using frugal.Protocol;
using Thrift.Protocol;

namespace frugal.Processor
{
    public abstract class FBaseProcessor : IFProcessor
    {
        private Dictionary<string, IFProcessorFunction> _processMap;

        public void Process(FProtocol inProtocol, FProtocol outProtocol)
        {
            if (_processMap == null)
            {
                _processMap = GetProcessMap();
            }

            var context = inProtocol.ReadRequestHeader();
            var message = inProtocol.ReadMessageBegin();
            var processor = _processMap[message.Name];

            processor?.Process(context, inProtocol, outProtocol);

            TProtocolUtil.Skip(inProtocol, TType.Struct);
            inProtocol.ReadMessageEnd();
        }

        protected abstract Dictionary<string, IFProcessorFunction> GetProcessMap();
    }
}