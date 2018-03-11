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
        public void TestAddRequestHeader()
        {
            var fContext = new FContext();

            fContext.AddRequestHeader("doot", "dootdootdoot");

            Assert.AreEqual("doot", fContext.GetRequestHeader("dootdootdoot"));
        }
    }
}
