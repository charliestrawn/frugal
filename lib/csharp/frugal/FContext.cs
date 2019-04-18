using System;
using System.Collections.Generic;
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
        // To ensure every new FContext gets a unique opid, use an atomic, incrementing integer.
        private static long _nextOpId = 0;

        /// <summary>
        /// Header containing correlation id.
        /// </summary>
        public const string CorrelationIdHeader = "_cid";

        /// <summary>
        /// Header containing op id (uint64 as string).
        /// </summary>
        public const string OpIdHeader = "_opid";

        /// <summary>
        /// Header containing request timeout (milliseconds as string).
        /// </summary>
        public const string TimeoutHeader = "_timeout";

        /// <summary>
        /// Default request timeout in milliseconds.
        /// </summary>
        protected const long DefaultTimout = 5 * 1000;

        private readonly Dictionary<string, string> _requestHeaders = new Dictionary<string, string>();
        private readonly Dictionary<string, string> _responseHeaders = new Dictionary<string, string>();

        /// <inheritdoc />
        /// <summary>
        /// Creates a new FContext with a randomly generated correlation id for tracing purposes.
        /// </summary>
        public FContext() : this(GenerateCorrelationId())
        {
        }

        /// <summary>
        /// Creates a new FContext with the given correlation id for tracing purposes.
        /// </summary>
        /// <param name="correlationId">unique tracing identifier</param>
        public FContext(string correlationId)
        {
            _requestHeaders.Add(CorrelationIdHeader, correlationId);
            _requestHeaders.Add(OpIdHeader, GetNextOpId());
            _requestHeaders.Add(TimeoutHeader, DefaultTimout.ToString());
        }

        private FContext(Dictionary<string, string> requestHeaders, Dictionary<string, string> responseHeaders)
        {
            _requestHeaders = requestHeaders;
            _responseHeaders = responseHeaders;
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

        /// <summary>
        /// Returns the response header with the given name. If no such header exists, null is returned.
        /// </summary>
        /// <param name="name">header name</param>
        /// <returns>header value or null</returns>
        public string GetResponseHeader(string name)
        {
            return _responseHeaders[name];
        }

        /// <summary>
        /// Returns the response headers on the FContext.
        /// </summary>
        /// <returns>response headers map</returns>
        public Dictionary<string, string> GetResponseHeaders()
        {
            // TODO: return a copy of the headers
            return _responseHeaders;
        }

        /// <summary>
        /// Set the request timeout. Default is 5 seconds.
        /// </summary>
        /// <param name="timeout">the request timeout in milliseconds.</param>
        public void SetTimeout(long timeout)
        {
            if (_requestHeaders.ContainsKey(TimeoutHeader))
            {
                _requestHeaders[TimeoutHeader] = timeout.ToString();
            }
            else
            {
                _requestHeaders.Add(TimeoutHeader, timeout.ToString());
            }
        }

        /// <summary>
        /// Get the request timeout.
        /// </summary>
        /// <returns>the request timeout in milliseconds.</returns>
        public long GetTimeout()
        {
            return long.Parse(_requestHeaders[TimeoutHeader]);
        }

        private static string GenerateCorrelationId()
        {
            return Guid.NewGuid().ToString("N");
        }

        private static string GetNextOpId()
        {
            return Interlocked.Increment(ref _nextOpId).ToString();
        }

        /// <summary>
        /// Creates a new FContext with the given request headers.
        /// </summary>
        /// <param name="headers">request headers</param>
        /// <returns>FContext</returns>
        public static FContext WithRequestHeaders(Dictionary<string, string> headers)
        {
            if (!headers.ContainsKey(CorrelationIdHeader))
            {
                headers.Add(CorrelationIdHeader, GenerateCorrelationId());
            }

            if (!headers.ContainsKey(TimeoutHeader))
            {
                headers.Add(TimeoutHeader, DefaultTimout.ToString());
            }
            headers.Add(OpIdHeader, GetNextOpId());

            return new FContext(headers, new Dictionary<string, string>());
        }
    }
}
