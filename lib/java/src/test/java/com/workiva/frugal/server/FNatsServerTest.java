package com.workiva.frugal.server;

import com.workiva.frugal.middleware.ServiceMiddleware;
import com.workiva.frugal.processor.FProcessor;
import com.workiva.frugal.protocol.FProtocol;
import com.workiva.frugal.protocol.FProtocolFactory;
import io.nats.client.Connection;
import io.nats.client.Dispatcher;
import io.nats.client.Message;
import io.nats.client.MessageHandler;
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TJSONProtocol;
import org.apache.thrift.transport.TMemoryInputTransport;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import org.mockito.ArgumentCaptor;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

/**
 * Tests for {@link FNatsServer}.
 */
@RunWith(JUnit4.class)
public class FNatsServerTest {

    private Connection mockConn;
    private FProcessor mockProcessor;
    private FProtocolFactory mockProtocolFactory;
    private String subject = "foo";
    private String queue = "bar";
    private FNatsServer server;

    @Before
    public void setUp() {
        mockConn = mock(Connection.class);
        mockProcessor = mock(FProcessor.class);
        mockProtocolFactory = mock(FProtocolFactory.class);
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
                .withQueueGroup(queue).build();
    }

    @Test
    public void testBuilderConfiguresServer() {
        FNatsServer server =
                new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
                        .withHighWatermark(7)
                        .withQueueGroup("myQueue")
                        .withQueueLength(7)
                        .withWorkerCount(10)
                        .build();

        assertEquals(server.getQueue(), "myQueue");
        assertEquals(((ThreadPoolExecutor) server.getExecutorService()).getQueue().remainingCapacity(), 7);
        assertEquals(((ThreadPoolExecutor) server.getExecutorService()).getMaximumPoolSize(), 10);
    }

    @Test
    public void testServe() throws TException, InterruptedException {
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
                .withQueueGroup(queue).build();
        ArgumentCaptor<String> subjectCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<String> queueCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<MessageHandler> handlerCaptor = ArgumentCaptor.forClass(MessageHandler.class);
        Dispatcher mockDispatcher = mock(Dispatcher.class);
        when(mockConn.createDispatcher(handlerCaptor.capture())).thenReturn(mockDispatcher);

        CountDownLatch stopSignal = new CountDownLatch(1);

        // start/stop the server
        new Thread(() -> {
            try {
                server.serve();
                stopSignal.countDown(); // signal server stop
            } catch (TException e) {
                fail(e.getMessage());
            }
        }).start();
        server.stop();

        stopSignal.await(); // wait for orderly shutdown
        verify(mockDispatcher).subscribe(subjectCaptor.capture(), queueCaptor.capture());

        assertEquals(subject, subjectCaptor.getValue());
        assertEquals(queue, queueCaptor.getValue());
        assertNotNull(handlerCaptor.getValue());
        verify(mockConn).closeDispatcher(mockDispatcher);
        assertEquals(subject, subjectCaptor.getValue());
    }

    @Test(timeout = 5000)
    public void testCallingServeAfterStopDoesNotBlock() throws Exception {
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
            .withQueueGroup(queue).build();
        Dispatcher mockDispatcher = mock(Dispatcher.class);
        when(mockConn.createDispatcher(any())).thenReturn(mockDispatcher);
        server.stop();
        server.serve();
    }

    @Test(timeout = 5000)
    public void testCallingStopTwiceDoesNotBlock() throws Exception {
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
            .withQueueGroup(queue).build();
        Dispatcher mockDispatcher = mock(Dispatcher.class);
        when(mockConn.createDispatcher(any())).thenReturn(mockDispatcher);
        server.stop();
        server.stop();
    }

    @Test(timeout = 5000)
    public void testCallingStopWithoutServerDoesNotBlock() throws Exception {
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
            .withQueueGroup(queue).build();
        Dispatcher mockDispatcher = mock(Dispatcher.class);
        when(mockConn.createDispatcher(any())).thenReturn(mockDispatcher);
        server.stop();
    }

    @Test(timeout = 5000)
    public void testInterruptingServerExitsWithoutStopping() throws Exception {
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
                .withQueueGroup(queue).build();
        Dispatcher mockDispatcher = mock(Dispatcher.class);
        when(mockConn.createDispatcher(any())).thenReturn(mockDispatcher);

        CountDownLatch stopSignal = new CountDownLatch(1);

        // start/stop the server
        Thread firstServeThread = new Thread(() -> {
            try {
                server.serve();
                stopSignal.countDown(); // signal server stop
            } catch (TException e) {
                fail(e.getMessage());
            }
        });

        Thread secondServeThread = new Thread(() -> {
            try {
                server.serve();
                fail("second serve should not exit");
            } catch (TException e) {
                fail(e.getMessage());
            }
        });
        firstServeThread.start();
        secondServeThread.start();
        firstServeThread.interrupt();
        stopSignal.await(); // wait for orderly shutdown
    }


    @Test
    public void testStopWithDefaultTimeout() throws Exception {
        ExecutorService mockExecutorService = mock(ExecutorService.class);
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
            .withQueueGroup(queue)
            .withExecutorService(mockExecutorService)
            .build();
        server.stop();
        verify(mockExecutorService, times(1)).shutdown();
        verify(mockExecutorService, times(1))
              .awaitTermination(FNatsServer.DEFAULT_STOP_TIMEOUT_NS, TimeUnit.NANOSECONDS);
    }

    @Test
    public void testStopWithBuilderTimeout() throws Exception {
        ExecutorService mockExecutorService = mock(ExecutorService.class);
        server = new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
            .withQueueGroup(queue)
            .withExecutorService(mockExecutorService)
            .withStopTimeout(1, TimeUnit.SECONDS)
            .build();
        server.stop();
        verify(mockExecutorService, times(1)).shutdown();
        verify(mockExecutorService, times(1)).awaitTermination(TimeUnit.SECONDS.toNanos(1), TimeUnit.NANOSECONDS);
    }

    @Test
    public void testRequestHandler() throws InterruptedException  {
        ExecutorService executor = mock(ExecutorService.class);
        FNatsServer server =
                new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
                        .withExecutorService(executor).build();
        MessageHandler handler = server.newRequestHandler();
        String reply = "reply";
        byte[] data = "this is a request".getBytes();
        Message mockMessage = mock(Message.class);
        when(mockMessage.getData()).thenReturn(data);
        when(mockMessage.getReplyTo()).thenReturn(reply);
        handler.onMessage(mockMessage);

        ArgumentCaptor<Runnable> captor = ArgumentCaptor.forClass(Runnable.class);
        verify(executor).execute(captor.capture());
        assertEquals(FNatsServer.Request.class, captor.getValue().getClass());
        FNatsServer.Request request = (FNatsServer.Request) captor.getValue();
        assertArrayEquals(data, request.frameBytes);
        assertEquals(reply, request.reply);
        assertEquals(mockProtocolFactory, request.inputProtoFactory);
        assertEquals(mockProtocolFactory, request.outputProtoFactory);
        assertEquals(mockProcessor, request.processor);
        assertEquals(mockConn, request.conn);
    }

    @Test
    public void testRequestHandlerNoReply() throws InterruptedException  {
        ExecutorService executor = mock(ExecutorService.class);
        FNatsServer server =
                new FNatsServer.Builder(mockConn, mockProcessor, mockProtocolFactory, new String[]{subject})
                .withExecutorService(executor).build();
        MessageHandler handler = server.newRequestHandler();
        byte[] data = "this is a request".getBytes();
        Message mockMessage = mock(Message.class);
        when(mockMessage.getData()).thenReturn(data);
        when(mockMessage.getReplyTo()).thenReturn(null);
        handler.onMessage(mockMessage);

        verifyNoMoreInteractions(executor);
    }

    @Test
    public void testRequestProcess() {
        byte[] data = "xxxxhello".getBytes();
        long timestamp = System.currentTimeMillis();
        String reply = "reply";
        long highWatermark = 5000;
        MockFProcessor processor = new MockFProcessor(data, "blah".getBytes());
        mockProtocolFactory = new FProtocolFactory(new TJSONProtocol.Factory());
        FNatsServer.Request request = new FNatsServer.Request(data, reply,
                mockProtocolFactory, mockProtocolFactory, processor, mockConn,
                new FDefaultNatsServerEventHandler(5000), new HashMap<>());

        request.run();

        byte[] expected = new byte[]{0, 0, 0, 6, 34, 98, 108, 97, 104, 34};
        verify(mockConn).publish(reply, expected);
    }

    @Test
    public void testRequestProcessRuntimeException() {
        byte[] data = "xxxxhello".getBytes();
        long timestamp = System.currentTimeMillis();
        String reply = "reply";
        long highWatermark = 5000;
        MockFProcessor processor = new MockFProcessor(new RuntimeException());
        mockProtocolFactory = new FProtocolFactory(new TJSONProtocol.Factory());
        FNatsServer.Request request = new FNatsServer.Request(data, reply,
                mockProtocolFactory, mockProtocolFactory, processor, mockConn,
                new FDefaultNatsServerEventHandler(5000), new HashMap<>());

        request.run();

        byte[] expected = new byte[]{0, 0, 0, 0};
        verify(mockConn).publish(reply, expected);
    }

    @Test
    public void testRequestProcess_noResponse() {
        byte[] data = "xxxxhello".getBytes();
        long timestamp = System.currentTimeMillis();
        String reply = "reply";
        long highWatermark = 5000;
        MockFProcessor processor = new MockFProcessor(data, null);
        mockProtocolFactory = new FProtocolFactory(new TJSONProtocol.Factory());
        FNatsServer.Request request = new FNatsServer.Request(data, reply,
                mockProtocolFactory, mockProtocolFactory, processor, mockConn,
                new FDefaultNatsServerEventHandler(5000), new HashMap<>());

        request.run();

        verify(mockConn, times(0)).publish(any(String.class), any(byte[].class));
    }

    private class MockFProcessor implements FProcessor {

        private byte[] expectedIn;
        private byte[] expectedOut;
        private RuntimeException runtimeException;

        public MockFProcessor(byte[] expectedIn, byte[] expectedOut) {
            this.expectedIn = expectedIn;
            this.expectedOut = expectedOut;
        }

        public MockFProcessor(RuntimeException runtimeException) {
            this.runtimeException = runtimeException;
        }

        @Override
        public void process(FProtocol in, FProtocol out) throws TException {
            if (runtimeException != null) {
                throw runtimeException;
            }

            assertTrue(in.getTransport() instanceof TMemoryInputTransport);

            if (expectedIn != null) {
                TMemoryInputTransport transport = (TMemoryInputTransport) in.getTransport();
                byte[] trimmedBuffer = Arrays.copyOfRange(
                        transport.getBuffer(), transport.getBufferPosition(), transport.getBuffer().length);
                assertArrayEquals(Arrays.copyOfRange(expectedIn, 4, expectedIn.length), trimmedBuffer);
            }

            if (expectedOut != null) {
                out.writeString(new String(expectedOut));
            }
        }

        @Override
        public void addMiddleware(ServiceMiddleware middleware) {
        }

        @Override
        public Map<String, Map<String, String>> getAnnotations() {
            return null;
        }
    }

}
