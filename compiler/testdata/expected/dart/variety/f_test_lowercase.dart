// Autogenerated by Frugal Compiler (3.16.27)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

// ignore_for_file: unused_import
// ignore_for_file: unused_field
import 'dart:typed_data' show Uint8List;

import 'package:collection/collection.dart';
import 'package:thrift/thrift.dart' as thrift;
import 'package:variety/variety.dart' as t_variety;
import 'package:actual_base_dart/actual_base_dart.dart' as t_actual_base_dart;
import 'package:intermediate_include/intermediate_include.dart' as t_intermediate_include;
import 'package:validStructs/validStructs.dart' as t_validStructs;
import 'package:ValidTypes/ValidTypes.dart' as t_ValidTypes;
import 'package:subdir_include_ns/subdir_include_ns.dart' as t_subdir_include_ns;

class TestLowercase implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('TestLowercase');
  static final thrift.TField _LOWERCASE_INT_FIELD_DESC = thrift.TField('lowercaseInt', thrift.TType.I32, 1);

  int _lowercaseInt = 0;
  static const int LOWERCASEINT = 1;

  bool __isset_lowercaseInt = false;

  int get lowercaseInt => this._lowercaseInt;

  set lowercaseInt(int lowercaseInt) {
    this._lowercaseInt = lowercaseInt;
    this.__isset_lowercaseInt = true;
  }

  bool isSetLowercaseInt() => this.__isset_lowercaseInt;

  unsetLowercaseInt() {
    this.__isset_lowercaseInt = false;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case LOWERCASEINT:
        return this.lowercaseInt;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case LOWERCASEINT:
        if (value == null) {
          unsetLowercaseInt();
        } else {
          this.lowercaseInt = value as int;
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
      case LOWERCASEINT:
        return isSetLowercaseInt();
    }
    return getFieldValue(fieldID) != null;
  }

  @override
  read(thrift.TProtocol iprot) {
    iprot.readStructBegin();
    for (thrift.TField field = iprot.readFieldBegin();
        field.type != thrift.TType.STOP;
        field = iprot.readFieldBegin()) {
      switch (field.id) {
        case LOWERCASEINT:
          if (field.type == thrift.TType.I32) {
            this.lowercaseInt = iprot.readI32();
            this.__isset_lowercaseInt = true;
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
    oprot.writeFieldBegin(_LOWERCASE_INT_FIELD_DESC);
    oprot.writeI32(this.lowercaseInt);
    oprot.writeFieldEnd();
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('TestLowercase(');

    ret.write('lowercaseInt:');
    ret.write(this.lowercaseInt);

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is TestLowercase) {
      return this.lowercaseInt == o.lowercaseInt;
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.lowercaseInt.hashCode;
    return value;
  }

  TestLowercase clone({
    int lowercaseInt,
  }) {
    return TestLowercase()
      ..lowercaseInt = lowercaseInt ?? this.lowercaseInt;
  }

  validate() {
  }
}
