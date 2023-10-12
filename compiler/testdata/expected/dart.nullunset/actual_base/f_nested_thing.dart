// Autogenerated by Frugal Compiler (3.17.4)
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

  List<t_actual_base_dart.thing> things;
  static const int THINGS = 1;


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
        this.things = value as List<t_actual_base_dart.thing>;
        break;

      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  // Returns true if the field corresponding to fieldID is set (has been assigned a value) and false otherwise
  @override
  bool isSet(int fieldID) {
    return getFieldValue(fieldID) != null;
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
            thrift.TList elem203 = iprot.readListBegin();
            final elem207 = <t_actual_base_dart.thing>[];
            for(int elem206 = 0; elem206 < elem203.length; ++elem206) {
              final elem205 = t_actual_base_dart.thing();
              t_actual_base_dart.thing elem204 = elem205;
              elem205.read(iprot);
              elem207.add(elem204);
            }
            iprot.readListEnd();
            this.things = elem207;
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
    final elem208 = things;
    if (elem208 != null) {
      oprot.writeFieldBegin(_THINGS_FIELD_DESC);
      oprot.writeListBegin(thrift.TList(thrift.TType.STRUCT, elem208.length));
      for(var elem209 in elem208) {
        elem209.write(oprot);
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
    value = (value * 31) ^ DeepCollectionEquality().hash(this.things);
    return value;
  }

  nested_thing clone({
    List<t_actual_base_dart.thing> things,
  }) {
    return nested_thing()
      ..things = things ?? this.things;
  }

  validate() {
  }
}
