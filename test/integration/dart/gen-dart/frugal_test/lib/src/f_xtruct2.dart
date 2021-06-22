// Autogenerated by Frugal Compiler (3.14.5)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

// ignore_for_file: unused_import
// ignore_for_file: unused_field
import 'dart:typed_data' show Uint8List;

import 'package:collection/collection.dart';
import 'package:thrift/thrift.dart' as thrift;
import 'package:frugal_test/frugal_test.dart' as t_frugal_test;

class Xtruct2 implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('Xtruct2');
  static final thrift.TField _BYTE_THING_FIELD_DESC = thrift.TField('byte_thing', thrift.TType.BYTE, 1);
  static final thrift.TField _STRUCT_THING_FIELD_DESC = thrift.TField('struct_thing', thrift.TType.STRUCT, 2);
  static final thrift.TField _I32_THING_FIELD_DESC = thrift.TField('i32_thing', thrift.TType.I32, 3);

  int _byte_thing = 0;
  static const int BYTE_THING = 1;
  t_frugal_test.Xtruct _struct_thing;
  static const int STRUCT_THING = 2;
  int _i32_thing = 0;
  static const int I32_THING = 3;

  bool __isset_byte_thing = false;
  bool __isset_i32_thing = false;

  int get byte_thing => this._byte_thing;

  set byte_thing(int byte_thing) {
    this._byte_thing = byte_thing;
    this.__isset_byte_thing = true;
  }

  bool isSetByte_thing() => this.__isset_byte_thing;

  unsetByte_thing() {
    this.__isset_byte_thing = false;
  }

  t_frugal_test.Xtruct get struct_thing => this._struct_thing;

  set struct_thing(t_frugal_test.Xtruct struct_thing) {
    this._struct_thing = struct_thing;
  }

  bool isSetStruct_thing() => this.struct_thing != null;

  unsetStruct_thing() {
    this.struct_thing = null;
  }

  int get i32_thing => this._i32_thing;

  set i32_thing(int i32_thing) {
    this._i32_thing = i32_thing;
    this.__isset_i32_thing = true;
  }

  bool isSetI32_thing() => this.__isset_i32_thing;

  unsetI32_thing() {
    this.__isset_i32_thing = false;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case BYTE_THING:
        return this.byte_thing;
      case STRUCT_THING:
        return this.struct_thing;
      case I32_THING:
        return this.i32_thing;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case BYTE_THING:
        if (value == null) {
          unsetByte_thing();
        } else {
          this.byte_thing = value as int;
        }
        break;

      case STRUCT_THING:
        if (value == null) {
          unsetStruct_thing();
        } else {
          this.struct_thing = value as t_frugal_test.Xtruct;
        }
        break;

      case I32_THING:
        if (value == null) {
          unsetI32_thing();
        } else {
          this.i32_thing = value as int;
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
      case BYTE_THING:
        return isSetByte_thing();
      case STRUCT_THING:
        return isSetStruct_thing();
      case I32_THING:
        return isSetI32_thing();
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
        case BYTE_THING:
          if (field.type == thrift.TType.BYTE) {
            this.byte_thing = iprot.readByte();
            this.__isset_byte_thing = true;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case STRUCT_THING:
          if (field.type == thrift.TType.STRUCT) {
            this.struct_thing = t_frugal_test.Xtruct();
            struct_thing.read(iprot);
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case I32_THING:
          if (field.type == thrift.TType.I32) {
            this.i32_thing = iprot.readI32();
            this.__isset_i32_thing = true;
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
    oprot.writeFieldBegin(_BYTE_THING_FIELD_DESC);
    oprot.writeByte(this.byte_thing);
    oprot.writeFieldEnd();
    if (this.struct_thing != null) {
      oprot.writeFieldBegin(_STRUCT_THING_FIELD_DESC);
      this.struct_thing.write(oprot);
      oprot.writeFieldEnd();
    }
    oprot.writeFieldBegin(_I32_THING_FIELD_DESC);
    oprot.writeI32(this.i32_thing);
    oprot.writeFieldEnd();
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('Xtruct2(');

    ret.write('byte_thing:');
    ret.write(this.byte_thing);

    ret.write(', ');
    ret.write('struct_thing:');
    if (this.struct_thing == null) {
      ret.write('null');
    } else {
      ret.write(this.struct_thing);
    }

    ret.write(', ');
    ret.write('i32_thing:');
    ret.write(this.i32_thing);

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is Xtruct2) {
      return this.byte_thing == o.byte_thing &&
        this.struct_thing == o.struct_thing &&
        this.i32_thing == o.i32_thing;
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.byte_thing.hashCode;
    value = (value * 31) ^ this.struct_thing.hashCode;
    value = (value * 31) ^ this.i32_thing.hashCode;
    return value;
  }

  Xtruct2 clone({
    int byte_thing,
    t_frugal_test.Xtruct struct_thing,
    int i32_thing,
  }) {
    return Xtruct2()
      ..byte_thing = byte_thing ?? this.byte_thing
      ..struct_thing = struct_thing ?? this.struct_thing
      ..i32_thing = i32_thing ?? this.i32_thing;
  }

  validate() {
  }
}
