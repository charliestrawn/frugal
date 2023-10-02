// Autogenerated by Frugal Compiler (3.17.2)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

// ignore_for_file: unused_import
// ignore_for_file: unused_field
import 'dart:typed_data' show Uint8List;

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:thrift/thrift.dart' as thrift;
import 'package:variety/variety.dart' as t_variety;
import 'package:actual_base_dart/actual_base_dart.dart' as t_actual_base_dart;
import 'package:intermediate_include/intermediate_include.dart' as t_intermediate_include;
import 'package:validStructs/validStructs.dart' as t_validStructs;
import 'package:ValidTypes/ValidTypes.dart' as t_ValidTypes;
import 'package:subdir_include_ns/subdir_include_ns.dart' as t_subdir_include_ns;

class EventWrapper implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('EventWrapper');
  static final thrift.TField _ID_FIELD_DESC = thrift.TField('ID', thrift.TType.I64, 1);
  static final thrift.TField _EV_FIELD_DESC = thrift.TField('Ev', thrift.TType.STRUCT, 2);
  static final thrift.TField _EVENTS_FIELD_DESC = thrift.TField('Events', thrift.TType.LIST, 3);
  static final thrift.TField _EVENTS2_FIELD_DESC = thrift.TField('Events2', thrift.TType.SET, 4);
  static final thrift.TField _EVENT_MAP_FIELD_DESC = thrift.TField('EventMap', thrift.TType.MAP, 5);
  static final thrift.TField _NUMS_FIELD_DESC = thrift.TField('Nums', thrift.TType.LIST, 6);
  static final thrift.TField _ENUMS_FIELD_DESC = thrift.TField('Enums', thrift.TType.LIST, 7);
  static final thrift.TField _A_BOOL_FIELD_FIELD_DESC = thrift.TField('aBoolField', thrift.TType.BOOL, 8);
  static final thrift.TField _A_UNION_FIELD_DESC = thrift.TField('a_union', thrift.TType.STRUCT, 9);
  static final thrift.TField _TYPEDEF_OF_TYPEDEF_FIELD_DESC = thrift.TField('typedefOfTypedef', thrift.TType.STRING, 10);
  static final thrift.TField _DEPR_FIELD_DESC = thrift.TField('depr', thrift.TType.BOOL, 11);
  static final thrift.TField _DEPR_BINARY_FIELD_DESC = thrift.TField('deprBinary', thrift.TType.STRING, 12);
  static final thrift.TField _DEPR_LIST_FIELD_DESC = thrift.TField('deprList', thrift.TType.LIST, 13);
  static final thrift.TField _EVENTS_DEFAULT_FIELD_DESC = thrift.TField('EventsDefault', thrift.TType.LIST, 14);
  static final thrift.TField _EVENT_MAP_DEFAULT_FIELD_DESC = thrift.TField('EventMapDefault', thrift.TType.MAP, 15);
  static final thrift.TField _EVENT_SET_DEFAULT_FIELD_DESC = thrift.TField('EventSetDefault', thrift.TType.SET, 16);

  fixnum.Int64 _iD;
  static const int ID = 1;
  t_variety.Event _ev;
  static const int EV = 2;
  List<t_variety.Event> _events;
  static const int EVENTS = 3;
  Set<t_variety.Event> _events2;
  static const int EVENTS2 = 4;
  Map<fixnum.Int64, t_variety.Event> _eventMap;
  static const int EVENTMAP = 5;
  List<List<int>> _nums;
  static const int NUMS = 6;
  List<int> _enums;
  static const int ENUMS = 7;
  bool _aBoolField = false;
  static const int ABOOLFIELD = 8;
  t_variety.TestingUnions _a_union;
  static const int A_UNION = 9;
  String _typedefOfTypedef;
  static const int TYPEDEFOFTYPEDEF = 10;
  /// This is a docstring comment for a deprecated field that has been spread
  /// across two lines.
  /// Deprecated: use something else
  @deprecated
  bool _depr = false;
  static const int DEPR = 11;
  /// Deprecated: use something else
  @deprecated
  Uint8List _deprBinary;
  static const int DEPRBINARY = 12;
  /// Deprecated: use something else
  @deprecated
  List<bool> _deprList;
  static const int DEPRLIST = 13;
  List<t_variety.Event> _eventsDefault;
  static const int EVENTSDEFAULT = 14;
  Map<fixnum.Int64, t_variety.Event> _eventMapDefault;
  static const int EVENTMAPDEFAULT = 15;
  Set<t_variety.Event> _eventSetDefault;
  static const int EVENTSETDEFAULT = 16;

  bool __isset_iD = false;
  bool __isset_aBoolField = false;
  bool __isset_depr = false;

  EventWrapper() {
    this._eventsDefault = [
    ];
    this._eventMapDefault = {
    };
    this._eventSetDefault = Set<t_variety.Event>.from([
    ]);
  }

  fixnum.Int64 get iD => this._iD;

  set iD(fixnum.Int64 iD) {
    this._iD = iD;
    this.__isset_iD = true;
  }

  bool isSetID() => this.__isset_iD;

  unsetID() {
    this.__isset_iD = false;
  }

  t_variety.Event get ev => this._ev;

  set ev(t_variety.Event ev) {
    this._ev = ev;
  }

  bool isSetEv() => this.ev != null;

  unsetEv() {
    this.ev = null;
  }

  List<t_variety.Event> get events => this._events;

  set events(List<t_variety.Event> events) {
    this._events = events;
  }

  bool isSetEvents() => this.events != null;

  unsetEvents() {
    this.events = null;
  }

  Set<t_variety.Event> get events2 => this._events2;

  set events2(Set<t_variety.Event> events2) {
    this._events2 = events2;
  }

  bool isSetEvents2() => this.events2 != null;

  unsetEvents2() {
    this.events2 = null;
  }

  Map<fixnum.Int64, t_variety.Event> get eventMap => this._eventMap;

  set eventMap(Map<fixnum.Int64, t_variety.Event> eventMap) {
    this._eventMap = eventMap;
  }

  bool isSetEventMap() => this.eventMap != null;

  unsetEventMap() {
    this.eventMap = null;
  }

  List<List<int>> get nums => this._nums;

  set nums(List<List<int>> nums) {
    this._nums = nums;
  }

  bool isSetNums() => this.nums != null;

  unsetNums() {
    this.nums = null;
  }

  List<int> get enums => this._enums;

  set enums(List<int> enums) {
    this._enums = enums;
  }

  bool isSetEnums() => this.enums != null;

  unsetEnums() {
    this.enums = null;
  }

  bool get aBoolField => this._aBoolField;

  set aBoolField(bool aBoolField) {
    this._aBoolField = aBoolField;
    this.__isset_aBoolField = true;
  }

  bool isSetABoolField() => this.__isset_aBoolField;

  unsetABoolField() {
    this.__isset_aBoolField = false;
  }

  t_variety.TestingUnions get a_union => this._a_union;

  set a_union(t_variety.TestingUnions a_union) {
    this._a_union = a_union;
  }

  bool isSetA_union() => this.a_union != null;

  unsetA_union() {
    this.a_union = null;
  }

  String get typedefOfTypedef => this._typedefOfTypedef;

  set typedefOfTypedef(String typedefOfTypedef) {
    this._typedefOfTypedef = typedefOfTypedef;
  }

  bool isSetTypedefOfTypedef() => this.typedefOfTypedef != null;

  unsetTypedefOfTypedef() {
    this.typedefOfTypedef = null;
  }

  /// This is a docstring comment for a deprecated field that has been spread
  /// across two lines.
  /// Deprecated: use something else
  @deprecated
  bool get depr => this._depr;

  /// This is a docstring comment for a deprecated field that has been spread
  /// across two lines.
  /// Deprecated: use something else
  @deprecated
  set depr(bool depr) {
    this._depr = depr;
    this.__isset_depr = true;
  }

  @deprecated  bool isSetDepr() => this.__isset_depr;

  unsetDepr() {
    this.__isset_depr = false;
  }

  /// Deprecated: use something else
  @deprecated
  Uint8List get deprBinary => this._deprBinary;

  /// Deprecated: use something else
  @deprecated
  set deprBinary(Uint8List deprBinary) {
    this._deprBinary = deprBinary;
  }

  @deprecated  bool isSetDeprBinary() => this.deprBinary != null;

  unsetDeprBinary() {
    // ignore: deprecated_member_use
    this.deprBinary = null;
  }

  /// Deprecated: use something else
  @deprecated
  List<bool> get deprList => this._deprList;

  /// Deprecated: use something else
  @deprecated
  set deprList(List<bool> deprList) {
    this._deprList = deprList;
  }

  @deprecated  bool isSetDeprList() => this.deprList != null;

  unsetDeprList() {
    // ignore: deprecated_member_use
    this.deprList = null;
  }

  List<t_variety.Event> get eventsDefault => this._eventsDefault;

  set eventsDefault(List<t_variety.Event> eventsDefault) {
    this._eventsDefault = eventsDefault;
  }

  bool isSetEventsDefault() => this.eventsDefault != null;

  unsetEventsDefault() {
    this.eventsDefault = null;
  }

  Map<fixnum.Int64, t_variety.Event> get eventMapDefault => this._eventMapDefault;

  set eventMapDefault(Map<fixnum.Int64, t_variety.Event> eventMapDefault) {
    this._eventMapDefault = eventMapDefault;
  }

  bool isSetEventMapDefault() => this.eventMapDefault != null;

  unsetEventMapDefault() {
    this.eventMapDefault = null;
  }

  Set<t_variety.Event> get eventSetDefault => this._eventSetDefault;

  set eventSetDefault(Set<t_variety.Event> eventSetDefault) {
    this._eventSetDefault = eventSetDefault;
  }

  bool isSetEventSetDefault() => this.eventSetDefault != null;

  unsetEventSetDefault() {
    this.eventSetDefault = null;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case ID:
        return this.iD;
      case EV:
        return this.ev;
      case EVENTS:
        return this.events;
      case EVENTS2:
        return this.events2;
      case EVENTMAP:
        return this.eventMap;
      case NUMS:
        return this.nums;
      case ENUMS:
        return this.enums;
      case ABOOLFIELD:
        return this.aBoolField;
      case A_UNION:
        return this.a_union;
      case TYPEDEFOFTYPEDEF:
        return this.typedefOfTypedef;
      case DEPR:
        // ignore: deprecated_member_use
        return this.depr;
      case DEPRBINARY:
        // ignore: deprecated_member_use
        return this.deprBinary;
      case DEPRLIST:
        // ignore: deprecated_member_use
        return this.deprList;
      case EVENTSDEFAULT:
        return this.eventsDefault;
      case EVENTMAPDEFAULT:
        return this.eventMapDefault;
      case EVENTSETDEFAULT:
        return this.eventSetDefault;
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
          this.iD = value as fixnum.Int64;
        }
        break;

      case EV:
        this.ev = value as t_variety.Event;
        break;

      case EVENTS:
        this.events = value as List<t_variety.Event>;
        break;

      case EVENTS2:
        this.events2 = value as Set<t_variety.Event>;
        break;

      case EVENTMAP:
        this.eventMap = value as Map<fixnum.Int64, t_variety.Event>;
        break;

      case NUMS:
        this.nums = value as List<List<int>>;
        break;

      case ENUMS:
        this.enums = value as List<int>;
        break;

      case ABOOLFIELD:
        if (value == null) {
          unsetABoolField();
        } else {
          this.aBoolField = value as bool;
        }
        break;

      case A_UNION:
        this.a_union = value as t_variety.TestingUnions;
        break;

      case TYPEDEFOFTYPEDEF:
        this.typedefOfTypedef = value as String;
        break;

      case DEPR:
        if (value == null) {
          unsetDepr();
        } else {
          // ignore: deprecated_member_use
          this.depr = value as bool;
        }
        break;

      case DEPRBINARY:
        // ignore: deprecated_member_use
        this.deprBinary = value as Uint8List;
        break;

      case DEPRLIST:
        // ignore: deprecated_member_use
        this.deprList = value as List<bool>;
        break;

      case EVENTSDEFAULT:
        this.eventsDefault = value as List<t_variety.Event>;
        break;

      case EVENTMAPDEFAULT:
        this.eventMapDefault = value as Map<fixnum.Int64, t_variety.Event>;
        break;

      case EVENTSETDEFAULT:
        this.eventSetDefault = value as Set<t_variety.Event>;
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
      case ABOOLFIELD:
        return isSetABoolField();
      case DEPR:
        // ignore: deprecated_member_use
        return isSetDepr();
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
        case ID:
          if (field.type == thrift.TType.I64) {
            this.iD = iprot.readInt64();
            this.__isset_iD = true;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case EV:
          if (field.type == thrift.TType.STRUCT) {
            final tmp_ev = t_variety.Event();
            this.ev = tmp_ev;
            tmp_ev.read(iprot);
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case EVENTS:
          if (field.type == thrift.TType.LIST) {
            thrift.TList elem50 = iprot.readListBegin();
            final elem53 = <t_variety.Event>[];
            for(int elem52 = 0; elem52 < elem50.length; ++elem52) {
              final tmp_elem51 = t_variety.Event();
              t_variety.Event elem51 = tmp_elem51;
              tmp_elem51.read(iprot);
              elem53.add(elem51);
            }
            iprot.readListEnd();
            this.events = elem53;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case EVENTS2:
          if (field.type == thrift.TType.SET) {
            thrift.TSet elem54 = iprot.readSetBegin();
            final elem57 = <t_variety.Event>{};
            for(int elem56 = 0; elem56 < elem54.length; ++elem56) {
              final tmp_elem55 = t_variety.Event();
              t_variety.Event elem55 = tmp_elem55;
              tmp_elem55.read(iprot);
              elem57.add(elem55);
            }
            iprot.readSetEnd();
            this.events2 = elem57;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case EVENTMAP:
          if (field.type == thrift.TType.MAP) {
            thrift.TMap elem58 = iprot.readMapBegin();
            final elem61 = <fixnum.Int64, t_variety.Event>{};
            for(int elem60 = 0; elem60 < elem58.length; ++elem60) {
              fixnum.Int64 elem62 = iprot.readInt64();
              final tmp_elem59 = t_variety.Event();
              t_variety.Event elem59 = tmp_elem59;
              tmp_elem59.read(iprot);
              elem61[elem62] = elem59;
            }
            iprot.readMapEnd();
            this.eventMap = elem61;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case NUMS:
          if (field.type == thrift.TType.LIST) {
            thrift.TList elem63 = iprot.readListBegin();
            final elem69 = <List<int>>[];
            for(int elem68 = 0; elem68 < elem63.length; ++elem68) {
              thrift.TList elem65 = iprot.readListBegin();
              final elem64 = <int>[];
              for(int elem67 = 0; elem67 < elem65.length; ++elem67) {
                int elem66 = iprot.readI32();
                elem64.add(elem66);
              }
              iprot.readListEnd();
              elem69.add(elem64);
            }
            iprot.readListEnd();
            this.nums = elem69;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case ENUMS:
          if (field.type == thrift.TType.LIST) {
            thrift.TList elem70 = iprot.readListBegin();
            final elem73 = <int>[];
            for(int elem72 = 0; elem72 < elem70.length; ++elem72) {
              int elem71 = iprot.readI32();
              elem73.add(elem71);
            }
            iprot.readListEnd();
            this.enums = elem73;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case ABOOLFIELD:
          if (field.type == thrift.TType.BOOL) {
            this.aBoolField = iprot.readBool();
            this.__isset_aBoolField = true;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case A_UNION:
          if (field.type == thrift.TType.STRUCT) {
            final tmp_a_union = t_variety.TestingUnions();
            this.a_union = tmp_a_union;
            tmp_a_union.read(iprot);
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case TYPEDEFOFTYPEDEF:
          if (field.type == thrift.TType.STRING) {
            this.typedefOfTypedef = iprot.readString();
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case DEPR:
          if (field.type == thrift.TType.BOOL) {
            // ignore: deprecated_member_use
            this.depr = iprot.readBool();
            this.__isset_depr = true;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case DEPRBINARY:
          if (field.type == thrift.TType.STRING) {
            // ignore: deprecated_member_use
            this.deprBinary = iprot.readBinary();
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case DEPRLIST:
          if (field.type == thrift.TType.LIST) {
            thrift.TList elem74 = iprot.readListBegin();
            // ignore: deprecated_member_use
            final elem77 = <bool>[];
            for(int elem76 = 0; elem76 < elem74.length; ++elem76) {
              bool elem75 = iprot.readBool();
              // ignore: deprecated_member_use
              elem77.add(elem75);
            }
            iprot.readListEnd();
            this.deprList = elem77;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case EVENTSDEFAULT:
          if (field.type == thrift.TType.LIST) {
            thrift.TList elem78 = iprot.readListBegin();
            final elem81 = <t_variety.Event>[];
            for(int elem80 = 0; elem80 < elem78.length; ++elem80) {
              final tmp_elem79 = t_variety.Event();
              t_variety.Event elem79 = tmp_elem79;
              tmp_elem79.read(iprot);
              elem81.add(elem79);
            }
            iprot.readListEnd();
            this.eventsDefault = elem81;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case EVENTMAPDEFAULT:
          if (field.type == thrift.TType.MAP) {
            thrift.TMap elem82 = iprot.readMapBegin();
            final elem85 = <fixnum.Int64, t_variety.Event>{};
            for(int elem84 = 0; elem84 < elem82.length; ++elem84) {
              fixnum.Int64 elem86 = iprot.readInt64();
              final tmp_elem83 = t_variety.Event();
              t_variety.Event elem83 = tmp_elem83;
              tmp_elem83.read(iprot);
              elem85[elem86] = elem83;
            }
            iprot.readMapEnd();
            this.eventMapDefault = elem85;
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case EVENTSETDEFAULT:
          if (field.type == thrift.TType.SET) {
            thrift.TSet elem87 = iprot.readSetBegin();
            final elem90 = <t_variety.Event>{};
            for(int elem89 = 0; elem89 < elem87.length; ++elem89) {
              final tmp_elem88 = t_variety.Event();
              t_variety.Event elem88 = tmp_elem88;
              tmp_elem88.read(iprot);
              elem90.add(elem88);
            }
            iprot.readSetEnd();
            this.eventSetDefault = elem90;
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
    final elem91 = iD;
    if (isSetID()) {
      oprot.writeFieldBegin(_ID_FIELD_DESC);
      oprot.writeInt64(elem91);
      oprot.writeFieldEnd();
    }
    final elem92 = ev;
    if (elem92 != null) {
      oprot.writeFieldBegin(_EV_FIELD_DESC);
      elem92.write(oprot);
      oprot.writeFieldEnd();
    }
    final elem93 = events;
    if (elem93 != null) {
      oprot.writeFieldBegin(_EVENTS_FIELD_DESC);
      oprot.writeListBegin(thrift.TList(thrift.TType.STRUCT, elem93.length));
      for(var elem94 in elem93) {
        elem94.write(oprot);
      }
      oprot.writeListEnd();
      oprot.writeFieldEnd();
    }
    final elem95 = events2;
    if (elem95 != null) {
      oprot.writeFieldBegin(_EVENTS2_FIELD_DESC);
      oprot.writeSetBegin(thrift.TSet(thrift.TType.STRUCT, elem95.length));
      for(var elem96 in elem95) {
        elem96.write(oprot);
      }
      oprot.writeSetEnd();
      oprot.writeFieldEnd();
    }
    final elem97 = eventMap;
    if (elem97 != null) {
      oprot.writeFieldBegin(_EVENT_MAP_FIELD_DESC);
      oprot.writeMapBegin(thrift.TMap(thrift.TType.I64, thrift.TType.STRUCT, elem97.length));
      for(var elem98 in elem97.keys) {
        final elem99 = elem97[elem98];
        oprot.writeInt64(elem98);
        elem99.write(oprot);
      }
      oprot.writeMapEnd();
      oprot.writeFieldEnd();
    }
    final elem100 = nums;
    if (elem100 != null) {
      oprot.writeFieldBegin(_NUMS_FIELD_DESC);
      oprot.writeListBegin(thrift.TList(thrift.TType.LIST, elem100.length));
      for(var elem101 in elem100) {
        oprot.writeListBegin(thrift.TList(thrift.TType.I32, elem101.length));
        for(var elem102 in elem101) {
          oprot.writeI32(elem102);
        }
        oprot.writeListEnd();
      }
      oprot.writeListEnd();
      oprot.writeFieldEnd();
    }
    final elem103 = enums;
    if (elem103 != null) {
      oprot.writeFieldBegin(_ENUMS_FIELD_DESC);
      oprot.writeListBegin(thrift.TList(thrift.TType.I32, elem103.length));
      for(var elem104 in elem103) {
        oprot.writeI32(elem104);
      }
      oprot.writeListEnd();
      oprot.writeFieldEnd();
    }
    final elem105 = aBoolField;
    oprot.writeFieldBegin(_A_BOOL_FIELD_FIELD_DESC);
    oprot.writeBool(elem105);
    oprot.writeFieldEnd();
    final elem106 = a_union;
    if (elem106 != null) {
      oprot.writeFieldBegin(_A_UNION_FIELD_DESC);
      elem106.write(oprot);
      oprot.writeFieldEnd();
    }
    final elem107 = typedefOfTypedef;
    if (elem107 != null) {
      oprot.writeFieldBegin(_TYPEDEF_OF_TYPEDEF_FIELD_DESC);
      oprot.writeString(elem107);
      oprot.writeFieldEnd();
    }
    final elem108 = depr;
    oprot.writeFieldBegin(_DEPR_FIELD_DESC);
    oprot.writeBool(elem108);
    oprot.writeFieldEnd();
    final elem109 = deprBinary;
    // ignore: deprecated_member_use
    if (elem109 != null) {
      oprot.writeFieldBegin(_DEPR_BINARY_FIELD_DESC);
      oprot.writeBinary(elem109);
      oprot.writeFieldEnd();
    }
    final elem110 = deprList;
    // ignore: deprecated_member_use
    if (elem110 != null) {
      oprot.writeFieldBegin(_DEPR_LIST_FIELD_DESC);
      oprot.writeListBegin(thrift.TList(thrift.TType.BOOL, elem110.length));
      for(var elem111 in elem110) {
        oprot.writeBool(elem111);
      }
      oprot.writeListEnd();
      oprot.writeFieldEnd();
    }
    final elem112 = eventsDefault;
    if (isSetEventsDefault() && elem112 != null) {
      oprot.writeFieldBegin(_EVENTS_DEFAULT_FIELD_DESC);
      oprot.writeListBegin(thrift.TList(thrift.TType.STRUCT, elem112.length));
      for(var elem113 in elem112) {
        elem113.write(oprot);
      }
      oprot.writeListEnd();
      oprot.writeFieldEnd();
    }
    final elem114 = eventMapDefault;
    if (isSetEventMapDefault() && elem114 != null) {
      oprot.writeFieldBegin(_EVENT_MAP_DEFAULT_FIELD_DESC);
      oprot.writeMapBegin(thrift.TMap(thrift.TType.I64, thrift.TType.STRUCT, elem114.length));
      for(var elem115 in elem114.keys) {
        final elem116 = elem114[elem115];
        oprot.writeInt64(elem115);
        elem116.write(oprot);
      }
      oprot.writeMapEnd();
      oprot.writeFieldEnd();
    }
    final elem117 = eventSetDefault;
    if (isSetEventSetDefault() && elem117 != null) {
      oprot.writeFieldBegin(_EVENT_SET_DEFAULT_FIELD_DESC);
      oprot.writeSetBegin(thrift.TSet(thrift.TType.STRUCT, elem117.length));
      for(var elem118 in elem117) {
        elem118.write(oprot);
      }
      oprot.writeSetEnd();
      oprot.writeFieldEnd();
    }
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('EventWrapper(');

    if (isSetID()) {
      ret.write('iD:');
      ret.write(this.iD);
    }

    ret.write(', ');
    ret.write('ev:');
    if (this.ev == null) {
      ret.write('null');
    } else {
      ret.write(this.ev);
    }

    ret.write(', ');
    ret.write('events:');
    if (this.events == null) {
      ret.write('null');
    } else {
      ret.write(this.events);
    }

    ret.write(', ');
    ret.write('events2:');
    if (this.events2 == null) {
      ret.write('null');
    } else {
      ret.write(this.events2);
    }

    ret.write(', ');
    ret.write('eventMap:');
    if (this.eventMap == null) {
      ret.write('null');
    } else {
      ret.write(this.eventMap);
    }

    ret.write(', ');
    ret.write('nums:');
    if (this.nums == null) {
      ret.write('null');
    } else {
      ret.write(this.nums);
    }

    ret.write(', ');
    ret.write('enums:');
    if (this.enums == null) {
      ret.write('null');
    } else {
      ret.write(this.enums);
    }

    ret.write(', ');
    ret.write('aBoolField:');
    ret.write(this.aBoolField);

    ret.write(', ');
    ret.write('a_union:');
    if (this.a_union == null) {
      ret.write('null');
    } else {
      ret.write(this.a_union);
    }

    ret.write(', ');
    ret.write('typedefOfTypedef:');
    if (this.typedefOfTypedef == null) {
      ret.write('null');
    } else {
      ret.write(this.typedefOfTypedef);
    }

    ret.write(', ');
    ret.write('depr:');
    // ignore: deprecated_member_use
    ret.write(this.depr);

    ret.write(', ');
    ret.write('deprBinary:');
    // ignore: deprecated_member_use
    if (this.deprBinary == null) {
      ret.write('null');
    } else {
      ret.write('BINARY');
    }

    ret.write(', ');
    ret.write('deprList:');
    // ignore: deprecated_member_use
    if (this.deprList == null) {
      ret.write('null');
    } else {
      // ignore: deprecated_member_use
      ret.write(this.deprList);
    }

    if (isSetEventsDefault()) {
      ret.write(', ');
      ret.write('eventsDefault:');
      if (this.eventsDefault == null) {
        ret.write('null');
      } else {
        ret.write(this.eventsDefault);
      }
    }

    if (isSetEventMapDefault()) {
      ret.write(', ');
      ret.write('eventMapDefault:');
      if (this.eventMapDefault == null) {
        ret.write('null');
      } else {
        ret.write(this.eventMapDefault);
      }
    }

    if (isSetEventSetDefault()) {
      ret.write(', ');
      ret.write('eventSetDefault:');
      if (this.eventSetDefault == null) {
        ret.write('null');
      } else {
        ret.write(this.eventSetDefault);
      }
    }

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is EventWrapper) {
      return this.iD == o.iD &&
        this.ev == o.ev &&
        DeepCollectionEquality().equals(this.events, o.events) &&
        DeepCollectionEquality().equals(this.events2, o.events2) &&
        DeepCollectionEquality().equals(this.eventMap, o.eventMap) &&
        DeepCollectionEquality().equals(this.nums, o.nums) &&
        DeepCollectionEquality().equals(this.enums, o.enums) &&
        this.aBoolField == o.aBoolField &&
        this.a_union == o.a_union &&
        this.typedefOfTypedef == o.typedefOfTypedef &&
        // ignore: deprecated_member_use
        this.depr == o.depr &&
        // ignore: deprecated_member_use
        this.deprBinary == o.deprBinary &&
        // ignore: deprecated_member_use
        DeepCollectionEquality().equals(this.deprList, o.deprList) &&
        DeepCollectionEquality().equals(this.eventsDefault, o.eventsDefault) &&
        DeepCollectionEquality().equals(this.eventMapDefault, o.eventMapDefault) &&
        DeepCollectionEquality().equals(this.eventSetDefault, o.eventSetDefault);
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.iD.hashCode;
    value = (value * 31) ^ this.ev.hashCode;
    value = (value * 31) ^ DeepCollectionEquality().hash(this.events);
    value = (value * 31) ^ DeepCollectionEquality().hash(this.events2);
    value = (value * 31) ^ DeepCollectionEquality().hash(this.eventMap);
    value = (value * 31) ^ DeepCollectionEquality().hash(this.nums);
    value = (value * 31) ^ DeepCollectionEquality().hash(this.enums);
    value = (value * 31) ^ this.aBoolField.hashCode;
    value = (value * 31) ^ this.a_union.hashCode;
    value = (value * 31) ^ this.typedefOfTypedef.hashCode;
    // ignore: deprecated_member_use
    value = (value * 31) ^ this.depr.hashCode;
    // ignore: deprecated_member_use
    value = (value * 31) ^ this.deprBinary.hashCode;
    // ignore: deprecated_member_use
    value = (value * 31) ^ DeepCollectionEquality().hash(this.deprList);
    value = (value * 31) ^ DeepCollectionEquality().hash(this.eventsDefault);
    value = (value * 31) ^ DeepCollectionEquality().hash(this.eventMapDefault);
    value = (value * 31) ^ DeepCollectionEquality().hash(this.eventSetDefault);
    return value;
  }

  EventWrapper clone({
    fixnum.Int64 iD,
    t_variety.Event ev,
    List<t_variety.Event> events,
    Set<t_variety.Event> events2,
    Map<fixnum.Int64, t_variety.Event> eventMap,
    List<List<int>> nums,
    List<int> enums,
    bool aBoolField,
    t_variety.TestingUnions a_union,
    String typedefOfTypedef,
    // ignore: deprecated_member_use
    bool depr,
    // ignore: deprecated_member_use
    Uint8List deprBinary,
    // ignore: deprecated_member_use
    List<bool> deprList,
    List<t_variety.Event> eventsDefault,
    Map<fixnum.Int64, t_variety.Event> eventMapDefault,
    Set<t_variety.Event> eventSetDefault,
  }) {
    return EventWrapper()
      ..iD = iD ?? this.iD
      ..ev = ev ?? this.ev
      ..events = events ?? this.events
      ..events2 = events2 ?? this.events2
      ..eventMap = eventMap ?? this.eventMap
      ..nums = nums ?? this.nums
      ..enums = enums ?? this.enums
      ..aBoolField = aBoolField ?? this.aBoolField
      ..a_union = a_union ?? this.a_union
      ..typedefOfTypedef = typedefOfTypedef ?? this.typedefOfTypedef
      // ignore: deprecated_member_use
      ..depr = depr ?? this.depr
      // ignore: deprecated_member_use
      ..deprBinary = deprBinary ?? this.deprBinary
      // ignore: deprecated_member_use
      ..deprList = deprList ?? this.deprList
      ..eventsDefault = eventsDefault ?? this.eventsDefault
      ..eventMapDefault = eventMapDefault ?? this.eventMapDefault
      ..eventSetDefault = eventSetDefault ?? this.eventSetDefault;
  }

  validate() {
    // check for required fields
    if (this.ev == null) {
      throw thrift.TProtocolError(thrift.TProtocolErrorType.INVALID_DATA, "Required field 'ev' was not present in struct EventWrapper");
    }
  }
}
