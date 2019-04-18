using System.Collections.Generic;
using NUnit.Framework;

namespace frugal.Test
{
    [TestFixture]
    public class FContextTest
    {
        [Test]
        public void TestInitWithCorrelationId()
        {
            var correlationId = "JOHNNNNN CENNNNAAAA";
            var fContext = new FContext(correlationId);

            Assert.AreEqual(correlationId, fContext.GetRequestHeader("_cid"));
            Assert.AreEqual("5000", fContext.GetRequestHeader("_timeout"));
        }

        [Test]
        public void TestGetCorrelationId()
        {
            var correlationId = "JOHNNNNN CENNNNAAAA";
            var fContext = new FContext(correlationId);

            Assert.AreEqual(correlationId, fContext.GetCorrelationId());
        }

        [Test]
        public void TestAddAndGetRequestHeader()
        {
            var fContext = new FContext();

            fContext.AddRequestHeader("doot", "dootdootdoot");

            Assert.AreEqual("dootdootdoot", fContext.GetRequestHeader("doot"));
        }

        [Test]
        public void TestAddRequestHeaders()
        {
            var fContext = new FContext();
            var headers = new Dictionary<string, string> { { "doot", "dootdootdoot" } };

            fContext.AddRequestHeaders(headers);

            Assert.AreEqual("dootdootdoot", fContext.GetRequestHeader("doot"));
        }

        [Test]
        public void TestGetRequestHeaders()
        {
            var fContext = new FContext();
            fContext.AddRequestHeader("doot", "dootdootdoot");

            var headers = fContext.GetRequestHeaders();

            Assert.IsTrue(headers.ContainsKey("_cid"));
            Assert.IsTrue(headers.ContainsKey("_opid"));
            Assert.IsTrue(headers.ContainsKey("_timeout"));
            Assert.AreEqual("dootdootdoot", fContext.GetRequestHeader("doot"));
        }

        [Test]
        public void TestAddAndGetResponseHeaders()
        {
            var fContext = new FContext();

            fContext.AddResponseHeader("doot", "dootdootdoot");

            Assert.AreEqual("dootdootdoot", fContext.GetResponseHeader("doot"));
        }

        [Test]
        public void TestGetResponseHeaders()
        {
            var fContext = new FContext();
            fContext.AddResponseHeader("doot", "dootdootdoot");

            var headers = fContext.GetResponseHeaders();

            Assert.AreEqual("dootdootdoot", headers["doot"]);
        }

        [Test]
        public void TestSetAndGetTimout()
        {
            var fContext = new FContext();

            fContext.SetTimeout(10000);

            Assert.AreEqual("10000", fContext.GetRequestHeaders()["_timeout"]);
            Assert.AreEqual(10000, fContext.GetTimeout());
        }

        [Test]
        public void TestCreateWithRequestHeaders()
        {
            var dictionary = new Dictionary<string, string>
            {
                {"champ", "cant see me"},
                {"_cid", "cena"},
                {"_timeout", "10000"}
            };
            var fContext = FContext.WithRequestHeaders(dictionary);

            var headers = fContext.GetRequestHeaders();

            Assert.AreEqual("cena", headers["_cid"]);
            Assert.IsTrue(headers.ContainsKey("_opid"));
            Assert.AreEqual(10000L, fContext.GetTimeout());
            Assert.AreEqual("cant see me", fContext.GetRequestHeader("champ"));
        }
    }
}
