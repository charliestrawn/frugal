// Autogenerated by Frugal Compiler (3.9.8)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

// ignore_for_file: unused_import
// ignore_for_file: unused_field
import 'dart:typed_data' show Uint8List;

import 'package:collection/collection.dart';
import 'package:thrift/thrift.dart' as thrift;
import 'package:actual_base_dart/actual_base_dart.dart' as t_actual_base_dart;

// ignore: camel_case_types
class nested_thing implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('nested_thing');
  static final thrift.TField _THINGS_FIELD_DESC = thrift.TField('things', thrift.TType.LIST, 1);

  List<t_actual_base_dart.thing> _things;
  static const int THINGS = 1;


  nested_thing();

  List<t_actual_base_dart.thing> get things => this._things;

  set things(List<t_actual_base_dart.thing> things) {
    this._things = things;
  }

  bool isSetThings() => this.things != null;

  unsetThings() {
    this.things = null;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case THINGS:
        return this.things;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case THINGS:
        if (value == null) {
          unsetThings();
        } else {
          this.things = value as List<t_actual_base_dart.thing>;
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
      case THINGS:
        return isSetThings();
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
        case THINGS:
          if (field.type == thrift.TType.LIST) {
            thrift.TList elem94 = iprot.readListBegin();
            this.things = List<t_actual_base_dart.thing>();
            for(int elem96 = 0; elem96 < elem94.length; ++elem96) {
              t_actual_base_dart.thing elem95 = t_actual_base_dart.thing();
              elem95.read(iprot);
              this.things.add(elem95);
            }
            iprot.readListEnd();
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

    // check for required fields of primitive type, which can't be checked in the validate method
    validate();
  }

  @override
  write(thrift.TProtocol oprot) {
    validate();

    oprot.writeStructBegin(_STRUCT_DESC);
    if (this.things != null) {
      oprot.writeFieldBegin(_THINGS_FIELD_DESC);
      oprot.writeListBegin(thrift.TList(thrift.TType.STRUCT, this.things.length));
      for(var elem97 in this.things) {
        elem97.write(oprot);
      }
      oprot.writeListEnd();
      oprot.writeFieldEnd();
    }
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('nested_thing(');

    ret.write('things:');
    if (this.things == null) {
      ret.write('null');
    } else {
      ret.write(this.things);
    }

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is nested_thing) {
      return DeepCollectionEquality().equals(this.things, o.things);
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.things.hashCode;
    return value;
  }

  nested_thing clone({
    List<t_actual_base_dart.thing> things,
  }) {
    return nested_thing()
      ..things = things ?? this.things;
  }

  validate() {
    // check for required fields
    // check that fields of type enum have valid values
  }
}
