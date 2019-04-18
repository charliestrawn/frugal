using System;
using System.Collections.Generic;
using Thrift.Transport;

namespace frugal.Protocol
{
    class HeaderUtils
    {
        // Version 0
        public static byte V0 = 0x00;

        public static byte[] Encode(Dictionary<string, string> headers)
        {
            throw new NotImplementedException();
        }

        public static Dictionary<string, string> Read(TTransport transport)
        {
            throw new NotImplementedException();
        }

        public static Dictionary<string, string> DecodeFromFrame(byte[] bytes)
        {
            throw new NotImplementedException();
        }
    }
}
