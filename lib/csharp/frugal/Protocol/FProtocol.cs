using Thrift.Protocol;
using Thrift.Transport;

namespace frugal.Protocol
{

    public interface IFProtocolFactory
    {
        FProtocol GetProtocol(TTransport transport);
    }

    public class FProtocolFactory : IFProtocolFactory
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

    /// <summary>
    ///  FProtocol is Frugal's equivalent of Thrift's TProtocol. It defines the
    ///  serialization protocol used for messages, such as JSON, binary, etc.FProtocol
    /// actually extends TProtocol and adds support for serializing FContext.In
    /// practice, FProtocol simply wraps a TProtocol and uses Thrift's built-in
    /// serialization.FContext is encoded before the TProtocol serialization of the
    /// message using a simple binary protocol.See the protocol documentation for more
    /// details.
    /// </summary>
    public class FProtocol : TProtocol
    {
        private readonly TProtocol _wrapped;

        public FProtocol(TProtocol proto) : base(proto.Transport)
        {
            _wrapped = proto;
        }

        public void WriteRequestHeader(FContext context)
        {
            _wrapped.Transport.Write(HeaderUtils.Encode(context.GetRequestHeaders()));
        }

        /// <summary>
        /// ReadRequestHeader reads the headers on the FProtocol into an FContext.
        /// </summary>
        /// <returns>FContext</returns>
        public FContext ReadRequestHeader()
        {
            var headers = HeaderUtils.Read(_wrapped.Transport);

            // Store the opId so it can be added to the response headers
            // as the opId will be overridden when creating the FContext
            var opId = headers[FContext.OpIdHeader];

            var context = FContext.WithRequestHeaders(headers);
            context.AddResponseHeader(FContext.OpIdHeader, opId);

            var cId = context.GetCorrelationId();
            if (!string.IsNullOrEmpty(cId))
            {
                context.AddResponseHeader(FContext.CorrelationIdHeader, cId);
            }
            return context;
        }

        public override void WriteMessageBegin(TMessage message)
        {
            _wrapped.WriteMessageBegin(message);
        }

        public void WriteResponseHeader(FContext context)
        {
            _wrapped.Transport.Write(HeaderUtils.Encode(context.GetResponseHeaders()));
        }

        public void ReadResponseHeader(FContext context)
        {
            var headers = HeaderUtils.Read(_wrapped.Transport);
            headers.Remove(FContext.OpIdHeader);
            context.AddResponseHeaders(headers);
        }

        public override void WriteMessageEnd()
        {
            _wrapped.WriteMessageEnd();
        }

        public override void WriteStructBegin(TStruct struc)
        {
            _wrapped.WriteStructBegin(struc);
        }

        public override void WriteStructEnd()
        {
            _wrapped.WriteStructEnd();
        }

        public override void WriteFieldBegin(TField field)
        {
            _wrapped.WriteFieldBegin(field);
        }

        public override void WriteFieldEnd()
        {
            _wrapped.WriteFieldEnd();
        }

        public override void WriteFieldStop()
        {
            _wrapped.WriteFieldStop();
        }

        public override void WriteMapBegin(TMap map)
        {
            _wrapped.WriteMapBegin(map);
        }

        public override void WriteMapEnd()
        {
            _wrapped.WriteMapEnd();
        }

        public override void WriteListBegin(TList list)
        {
            _wrapped.WriteListBegin(list);
        }

        public override void WriteListEnd()
        {
            _wrapped.WriteListEnd();
        }

        public override void WriteSetBegin(TSet set)
        {
            _wrapped.WriteSetBegin(set);
        }

        public override void WriteSetEnd()
        {
            _wrapped.WriteSetEnd();
        }

        public override void WriteBool(bool b)
        {
            _wrapped.WriteBool(b);
        }

        public override void WriteByte(sbyte b)
        {
            _wrapped.WriteByte(b);
        }

        public override void WriteI16(short i16)
        {
            _wrapped.WriteI16(i16);
        }

        public override void WriteI32(int i32)
        {
            _wrapped.WriteI32(i32);
        }

        public override void WriteI64(long i64)
        {
            _wrapped.WriteI64(i64);
        }

        public override void WriteDouble(double d)
        {
            _wrapped.WriteDouble(d);
        }

        public override void WriteBinary(byte[] b)
        {
            _wrapped.WriteBinary(b);
        }

        public override TMessage ReadMessageBegin()
        {
            return _wrapped.ReadMessageBegin();
        }

        public override void ReadMessageEnd()
        {
            _wrapped.ReadMessageEnd();
        }

        public override TStruct ReadStructBegin()
        {
            return _wrapped.ReadStructBegin();
        }

        public override void ReadStructEnd()
        {
            _wrapped.ReadStructEnd();
        }

        public override TField ReadFieldBegin()
        {
            return _wrapped.ReadFieldBegin();
        }

        public override void ReadFieldEnd()
        {
            _wrapped.ReadFieldEnd();
        }

        public override TMap ReadMapBegin()
        {
            return _wrapped.ReadMapBegin();
        }

        public override void ReadMapEnd()
        {
            _wrapped.ReadMapEnd();
        }

        public override TList ReadListBegin()
        {
            return _wrapped.ReadListBegin();
        }

        public override void ReadListEnd()
        {
            _wrapped.ReadListEnd();
        }

        public override TSet ReadSetBegin()
        {
            return _wrapped.ReadSetBegin();
        }

        public override void ReadSetEnd()
        {
            _wrapped.ReadSetEnd();
        }

        public override bool ReadBool()
        {
            return _wrapped.ReadBool();
        }

        public override sbyte ReadByte()
        {
            return _wrapped.ReadByte();
        }

        public override short ReadI16()
        {
            return _wrapped.ReadI16();
        }

        public override int ReadI32()
        {
            return _wrapped.ReadI32();
        }

        public override long ReadI64()
        {
            return _wrapped.ReadI64();
        }

        public override double ReadDouble()
        {
            return _wrapped.ReadDouble();
        }

        public override byte[] ReadBinary()
        {
            return _wrapped.ReadBinary();
        }
    }
}
