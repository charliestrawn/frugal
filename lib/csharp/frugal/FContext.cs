using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading;

namespace frugal
{
    /// <summary>
    ///  FContext is the context for a Frugal message. Every RPC has an FContext, which
    /// can be used to set request headers, response headers, and the request timeout.
    /// The default timeout is five seconds. An FContext is also sent with every publish
    /// message which is then received by subscribers.
    /// </summary>
    public class FContext
    {
        private static long _nextOpId = 0;
        public static string CorrelationIdHeader = "_cid";
        public static string OpIdHeader = "_opid";
        public static string TimeoutHeader = "_timeout";
        private static int DefaultTimout = 5 * 1000;

        private readonly Dictionary<string, string> _requestHeaders = new Dictionary<string, string>();
        private readonly Dictionary<string, string> _responseHeaders = new Dictionary<string, string>();

        public FContext() : this(GenerateCorrelationId())
        { 
        }

        public FContext(Dictionary<string, string> requestHeaders, Dictionary<string, string> responseHeaders)
        {
            _requestHeaders = requestHeaders;
            _responseHeaders = responseHeaders;
        }

        public FContext(string correlationId)
        {
            _requestHeaders.Add(CorrelationIdHeader, correlationId);
            _requestHeaders.Add(OpIdHeader, GetNextOpId().ToString());
            _requestHeaders.Add(TimeoutHeader, DefaultTimout.ToString());
        }

        public string GetCorrelationId()
        {
            return _requestHeaders[CorrelationIdHeader];
        }

        public FContext AddRequestHeader(string name, string value)
        {
            _requestHeaders.Add(name, value);
            return this;
        }

        public FContext AddRequestHeaders(Dictionary<string, string> headers)
        {
            foreach (var header in headers)
            {
                AddRequestHeader(header.Key, header.Value);
            }

            return this;
        }

        public string GetRequestHeader(string name)
        {
            return _requestHeaders[name];
        }

        public Dictionary<string, string> GetRequestHeaders()
        {
            // TODO: Return a copy of the headers
            return _requestHeaders;
        }

        public FContext AddResponseHeader(string name, string value)
        {
            _responseHeaders.Add(name, value);
            return this;
        }

        public FContext AddResponseHeaders(Dictionary<string, string> headers)
        {
            foreach (var header in headers)
            {
                AddResponseHeader(header.Key, header.Value);
            }

            return this;
        }

        public string GetResponseHeader(string name)
        {
            return _responseHeaders[name];
        }

        public Dictionary<string, string> GetResponseHeaders()
        {
            // TODO: return a copy of the headers
            return _responseHeaders;
        }

        public void SetTimeout(long timeout)
        {
            _requestHeaders.Add(TimeoutHeader, timeout.ToString());
        }

        public long GetTimeout()
        {
            return long.Parse(_requestHeaders[TimeoutHeader]);
        }

        private static string GenerateCorrelationId()
        {
            return Guid.NewGuid().ToString("N");
        }

        private static long GetNextOpId()
        {
            return Interlocked.Increment(ref _nextOpId);
        }

        public static FContext WithRequestHeaders(Dictionary<string, string> headers)
        {
            throw new NotImplementedException();
        }
    }
}
