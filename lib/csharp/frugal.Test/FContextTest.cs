using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace frugal.Test
{
    [TestClass]
    public class FContextTest
    {
        [TestMethod]
        public void TestInitWithCorrelationId()
        {
            var correlationId = "JOHNNNNN CENNNNAAAA";
            var fContext = new FContext(correlationId);

            Assert.AreEqual(correlationId, fContext.GetRequestHeader("_cid"));
            Assert.AreEqual("5000", fContext.GetRequestHeader("_timeout"));
        }

        [TestMethod]
        public void TestGetCorrelationId()
        {
            var correlationId = "JOHNNNNN CENNNNAAAA";
            var fContext = new FContext(correlationId);

            Assert.AreEqual(correlationId, fContext.GetCorrelationId());
        }

        [TestMethod]
        public void TestAddRequestHeader()
        {
            var fContext = new FContext();

            fContext.AddRequestHeader("foo", "bar");

            Assert.AreEqual("bar", fContext.GetRequestHeader("foo"));
        }
    }
}
