/**
 * Autogenerated by Frugal Compiler (1.0.0-RC2)
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */

package foo;

import com.workiva.frugal.FContext;
import com.workiva.frugal.FScopeProvider;
import com.workiva.frugal.FSubscription;
import com.workiva.frugal.FProtocol;
import com.workiva.frugal.transport.FScopeTransport;
import org.apache.thrift.TException;
import org.apache.thrift.TApplicationException;
import org.apache.thrift.transport.TTransportException;
import org.apache.thrift.protocol.*;

import javax.annotation.Generated;
import java.util.logging.Logger;




/**
 * And this is a scope docstring.
 */
@Generated(value = "Autogenerated by Frugal Compiler (1.0.0-RC2)", date = "2015-11-24")
public class FooPublisher {

	private static final String DELIMITER = ".";

	private final FScopeProvider provider;
	private FScopeTransport transport;
	private FProtocol protocol;

	public FooPublisher(FScopeProvider provider) {
		this.provider = provider;
	}

	public void open() throws TException {
		FScopeProvider.Client client = provider.build();
		transport = client.getTransport();
		protocol = client.getProtocol();
		transport.open();
	}

	public void close() throws TException {
		transport.close();
	}

	/**
	 * This is an operation docstring.
	 */
	public void publishFoo(FContext ctx, String baz, Thing req) throws TException {
		String op = "Foo";
		String prefix = String.format("foo.bar.%s.qux.", baz);
		String topic = String.format("%sFoo%s%s", prefix, DELIMITER, op);
		transport.lockTopic(topic);
		try {
			protocol.writeRequestHeader(ctx);
			protocol.writeMessageBegin(new TMessage(op, TMessageType.CALL, 0));
			req.write(protocol);
			protocol.writeMessageEnd();
			transport.flush();
		} catch (TException e) {
			close();
			throw e;
		} finally {
			transport.unlockTopic();
		}
	}


	public void publishBar(FContext ctx, String baz, Stuff req) throws TException {
		String op = "Bar";
		String prefix = String.format("foo.bar.%s.qux.", baz);
		String topic = String.format("%sFoo%s%s", prefix, DELIMITER, op);
		transport.lockTopic(topic);
		try {
			protocol.writeRequestHeader(ctx);
			protocol.writeMessageBegin(new TMessage(op, TMessageType.CALL, 0));
			req.write(protocol);
			protocol.writeMessageEnd();
			transport.flush();
		} catch (TException e) {
			close();
			throw e;
		} finally {
			transport.unlockTopic();
		}
	}
}
