/**
 * Autogenerated by Frugal Compiler (3.14.15)
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *
 * @generated
 */


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

public class InvalidData extends TException implements org.apache.thrift.TBase<InvalidData, InvalidData._Fields>, java.io.Serializable, Cloneable, Comparable<InvalidData> {
	private static final org.apache.thrift.protocol.TStruct STRUCT_DESC = new org.apache.thrift.protocol.TStruct("InvalidData");

	private static final org.apache.thrift.protocol.TField CODE_FIELD_DESC = new org.apache.thrift.protocol.TField("code", org.apache.thrift.protocol.TType.I32, (short)1);
	private static final org.apache.thrift.protocol.TField WHY_FIELD_DESC = new org.apache.thrift.protocol.TField("why", org.apache.thrift.protocol.TType.STRING, (short)2);

	public int code;
	public String why;
	/** The set of fields this struct contains, along with convenience methods for finding and manipulating them. */
	public enum _Fields implements org.apache.thrift.TFieldIdEnum {
		CODE((short)1, "code"),
		WHY((short)2, "why")
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
				case 1: // CODE
					return CODE;
				case 2: // WHY
					return WHY;
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
	private static final int __CODE_ISSET_ID = 0;
	private byte __isset_bitfield = 0;
	public InvalidData() {
	}

	public InvalidData(
		int code,
		String why) {
		this();
		this.code = code;
		setCodeIsSet(true);
		this.why = why;
	}

	/**
	 * Performs a deep copy on <i>other</i>.
	 */
	public InvalidData(InvalidData other) {
		__isset_bitfield = other.__isset_bitfield;
		this.code = other.code;
		if (other.isSetWhy()) {
			this.why = other.why;
		}
	}

	public InvalidData deepCopy() {
		return new InvalidData(this);
	}

	@Override
	public void clear() {
		setCodeIsSet(false);
		this.code = 0;

		this.why = null;

	}

	public int getCode() {
		return this.code;
	}

	public InvalidData setCode(int code) {
		this.code = code;
		setCodeIsSet(true);
		return this;
	}

	public void unsetCode() {
		__isset_bitfield = EncodingUtils.clearBit(__isset_bitfield, __CODE_ISSET_ID);
	}

	/** Returns true if field code is set (has been assigned a value) and false otherwise */
	public boolean isSetCode() {
		return EncodingUtils.testBit(__isset_bitfield, __CODE_ISSET_ID);
	}

	public void setCodeIsSet(boolean value) {
		__isset_bitfield = EncodingUtils.setBit(__isset_bitfield, __CODE_ISSET_ID, value);
	}

	public String getWhy() {
		return this.why;
	}

	public InvalidData setWhy(String why) {
		this.why = why;
		return this;
	}

	public void unsetWhy() {
		this.why = null;
	}

	/** Returns true if field why is set (has been assigned a value) and false otherwise */
	public boolean isSetWhy() {
		return this.why != null;
	}

	public void setWhyIsSet(boolean value) {
		if (!value) {
			this.why = null;
		}
	}

	public void setFieldValue(_Fields field, Object value) {
		switch (field) {
		case CODE:
			if (value == null) {
				unsetCode();
			} else {
				setCode((Integer)value);
			}
			break;

		case WHY:
			if (value == null) {
				unsetWhy();
			} else {
				setWhy((String)value);
			}
			break;

		}
	}

	public Object getFieldValue(_Fields field) {
		switch (field) {
		case CODE:
			return getCode();

		case WHY:
			return getWhy();

		}
		throw new IllegalStateException();
	}

	/** Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise */
	public boolean isSet(_Fields field) {
		if (field == null) {
			throw new IllegalArgumentException();
		}

		switch (field) {
		case CODE:
			return isSetCode();
		case WHY:
			return isSetWhy();
		}
		throw new IllegalStateException();
	}

	@Override
	public boolean equals(Object that) {
		if (that == null)
			return false;
		if (that instanceof InvalidData)
			return this.equals((InvalidData)that);
		return false;
	}

	public boolean equals(InvalidData that) {
		if (that == null)
			return false;
		if (this.code != that.code)
			return false;
		if (!Objects.equals(this.why, that.why))
			return false;
		return true;
	}

	@Override
	public int hashCode() {
		List<Object> list = new ArrayList<Object>();

		boolean present_code = true;
		list.add(present_code);
		if (present_code)
			list.add(code);

		boolean present_why = true && (isSetWhy());
		list.add(present_why);
		if (present_why)
			list.add(why);

		return list.hashCode();
	}

	@Override
	public int compareTo(InvalidData other) {
		if (!getClass().equals(other.getClass())) {
			return getClass().getName().compareTo(other.getClass().getName());
		}

		int lastComparison = 0;

		lastComparison = Boolean.compare(isSetCode(), other.isSetCode());
		if (lastComparison != 0) {
			return lastComparison;
		}
		if (isSetCode()) {
			lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.code, other.code);
			if (lastComparison != 0) {
				return lastComparison;
			}
		}
		lastComparison = Boolean.compare(isSetWhy(), other.isSetWhy());
		if (lastComparison != 0) {
			return lastComparison;
		}
		if (isSetWhy()) {
			lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.why, other.why);
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
		new InvalidDataStandardScheme().read(iprot, this);
	}

	public void write(org.apache.thrift.protocol.TProtocol oprot) throws org.apache.thrift.TException {
		if (oprot.getScheme() != StandardScheme.class) {
			throw new UnsupportedOperationException();
		}
		new InvalidDataStandardScheme().write(oprot, this);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("InvalidData(");
		boolean first = true;

		sb.append("code:");
		sb.append(this.code);
		first = false;
		if (!first) sb.append(", ");
		sb.append("why:");
		sb.append(this.why);
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

	private static class InvalidDataStandardScheme extends StandardScheme<InvalidData> {

		public void read(org.apache.thrift.protocol.TProtocol iprot, InvalidData struct) throws org.apache.thrift.TException {
			org.apache.thrift.protocol.TField schemeField;
			iprot.readStructBegin();
			while (true) {
				schemeField = iprot.readFieldBegin();
				if (schemeField.type == org.apache.thrift.protocol.TType.STOP) {
					break;
				}
				switch (schemeField.id) {
					case 1: // CODE
						if (schemeField.type == org.apache.thrift.protocol.TType.I32) {
							struct.code = iprot.readI32();
							struct.setCodeIsSet(true);
						} else {
							org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
						}
						break;
					case 2: // WHY
						if (schemeField.type == org.apache.thrift.protocol.TType.STRING) {
							struct.why = iprot.readString();
							struct.setWhyIsSet(true);
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

		public void write(org.apache.thrift.protocol.TProtocol oprot, InvalidData struct) throws org.apache.thrift.TException {
			struct.validate();

			oprot.writeStructBegin(STRUCT_DESC);
			oprot.writeFieldBegin(CODE_FIELD_DESC);
			int elem2 = struct.code;
			oprot.writeI32(elem2);
			oprot.writeFieldEnd();
			if (struct.isSetWhy()) {
				oprot.writeFieldBegin(WHY_FIELD_DESC);
				String elem3 = struct.why;
				oprot.writeString(elem3);
				oprot.writeFieldEnd();
			}
			oprot.writeFieldStop();
			oprot.writeStructEnd();
		}

	}

}
