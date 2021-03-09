// Autogenerated by Frugal Compiler (3.14.0)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

// ignore_for_file: unused_import
// ignore_for_file: unused_field
import 'dart:typed_data' show Uint8List;

import 'package:collection/collection.dart';
import 'package:thrift/thrift.dart' as thrift;
import 'package:frugal_test/frugal_test.dart' as t_frugal_test;

class Event implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('Event');
  static final thrift.TField _ID_FIELD_DESC = thrift.TField('ID', thrift.TType.I64, 1);
  static final thrift.TField _MESSAGE_FIELD_DESC = thrift.TField('Message', thrift.TType.STRING, 2);

  /// ID is a unique identifier for an event.
  int _iD = 0;
  static const int ID = 1;
  /// Message contains the event payload.
  String _message;
  static const int MESSAGE = 2;

  bool __isset_iD = false;

  Event() {
    this._iD = t_frugal_test.FrugalTestConstants.DEFAULT_ID;
  }

  /// ID is a unique identifier for an event.
  int get iD => this._iD;

  /// ID is a unique identifier for an event.
  set iD(int iD) {
    this._iD = iD;
    this.__isset_iD = true;
  }

  bool isSetID() => this.__isset_iD;

  unsetID() {
    this.__isset_iD = false;
  }

  /// Message contains the event payload.
  String get message => this._message;

  /// Message contains the event payload.
  set message(String message) {
    this._message = message;
  }

  bool isSetMessage() => this.message != null;

  unsetMessage() {
    this.message = null;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case ID:
        return this.iD;
      case MESSAGE:
        return this.message;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case ID:
        if (value == null) {
          unsetID();
        } else {
          this.iD = value as int;
        }
        break;

      case MESSAGE:
        if (value == null) {
          unsetMessage();
        } else {
          this.message = value as String;
        }
        break;

      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  // Returns true if the field corresponding to fieldID is set (has been assigned a value) and false otherwise
  @override
  bool isSet(int fieldID) {
    switch (fieldID) {
      case ID:
        return isSetID();
      case MESSAGE:
        return isSetMessage();
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  read(thrift.TProtocol iprot) {
    iprot.readStructBegin();
    for (thrift.TField field = iprot.readFieldBegin();
        field.type != thrift.TType.STOP;
        field = iprot.readFieldBegin()) {
      switch (field.id) {
        case ID:
          if (field.type == thrift.TType.I64) {
            this.iD = iprot.readI64();
            this.__isset_iD = true;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case MESSAGE:
          if (field.type == thrift.TType.STRING) {
            this.message = iprot.readString();
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        default:
          thrift.TProtocolUtil.skip(iprot, field.type);
          break;
      }
      iprot.readFieldEnd();
    }
    iprot.readStructEnd();

    validate();
  }

  @override
  write(thrift.TProtocol oprot) {
    validate();

    oprot.writeStructBegin(_STRUCT_DESC);
    oprot.writeFieldBegin(_ID_FIELD_DESC);
    oprot.writeI64(this.iD);
    oprot.writeFieldEnd();
    if (this.message != null) {
      oprot.writeFieldBegin(_MESSAGE_FIELD_DESC);
      oprot.writeString(this.message);
      oprot.writeFieldEnd();
    }
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('Event(');

    ret.write('iD:');
    ret.write(this.iD);

    ret.write(', ');
    ret.write('message:');
    if (this.message == null) {
      ret.write('null');
    } else {
      ret.write(this.message);
    }

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is Event) {
      return this.iD == o.iD &&
        this.message == o.message;
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.iD.hashCode;
    value = (value * 31) ^ this.message.hashCode;
    return value;
  }

  Event clone({
    int iD,
    String message,
  }) {
    return Event()
      ..iD = iD ?? this.iD
      ..message = message ?? this.message;
  }

  validate() {
  }
}
