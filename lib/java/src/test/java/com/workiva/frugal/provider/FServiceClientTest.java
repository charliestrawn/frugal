package com.workiva.frugal.provider;

import com.workiva.frugal.FContext;
import com.workiva.frugal.protocol.FProtocol;
import com.workiva.frugal.protocol.FProtocolFactory;
import com.workiva.frugal.transport.FTransport;
import com.workiva.frugal.transport.TMemoryOutputBuffer;
import org.apache.thrift.TBase;
import org.apache.thrift.protocol.TMessage;
import org.apache.thrift.protocol.TMessageType;
import org.apache.thrift.transport.TTransport;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Tests for {@link FServiceClient}.
 */
@RunWith(JUnit4.class)
public class FServiceClientTest {

    @Test
    public void testRequestBase() throws Exception {
        FTransport transport = mock(FTransport.class);
        FProtocolFactory protocolFactory = mock(FProtocolFactory.class);
        FProtocol oprot = mock(FProtocol.class);
        FProtocol iprot = mock(FProtocol.class);
        when(iprot.readMessageBegin()).thenReturn(new TMessage("request", TMessageType.REPLY, 99));
        when(protocolFactory.getProtocol(any(TMemoryOutputBuffer.class))).thenReturn(oprot);
        TTransport response = transport.request(any(FContext.class), any(byte[].class));
        when(protocolFactory.getProtocol(response)).thenReturn(iprot);
        FServiceProvider provider = new FServiceProvider(transport, protocolFactory);
        FContext ctx = new FContext("request");
        TBase<?, ?> args = mock(TBase.class);
        TBase<?, ?> res = mock(TBase.class);

        // Call
        FServiceClient client = new FServiceClient(provider);
        client.requestBase(ctx, "request", args, res);

        // Verify prepareMessage processes request
        verify(transport).getRequestSizeLimit();
        verify(protocolFactory).getProtocol(any(TMemoryOutputBuffer.class));
        verify(oprot).writeRequestHeader(ctx);
        verify(oprot).writeMessageBegin(any(TMessage.class));
        verify(args).write(oprot);
        verify(oprot).writeMessageEnd();

        // Verify the absolutely necessary thing happens
        verify(transport).request(any(FContext.class), any(byte[].class));

        // Verify requestBase processes response
        verify(protocolFactory).getProtocol(response);
        verify(iprot).readResponseHeader(ctx);
        verify(iprot).readMessageBegin();
        verify(res).read(iprot);
        verify(iprot).readMessageEnd();
    }

    @Test
    public void testOnewayBase() throws Exception {
        FTransport transport = mock(FTransport.class);
        FProtocolFactory protocolFactory = mock(FProtocolFactory.class);
        FProtocol oprot = mock(FProtocol.class);
        when(protocolFactory.getProtocol(any(TMemoryOutputBuffer.class))).thenReturn(oprot);
        FServiceProvider provider = new FServiceProvider(transport, protocolFactory);
        FContext ctx = new FContext("oneway");
        TBase<?, ?> args = mock(TBase.class);

        // Call
        FServiceClient client = new FServiceClient(provider);
        client.onewayBase(ctx, "oneway", args);

        // Verify prepareMessage processes request
        verify(transport).getRequestSizeLimit();
        verify(protocolFactory).getProtocol(any(TMemoryOutputBuffer.class));
        verify(oprot).writeRequestHeader(ctx);
        verify(oprot).writeMessageBegin(any(TMessage.class));
        verify(args).write(oprot);
        verify(oprot).writeMessageEnd();

        // Verify the absolutely necessary thing happens
        verify(transport).oneway(any(FContext.class), any(byte[].class));
    }
}
