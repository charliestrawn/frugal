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
    public class FNatsTransportTest
    {
        [Test]
        public void TestOpenNatsDisconnectedThrowsTTransportException()
        {
            var mockConn = new Mock<IConnection>();
            mockConn.Setup(x => x.State).Returns(ConnState.CLOSED);
            var transport = new FNatsTransport(mockConn.Object, "testSubject", "testInbox");
            
            Assert.IsFalse(transport.IsOpen);
            Assert.Throws<TTransportException>(() => transport.Open());
        }

        [Test]
        public void TestFlush()
        {
            var mockConn = new Mock<IConnection>();
            var mockSub = new Mock<IAsyncSubscription>();
            mockConn.Setup(x => x.State).Returns(ConnState.CONNECTED);
            mockConn.Setup(x => x.SubscribeAsync("testInbox", It.IsAny<EventHandler<MsgHandlerEventArgs>>()))
                .Returns(mockSub.Object);
            var transport = new FNatsTransport(mockConn.Object, "testSubject", "testInbox");
            
            transport.Open();

            var buffer = Encoding.ASCII.GetBytes("helloworld");
            transport.Flush(buffer);
            
            mockConn.Verify(x => x.Publish("testSubject", "testInbox", buffer));
        }
        
        [Test]
        public void TestClose()
        {
            var mockConn = new Mock<IConnection>();
            var mockSub = new Mock<IAsyncSubscription>();
            mockConn.Setup(x => x.State).Returns(ConnState.CONNECTED);
            mockConn.Setup(x => x.SubscribeAsync("testInbox", It.IsAny<EventHandler<MsgHandlerEventArgs>>()))
                .Returns(mockSub.Object);
            var transport = new FNatsTransport(mockConn.Object, "testSubject", "testInbox");
            
            transport.Open();

            var buffer = Encoding.ASCII.GetBytes("helloworld");
            transport.Close();
            
            mockSub.Verify(x => x.Unsubscribe());
        }
    }
}