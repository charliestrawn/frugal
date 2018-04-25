using System;
using System.Text;
using frugal.Transport;
using Moq;
using NATS.Client;
using NUnit.Framework;
using Thrift.Transport;

namespace frugal.Test.Transport
{
    [TestFixture]
    public class FNatsPublisherTransportTest
    {
        [Test]
        public void TestIsOpen()
        {
            var mockConn = new Mock<IConnection>();
            mockConn.Setup(x => x.State).Returns(ConnState.CONNECTED);
            var transport = new FNatsPublisherTransport(mockConn.Object);
            
            Assert.IsTrue(transport.IsOpen);
        }

        [Test]
        public void TestOpenThrowsIfNotOpen()
        {
            var mockConn = new Mock<IConnection>();
            mockConn.Setup(x => x.State).Returns(ConnState.CLOSED);
            var transport = new FNatsPublisherTransport(mockConn.Object);

            Assert.Throws<TTransportException>(() => transport.Open());
        }
        
        [Test]
        public void TestPublishThrowsIfNotOpen()
        {
            var mockConn = new Mock<IConnection>();
            mockConn.Setup(x => x.State).Returns(ConnState.CLOSED);
            var transport = new FNatsPublisherTransport(mockConn.Object);

            var buffer = Encoding.ASCII.GetBytes("helloworld");
            Assert.Throws<TTransportException>(() => transport.Publish("", buffer));
        }
        
        [Test]
        public void TestPublishThrowsEmptySubject()
        {
            var mockConn = new Mock<IConnection>();
            mockConn.Setup(x => x.State).Returns(ConnState.CONNECTED);
            var transport = new FNatsPublisherTransport(mockConn.Object);
            
            transport.Open();

            var buffer = Encoding.ASCII.GetBytes("helloworld");
            Assert.Throws<TTransportException>(() => transport.Publish("", buffer));
        }
        
        [Test]
        public void TestPublish()
        {
            var mockConn = new Mock<IConnection>();
            mockConn.Setup(x => x.State).Returns(ConnState.CONNECTED);
            var transport = new FNatsPublisherTransport(mockConn.Object);
            
            transport.Open();

            var buffer = Encoding.ASCII.GetBytes("helloworld");
            transport.Publish("testSubject", buffer);
            
            mockConn.Verify(x => x.Publish("testSubject", buffer));
        }
    }
}