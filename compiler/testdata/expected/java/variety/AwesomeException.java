/**
 * Autogenerated by Frugal Compiler (3.14.9)
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *
 * @generated
 */
package variety.java;

import org.apache.thrift.scheme.IScheme;
import org.apache.thrift.scheme.SchemeFactory;
import org.apache.thrift.scheme.StandardScheme;

import org.apache.thrift.scheme.TupleScheme;
import org.apache.thrift.protocol.TTupleProtocol;
import org.apache.thrift.protocol.TProtocolException;
import org.apache.thrift.EncodingUtils;
import org.apache.thrift.TException;
import org.apache.thrift.async.AsyncMethodCallback;
import org.apache.thrift.server.AbstractNonblockingServer.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.EnumMap;
import java.util.Set;
import java.util.HashSet;
import java.util.EnumSet;
import java.util.Collections;
import java.util.BitSet;
import java.util.Objects;
import java.nio.ByteBuffer;
import java.util.Arrays;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AwesomeException extends TException implements org.apache.thrift.TBase<AwesomeException, AwesomeException._Fields>, java.io.Serializable, Cloneable, Comparable<AwesomeException> {
	private static final org.apache.thrift.protocol.TStruct STRUCT_DESC = new org.apache.thrift.protocol.TStruct("AwesomeException");

	private static final org.apache.thrift.protocol.TField ID_FIELD_DESC = new org.apache.thrift.protocol.TField("ID", org.apache.thrift.protocol.TType.I64, (short)1);
	private static final org.apache.thrift.protocol.TField REASON_FIELD_DESC = new org.apache.thrift.protocol.TField("Reason", org.apache.thrift.protocol.TType.STRING, (short)2);
	private static final org.apache.thrift.protocol.TField DEPR_FIELD_DESC = new org.apache.thrift.protocol.TField("depr", org.apache.thrift.protocol.TType.BOOL, (short)3);

	/**
	 * ID is a unique identifier for an awesome exception.
	 */
	public long ID;
	/**
	 * Reason contains the error message.
	 */
	public String Reason;
	/**
	 * @deprecated use something else
	 */
	@Deprecated
	public boolean depr;
	/** The set of fields this struct contains, along with convenience methods for finding and manipulating them. */
	public enum _Fields implements org.apache.thrift.TFieldIdEnum {
		/**
		 * ID is a unique identifier for an awesome exception.
		 */
		ID((short)1, "ID"),
		/**
		 * Reason contains the error message.
		 */
		REASON((short)2, "Reason"),
		DEPR((short)3, "depr")
		;

		private static final Map<String, _Fields> byName = new HashMap<String, _Fields>();

		static {
			for (_Fields field : EnumSet.allOf(_Fields.class)) {
				byName.put(field.getFieldName(), field);
			}
		}

		/**
		 * Find the _Fields constant that matches fieldId, or null if its not found.
		 */
		public static _Fields findByThriftId(int fieldId) {
			switch(fieldId) {
				case 1: // ID
					return ID;
				case 2: // REASON
					return REASON;
				case 3: // DEPR
					return DEPR;
				default:
					return null;
			}
		}

		/**
		 * Find the _Fields constant that matches fieldId, throwing an exception
		 * if it is not found.
		 */
		public static _Fields findByThriftIdOrThrow(int fieldId) {
			_Fields fields = findByThriftId(fieldId);
			if (fields == null) throw new IllegalArgumentException("Field " + fieldId + " doesn't exist!");
			return fields;
		}

		/**
		 * Find the _Fields constant that matches name, or null if its not found.
		 */
		public static _Fields findByName(String name) {
			return byName.get(name);
		}

		private final short _thriftId;
		private final String _fieldName;

		_Fields(short thriftId, String fieldName) {
			_thriftId = thriftId;
			_fieldName = fieldName;
		}

		public short getThriftFieldId() {
			return _thriftId;
		}

		public String getFieldName() {
			return _fieldName;
		}
	}

	// isset id assignments
	private static final int __ID_ISSET_ID = 0;
	private static final int __DEPR_ISSET_ID = 1;
	private byte __isset_bitfield = 0;
	public AwesomeException() {
	}

	public AwesomeException(
		long ID,
		String Reason,
		boolean depr) {
		this();
		this.ID = ID;
		setIDIsSet(true);
		this.Reason = Reason;
		this.depr = depr;
		setDeprIsSet(true);
	}

	/**
	 * Performs a deep copy on <i>other</i>.
	 */
	public AwesomeException(AwesomeException other) {
		__isset_bitfield = other.__isset_bitfield;
		this.ID = other.ID;
		if (other.isSetReason()) {
			this.Reason = other.Reason;
		}
		this.depr = other.depr;
	}

	public AwesomeException deepCopy() {
		return new AwesomeException(this);
	}

	@Override
	public void clear() {
		setIDIsSet(false);
		this.ID = 0L;

		this.Reason = null;

		setDeprIsSet(false);
		this.depr = false;

	}

	/**
	 * ID is a unique identifier for an awesome exception.
	 */
	public long getID() {
		return this.ID;
	}

	/**
	 * ID is a unique identifier for an awesome exception.
	 */
	public AwesomeException setID(long ID) {
		this.ID = ID;
		setIDIsSet(true);
		return this;
	}

	public void unsetID() {
		__isset_bitfield = EncodingUtils.clearBit(__isset_bitfield, __ID_ISSET_ID);
	}

	/** Returns true if field ID is set (has been assigned a value) and false otherwise */
	public boolean isSetID() {
		return EncodingUtils.testBit(__isset_bitfield, __ID_ISSET_ID);
	}

	public void setIDIsSet(boolean value) {
		__isset_bitfield = EncodingUtils.setBit(__isset_bitfield, __ID_ISSET_ID, value);
	}

	/**
	 * Reason contains the error message.
	 */
	public String getReason() {
		return this.Reason;
	}

	/**
	 * Reason contains the error message.
	 */
	public AwesomeException setReason(String Reason) {
		this.Reason = Reason;
		return this;
	}

	public void unsetReason() {
		this.Reason = null;
	}

	/** Returns true if field Reason is set (has been assigned a value) and false otherwise */
	public boolean isSetReason() {
		return this.Reason != null;
	}

	public void setReasonIsSet(boolean value) {
		if (!value) {
			this.Reason = null;
		}
	}

	@Deprecated
	public boolean isDepr() {
		return this.depr;
	}

	@Deprecated
	public AwesomeException setDepr(boolean depr) {
		this.depr = depr;
		setDeprIsSet(true);
		return this;
	}

	@Deprecated
	public void unsetDepr() {
		__isset_bitfield = EncodingUtils.clearBit(__isset_bitfield, __DEPR_ISSET_ID);
	}

	/** Returns true if field depr is set (has been assigned a value) and false otherwise */
	@Deprecated
	public boolean isSetDepr() {
		return EncodingUtils.testBit(__isset_bitfield, __DEPR_ISSET_ID);
	}

	@Deprecated
	public void setDeprIsSet(boolean value) {
		__isset_bitfield = EncodingUtils.setBit(__isset_bitfield, __DEPR_ISSET_ID, value);
	}

	public void setFieldValue(_Fields field, Object value) {
		switch (field) {
		case ID:
			if (value == null) {
				unsetID();
			} else {
				setID((Long)value);
			}
			break;

		case REASON:
			if (value == null) {
				unsetReason();
			} else {
				setReason((String)value);
			}
			break;

		case DEPR:
			if (value == null) {
				unsetDepr();
			} else {
				setDepr((Boolean)value);
			}
			break;

		}
	}

	public Object getFieldValue(_Fields field) {
		switch (field) {
		case ID:
			return getID();

		case REASON:
			return getReason();

		case DEPR:
			return isDepr();

		}
		throw new IllegalStateException();
	}

	/** Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise */
	public boolean isSet(_Fields field) {
		if (field == null) {
			throw new IllegalArgumentException();
		}

		switch (field) {
		case ID:
			return isSetID();
		case REASON:
			return isSetReason();
		case DEPR:
			return isSetDepr();
		}
		throw new IllegalStateException();
	}

	@Override
	public boolean equals(Object that) {
		if (that == null)
			return false;
		if (that instanceof AwesomeException)
			return this.equals((AwesomeException)that);
		return false;
	}

	public boolean equals(AwesomeException that) {
		if (that == null)
			return false;
		if (this.ID != that.ID)
			return false;
		if (!Objects.equals(this.Reason, that.Reason))
			return false;
		if (this.depr != that.depr)
			return false;
		return true;
	}

	@Override
	public int hashCode() {
		List<Object> list = new ArrayList<Object>();

		boolean present_ID = true;
		list.add(present_ID);
		if (present_ID)
			list.add(ID);

		boolean present_Reason = true && (isSetReason());
		list.add(present_Reason);
		if (present_Reason)
			list.add(Reason);

		boolean present_depr = true;
		list.add(present_depr);
		if (present_depr)
			list.add(depr);

		return list.hashCode();
	}

	@Override
	public int compareTo(AwesomeException other) {
		if (!getClass().equals(other.getClass())) {
			return getClass().getName().compareTo(other.getClass().getName());
		}

		int lastComparison = 0;

		lastComparison = Boolean.compare(isSetID(), other.isSetID());
		if (lastComparison != 0) {
			return lastComparison;
		}
		if (isSetID()) {
			lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.ID, other.ID);
			if (lastComparison != 0) {
				return lastComparison;
			}
		}
		lastComparison = Boolean.compare(isSetReason(), other.isSetReason());
		if (lastComparison != 0) {
			return lastComparison;
		}
		if (isSetReason()) {
			lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.Reason, other.Reason);
			if (lastComparison != 0) {
				return lastComparison;
			}
		}
		lastComparison = Boolean.compare(isSetDepr(), other.isSetDepr());
		if (lastComparison != 0) {
			return lastComparison;
		}
		if (isSetDepr()) {
			lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.depr, other.depr);
			if (lastComparison != 0) {
				return lastComparison;
			}
		}
		return 0;
	}

	public _Fields fieldForId(int fieldId) {
		return _Fields.findByThriftId(fieldId);
	}

	public void read(org.apache.thrift.protocol.TProtocol iprot) throws org.apache.thrift.TException {
		if (iprot.getScheme() != StandardScheme.class) {
			throw new UnsupportedOperationException();
		}
		new AwesomeExceptionStandardScheme().read(iprot, this);
	}

	public void write(org.apache.thrift.protocol.TProtocol oprot) throws org.apache.thrift.TException {
		if (oprot.getScheme() != StandardScheme.class) {
			throw new UnsupportedOperationException();
		}
		new AwesomeExceptionStandardScheme().write(oprot, this);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("AwesomeException(");
		boolean first = true;

		sb.append("ID:");
		sb.append(this.ID);
		first = false;
		if (!first) sb.append(", ");
		sb.append("Reason:");
		sb.append(this.Reason);
		first = false;
		if (!first) sb.append(", ");
		sb.append("depr:");
		sb.append(this.depr);
		first = false;
		sb.append(")");
		return sb.toString();
	}

	public void validate() throws org.apache.thrift.TException {
		// check for required fields
		// check for sub-struct validity
	}

	private void writeObject(java.io.ObjectOutputStream out) throws java.io.IOException {
		try {
			write(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(out)));
		} catch (org.apache.thrift.TException te) {
			throw new java.io.IOException(te);
		}
	}

	private void readObject(java.io.ObjectInputStream in) throws java.io.IOException, ClassNotFoundException {
		try {
			// it doesn't seem like you should have to do this, but java serialization is wacky, and doesn't call the default constructor.
			__isset_bitfield = 0;
			read(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(in)));
		} catch (org.apache.thrift.TException te) {
			throw new java.io.IOException(te);
		}
	}

	private static class AwesomeExceptionStandardScheme extends StandardScheme<AwesomeException> {

		public void read(org.apache.thrift.protocol.TProtocol iprot, AwesomeException struct) throws org.apache.thrift.TException {
			org.apache.thrift.protocol.TField schemeField;
			iprot.readStructBegin();
			while (true) {
				schemeField = iprot.readFieldBegin();
				if (schemeField.type == org.apache.thrift.protocol.TType.STOP) {
					break;
				}
				switch (schemeField.id) {
					case 1: // ID
						if (schemeField.type == org.apache.thrift.protocol.TType.I64) {
							struct.ID = iprot.readI64();
							struct.setIDIsSet(true);
						} else {
							org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
						}
						break;
					case 2: // REASON
						if (schemeField.type == org.apache.thrift.protocol.TType.STRING) {
							struct.Reason = iprot.readString();
							struct.setReasonIsSet(true);
						} else {
							org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
						}
						break;
					case 3: // DEPR
						if (schemeField.type == org.apache.thrift.protocol.TType.BOOL) {
							struct.depr = iprot.readBool();
							struct.setDeprIsSet(true);
						} else {
							org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
						}
						break;
					default:
						org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
				}
				iprot.readFieldEnd();
			}
			iprot.readStructEnd();

			// check for required fields of primitive type, which can't be checked in the validate method
			struct.validate();
		}

		public void write(org.apache.thrift.protocol.TProtocol oprot, AwesomeException struct) throws org.apache.thrift.TException {
			struct.validate();

			oprot.writeStructBegin(STRUCT_DESC);
			oprot.writeFieldBegin(ID_FIELD_DESC);
			long elem155 = struct.ID;
			oprot.writeI64(elem155);
			oprot.writeFieldEnd();
			if (struct.isSetReason()) {
				oprot.writeFieldBegin(REASON_FIELD_DESC);
				String elem156 = struct.Reason;
				oprot.writeString(elem156);
				oprot.writeFieldEnd();
			}
			oprot.writeFieldBegin(DEPR_FIELD_DESC);
			boolean elem157 = struct.depr;
			oprot.writeBool(elem157);
			oprot.writeFieldEnd();
			oprot.writeFieldStop();
			oprot.writeStructEnd();
		}

	}

}
