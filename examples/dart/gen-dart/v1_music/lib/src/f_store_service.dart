// Autogenerated by Frugal Compiler (3.4.10)
// DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING



import 'dart:async';
// ignore_for_file: unused_import
import 'dart:typed_data' show Uint8List;

import 'package:logging/logging.dart' as logging;
import 'package:thrift/thrift.dart' as thrift;
import 'package:frugal/frugal.dart' as frugal;

import 'package:v1_music/v1_music.dart' as t_v1_music;


/// Services are the API for client and server interaction.
/// Users can buy an album or enter a giveaway for a free album.
abstract class FStore {
  Future<t_v1_music.Album> buyAlbum(frugal.FContext ctx, String aSIN, String acct);

  /// Deprecated: use something else
  @deprecated
  Future<bool> enterAlbumGiveaway(frugal.FContext ctx, String email, String name);
}

/// Services are the API for client and server interaction.
/// Users can buy an album or enter a giveaway for a free album.
class FStoreClient implements FStore {
  static final logging.Logger _frugalLog = logging.Logger('Store');
  Map<String, frugal.FMethod> _methods;

  FStoreClient(frugal.FServiceProvider provider, [List<frugal.Middleware> middleware]) {
    _transport = provider.transport;
    _protocolFactory = provider.protocolFactory;
    var combined = middleware ?? [];
    combined.addAll(provider.middleware);
    this._methods = {};
    this._methods['buyAlbum'] = frugal.FMethod(this._buyAlbum, 'Store', 'buyAlbum', combined);
    this._methods['enterAlbumGiveaway'] = frugal.FMethod(this._enterAlbumGiveaway, 'Store', 'enterAlbumGiveaway', combined);
  }

  frugal.FTransport _transport;
  frugal.FProtocolFactory _protocolFactory;

  @override
  Future<t_v1_music.Album> buyAlbum(frugal.FContext ctx, String aSIN, String acct) {
    return this._methods['buyAlbum']([ctx, aSIN, acct]).then((value) => value as t_v1_music.Album);
  }

  Future<t_v1_music.Album> _buyAlbum(frugal.FContext ctx, String aSIN, String acct) async {
    var memoryBuffer = frugal.TMemoryOutputBuffer(_transport.requestSizeLimit);
    var oprot = _protocolFactory.getProtocol(memoryBuffer);
    oprot.writeRequestHeader(ctx);
    oprot.writeMessageBegin(thrift.TMessage('buyAlbum', thrift.TMessageType.CALL, 0));
    buyAlbum_args args = buyAlbum_args();
    args.aSIN = aSIN;
    args.acct = acct;
    args.write(oprot);
    oprot.writeMessageEnd();
    var response = await _transport.request(ctx, memoryBuffer.writeBytes);

    var iprot = _protocolFactory.getProtocol(response);
    iprot.readResponseHeader(ctx);
    thrift.TMessage msg = iprot.readMessageBegin();
    if (msg.type == thrift.TMessageType.EXCEPTION) {
      thrift.TApplicationError error = thrift.TApplicationError.read(iprot);
      iprot.readMessageEnd();
      if (error.type == frugal.FrugalTTransportErrorType.REQUEST_TOO_LARGE) {
        throw thrift.TTransportError(
            frugal.FrugalTTransportErrorType.RESPONSE_TOO_LARGE, error.message);
      }
      throw error;
    }

    buyAlbum_result result = buyAlbum_result();
    result.read(iprot);
    iprot.readMessageEnd();
    if (result.isSetSuccess()) {
      return result.success;
    }

    if (result.error != null) {
      throw result.error;
    }
    throw thrift.TApplicationError(
      frugal.FrugalTApplicationErrorType.MISSING_RESULT, 'buyAlbum failed: unknown result'
    );
  }
  /// Deprecated: use something else
  @deprecated
  @override
  Future<bool> enterAlbumGiveaway(frugal.FContext ctx, String email, String name) {
    _frugalLog.warning("Call to deprecated function 'Store.enterAlbumGiveaway'");
    return this._methods['enterAlbumGiveaway']([ctx, email, name]).then((value) => value as bool);
  }

  Future<bool> _enterAlbumGiveaway(frugal.FContext ctx, String email, String name) async {
    var memoryBuffer = frugal.TMemoryOutputBuffer(_transport.requestSizeLimit);
    var oprot = _protocolFactory.getProtocol(memoryBuffer);
    oprot.writeRequestHeader(ctx);
    oprot.writeMessageBegin(thrift.TMessage('enterAlbumGiveaway', thrift.TMessageType.CALL, 0));
    enterAlbumGiveaway_args args = enterAlbumGiveaway_args();
    args.email = email;
    args.name = name;
    args.write(oprot);
    oprot.writeMessageEnd();
    var response = await _transport.request(ctx, memoryBuffer.writeBytes);

    var iprot = _protocolFactory.getProtocol(response);
    iprot.readResponseHeader(ctx);
    thrift.TMessage msg = iprot.readMessageBegin();
    if (msg.type == thrift.TMessageType.EXCEPTION) {
      thrift.TApplicationError error = thrift.TApplicationError.read(iprot);
      iprot.readMessageEnd();
      if (error.type == frugal.FrugalTTransportErrorType.REQUEST_TOO_LARGE) {
        throw thrift.TTransportError(
            frugal.FrugalTTransportErrorType.RESPONSE_TOO_LARGE, error.message);
      }
      throw error;
    }

    enterAlbumGiveaway_result result = enterAlbumGiveaway_result();
    result.read(iprot);
    iprot.readMessageEnd();
    if (result.isSetSuccess()) {
      return result.success;
    }

    throw thrift.TApplicationError(
      frugal.FrugalTApplicationErrorType.MISSING_RESULT, 'enterAlbumGiveaway failed: unknown result'
    );
  }
}

// ignore: camel_case_types
class buyAlbum_args implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('buyAlbum_args');
  static final thrift.TField _ASIN_FIELD_DESC = thrift.TField('ASIN', thrift.TType.STRING, 1);
  static final thrift.TField _ACCT_FIELD_DESC = thrift.TField('acct', thrift.TType.STRING, 2);

  String _aSIN;
  static const int ASIN = 1;
  String _acct;
  static const int ACCT = 2;


  buyAlbum_args();

  String get aSIN => this._aSIN;

  set aSIN(String aSIN) {
    this._aSIN = aSIN;
  }

  bool isSetASIN() => this.aSIN != null;

  unsetASIN() {
    this.aSIN = null;
  }

  String get acct => this._acct;

  set acct(String acct) {
    this._acct = acct;
  }

  bool isSetAcct() => this.acct != null;

  unsetAcct() {
    this.acct = null;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case ASIN:
        return this.aSIN;
      case ACCT:
        return this.acct;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case ASIN:
        if (value == null) {
          unsetASIN();
        } else {
          this.aSIN = value as String;
        }
        break;

      case ACCT:
        if (value == null) {
          unsetAcct();
        } else {
          this.acct = value as String;
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
      case ASIN:
        return isSetASIN();
      case ACCT:
        return isSetAcct();
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
        case ASIN:
          if (field.type == thrift.TType.STRING) {
            this.aSIN = iprot.readString();
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case ACCT:
          if (field.type == thrift.TType.STRING) {
            this.acct = iprot.readString();
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
    if (this.aSIN != null) {
      oprot.writeFieldBegin(_ASIN_FIELD_DESC);
      oprot.writeString(this.aSIN);
      oprot.writeFieldEnd();
    }
    if (this.acct != null) {
      oprot.writeFieldBegin(_ACCT_FIELD_DESC);
      oprot.writeString(this.acct);
      oprot.writeFieldEnd();
    }
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('buyAlbum_args(');

    ret.write('aSIN:');
    if (this.aSIN == null) {
      ret.write('null');
    } else {
      ret.write(this.aSIN);
    }

    ret.write(', ');
    ret.write('acct:');
    if (this.acct == null) {
      ret.write('null');
    } else {
      ret.write(this.acct);
    }

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is buyAlbum_args) {
      return this.aSIN == o.aSIN &&
        this.acct == o.acct;
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.aSIN.hashCode;
    value = (value * 31) ^ this.acct.hashCode;
    return value;
  }

  buyAlbum_args clone({
    String aSIN,
    String acct,
  }) {
    return buyAlbum_args()
      ..aSIN = aSIN ?? this.aSIN
      ..acct = acct ?? this.acct;
  }

  validate() {
    // check for required fields
    // check that fields of type enum have valid values
  }
}
// ignore: camel_case_types
class buyAlbum_result implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('buyAlbum_result');
  static final thrift.TField _SUCCESS_FIELD_DESC = thrift.TField('success', thrift.TType.STRUCT, 0);
  static final thrift.TField _ERROR_FIELD_DESC = thrift.TField('error', thrift.TType.STRUCT, 1);

  t_v1_music.Album _success;
  static const int SUCCESS = 0;
  t_v1_music.PurchasingError _error;
  static const int ERROR = 1;


  buyAlbum_result();

  t_v1_music.Album get success => this._success;

  set success(t_v1_music.Album success) {
    this._success = success;
  }

  bool isSetSuccess() => this.success != null;

  unsetSuccess() {
    this.success = null;
  }

  t_v1_music.PurchasingError get error => this._error;

  set error(t_v1_music.PurchasingError error) {
    this._error = error;
  }

  bool isSetError() => this.error != null;

  unsetError() {
    this.error = null;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case SUCCESS:
        return this.success;
      case ERROR:
        return this.error;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case SUCCESS:
        if (value == null) {
          unsetSuccess();
        } else {
          this.success = value as t_v1_music.Album;
        }
        break;

      case ERROR:
        if (value == null) {
          unsetError();
        } else {
          this.error = value as t_v1_music.PurchasingError;
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
      case SUCCESS:
        return isSetSuccess();
      case ERROR:
        return isSetError();
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
        case SUCCESS:
          if (field.type == thrift.TType.STRUCT) {
            this.success = t_v1_music.Album();
            success.read(iprot);
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case ERROR:
          if (field.type == thrift.TType.STRUCT) {
            this.error = t_v1_music.PurchasingError();
            error.read(iprot);
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
    if (isSetSuccess() && this.success != null) {
      oprot.writeFieldBegin(_SUCCESS_FIELD_DESC);
      this.success.write(oprot);
      oprot.writeFieldEnd();
    }
    if (isSetError() && this.error != null) {
      oprot.writeFieldBegin(_ERROR_FIELD_DESC);
      this.error.write(oprot);
      oprot.writeFieldEnd();
    }
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('buyAlbum_result(');

    if (isSetSuccess()) {
      ret.write('success:');
      if (this.success == null) {
        ret.write('null');
      } else {
        ret.write(this.success);
      }
    }

    if (isSetError()) {
      ret.write(', ');
      ret.write('error:');
      if (this.error == null) {
        ret.write('null');
      } else {
        ret.write(this.error);
      }
    }

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is buyAlbum_result) {
      return this.success == o.success &&
        this.error == o.error;
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.success.hashCode;
    value = (value * 31) ^ this.error.hashCode;
    return value;
  }

  buyAlbum_result clone({
    t_v1_music.Album success,
    t_v1_music.PurchasingError error,
  }) {
    return buyAlbum_result()
      ..success = success ?? this.success
      ..error = error ?? this.error;
  }

  validate() {
    // check for required fields
    // check that fields of type enum have valid values
  }
}
// ignore: camel_case_types
class enterAlbumGiveaway_args implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('enterAlbumGiveaway_args');
  static final thrift.TField _EMAIL_FIELD_DESC = thrift.TField('email', thrift.TType.STRING, 1);
  static final thrift.TField _NAME_FIELD_DESC = thrift.TField('name', thrift.TType.STRING, 2);

  String _email;
  static const int EMAIL = 1;
  String _name;
  static const int NAME = 2;


  enterAlbumGiveaway_args();

  String get email => this._email;

  set email(String email) {
    this._email = email;
  }

  bool isSetEmail() => this.email != null;

  unsetEmail() {
    this.email = null;
  }

  String get name => this._name;

  set name(String name) {
    this._name = name;
  }

  bool isSetName() => this.name != null;

  unsetName() {
    this.name = null;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case EMAIL:
        return this.email;
      case NAME:
        return this.name;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case EMAIL:
        if (value == null) {
          unsetEmail();
        } else {
          this.email = value as String;
        }
        break;

      case NAME:
        if (value == null) {
          unsetName();
        } else {
          this.name = value as String;
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
      case EMAIL:
        return isSetEmail();
      case NAME:
        return isSetName();
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
        case EMAIL:
          if (field.type == thrift.TType.STRING) {
            this.email = iprot.readString();
          } else {
            thrift.TProtocolUtil.skip(iprot, field.type);
          }
          break;
        case NAME:
          if (field.type == thrift.TType.STRING) {
            this.name = iprot.readString();
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
    if (this.email != null) {
      oprot.writeFieldBegin(_EMAIL_FIELD_DESC);
      oprot.writeString(this.email);
      oprot.writeFieldEnd();
    }
    if (this.name != null) {
      oprot.writeFieldBegin(_NAME_FIELD_DESC);
      oprot.writeString(this.name);
      oprot.writeFieldEnd();
    }
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('enterAlbumGiveaway_args(');

    ret.write('email:');
    if (this.email == null) {
      ret.write('null');
    } else {
      ret.write(this.email);
    }

    ret.write(', ');
    ret.write('name:');
    if (this.name == null) {
      ret.write('null');
    } else {
      ret.write(this.name);
    }

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is enterAlbumGiveaway_args) {
      return this.email == o.email &&
        this.name == o.name;
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.email.hashCode;
    value = (value * 31) ^ this.name.hashCode;
    return value;
  }

  enterAlbumGiveaway_args clone({
    String email,
    String name,
  }) {
    return enterAlbumGiveaway_args()
      ..email = email ?? this.email
      ..name = name ?? this.name;
  }

  validate() {
    // check for required fields
    // check that fields of type enum have valid values
  }
}
// ignore: camel_case_types
class enterAlbumGiveaway_result implements thrift.TBase {
  static final thrift.TStruct _STRUCT_DESC = thrift.TStruct('enterAlbumGiveaway_result');
  static final thrift.TField _SUCCESS_FIELD_DESC = thrift.TField('success', thrift.TType.BOOL, 0);

  bool _success;
  static const int SUCCESS = 0;

  bool __isset_success = false;

  enterAlbumGiveaway_result();

  bool get success => this._success;

  set success(bool success) {
    this._success = success;
    this.__isset_success = true;
  }

  bool isSetSuccess() => this.__isset_success;

  unsetSuccess() {
    this.__isset_success = false;
  }

  @override
  getFieldValue(int fieldID) {
    switch (fieldID) {
      case SUCCESS:
        return this.success;
      default:
        throw ArgumentError("Field $fieldID doesn't exist!");
    }
  }

  @override
  setFieldValue(int fieldID, Object value) {
    switch (fieldID) {
      case SUCCESS:
        if (value == null) {
          unsetSuccess();
        } else {
          this.success = value as bool;
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
      case SUCCESS:
        return isSetSuccess();
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
        case SUCCESS:
          if (field.type == thrift.TType.BOOL) {
            this.success = iprot.readBool();
            this.__isset_success = true;
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
    if (isSetSuccess()) {
      oprot.writeFieldBegin(_SUCCESS_FIELD_DESC);
      oprot.writeBool(this.success);
      oprot.writeFieldEnd();
    }
    oprot.writeFieldStop();
    oprot.writeStructEnd();
  }

  @override
  String toString() {
    StringBuffer ret = StringBuffer('enterAlbumGiveaway_result(');

    if (isSetSuccess()) {
      ret.write('success:');
      ret.write(this.success);
    }

    ret.write(')');

    return ret.toString();
  }

  @override
  bool operator ==(Object o) {
    if (o is enterAlbumGiveaway_result) {
      return this.success == o.success;
    }
    return false;
  }

  @override
  int get hashCode {
    var value = 17;
    value = (value * 31) ^ this.success.hashCode;
    return value;
  }

  enterAlbumGiveaway_result clone({
    bool success,
  }) {
    return enterAlbumGiveaway_result()
      ..success = success ?? this.success;
  }

  validate() {
    // check for required fields
    // check that fields of type enum have valid values
  }
}
