// Mocks generated by Mockito 5.4.0 from annotations
// in frugal/test/transport/f_adapter_transport_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i6;

import 'package:frugal/src/frugal.dart' as _i7;
import 'package:logging/logging.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:thrift/thrift.dart' as _i3;
import 'package:w_common/disposable.dart' as _i5;

import 'f_adapter_transport_test.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeLogger_0 extends _i1.SmartFake implements _i2.Logger {
  _FakeLogger_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTSocket_1 extends _i1.SmartFake implements _i3.TSocket {
  _FakeTSocket_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_2<T> extends _i1.SmartFake implements _i4.Future<T> {
  _FakeFuture_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeManagedDisposer_3 extends _i1.SmartFake
    implements _i5.ManagedDisposer {
  _FakeManagedDisposer_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTimer_4 extends _i1.SmartFake implements _i4.Timer {
  _FakeTimer_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamSubscription_5<T> extends _i1.SmartFake
    implements _i4.StreamSubscription<T> {
  _FakeStreamSubscription_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCompleter_6<T> extends _i1.SmartFake implements _i4.Completer<T> {
  _FakeCompleter_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TSocketTransport].
///
/// See the documentation for Mockito's code generation for more information.
class MockTSocketTransport extends _i1.Mock implements _i3.TSocketTransport {
  @override
  _i2.Logger get logger => (super.noSuchMethod(
        Invocation.getter(#logger),
        returnValue: _FakeLogger_0(
          this,
          Invocation.getter(#logger),
        ),
        returnValueForMissingStub: _FakeLogger_0(
          this,
          Invocation.getter(#logger),
        ),
      ) as _i2.Logger);
  @override
  _i3.TSocket get socket => (super.noSuchMethod(
        Invocation.getter(#socket),
        returnValue: _FakeTSocket_1(
          this,
          Invocation.getter(#socket),
        ),
        returnValueForMissingStub: _FakeTSocket_1(
          this,
          Invocation.getter(#socket),
        ),
      ) as _i3.TSocket);
  @override
  bool get isOpen => (super.noSuchMethod(
        Invocation.getter(#isOpen),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  bool get hasReadData => (super.noSuchMethod(
        Invocation.getter(#hasReadData),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.Future<dynamic> open() => (super.noSuchMethod(
        Invocation.method(
          #open,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
        returnValueForMissingStub: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
        returnValueForMissingStub: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  void handleIncomingMessage(_i6.Uint8List? messageBytes) => super.noSuchMethod(
        Invocation.method(
          #handleIncomingMessage,
          [messageBytes],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Uint8List consumeWriteBuffer() => (super.noSuchMethod(
        Invocation.method(
          #consumeWriteBuffer,
          [],
        ),
        returnValue: _i6.Uint8List(0),
        returnValueForMissingStub: _i6.Uint8List(0),
      ) as _i6.Uint8List);
  @override
  int read(
    _i6.Uint8List? buffer,
    int? offset,
    int? length,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [
            buffer,
            offset,
            length,
          ],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  void write(
    _i6.Uint8List? buffer,
    int? offset,
    int? length,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #write,
          [
            buffer,
            offset,
            length,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<dynamic> flush() => (super.noSuchMethod(
        Invocation.method(
          #flush,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
        returnValueForMissingStub: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  int readAll(
    _i6.Uint8List? buffer,
    int? offset,
    int? length,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #readAll,
          [
            buffer,
            offset,
            length,
          ],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  void writeAll(_i6.Uint8List? buffer) => super.noSuchMethod(
        Invocation.method(
          #writeAll,
          [buffer],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TSocket].
///
/// See the documentation for Mockito's code generation for more information.
class MockTSocket extends _i1.Mock implements _i3.TSocket {
  @override
  _i4.Stream<_i3.TSocketState> get onState => (super.noSuchMethod(
        Invocation.getter(#onState),
        returnValue: _i4.Stream<_i3.TSocketState>.empty(),
        returnValueForMissingStub: _i4.Stream<_i3.TSocketState>.empty(),
      ) as _i4.Stream<_i3.TSocketState>);
  @override
  _i4.Stream<Object> get onError => (super.noSuchMethod(
        Invocation.getter(#onError),
        returnValue: _i4.Stream<Object>.empty(),
        returnValueForMissingStub: _i4.Stream<Object>.empty(),
      ) as _i4.Stream<Object>);
  @override
  _i4.Stream<_i6.Uint8List> get onMessage => (super.noSuchMethod(
        Invocation.getter(#onMessage),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
        returnValueForMissingStub: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  bool get isOpen => (super.noSuchMethod(
        Invocation.getter(#isOpen),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.Future<dynamic> open() => (super.noSuchMethod(
        Invocation.method(
          #open,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
        returnValueForMissingStub: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
        returnValueForMissingStub: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  void send(_i6.Uint8List? data) => super.noSuchMethod(
        Invocation.method(
          #send,
          [data],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [FTransportMonitor].
///
/// See the documentation for Mockito's code generation for more information.
class MockFTransportMonitor extends _i1.Mock implements _i7.FTransportMonitor {
  @override
  _i4.Future<Null> get didDispose => (super.noSuchMethod(
        Invocation.getter(#didDispose),
        returnValue: _i4.Future<Null>.value(),
        returnValueForMissingStub: _i4.Future<Null>.value(),
      ) as _i4.Future<Null>);
  @override
  String get disposableTypeName => (super.noSuchMethod(
        Invocation.getter(#disposableTypeName),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  int get disposalTreeSize => (super.noSuchMethod(
        Invocation.getter(#disposalTreeSize),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  bool get isDisposed => (super.noSuchMethod(
        Invocation.getter(#isDisposed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  bool get isLeakFlagSet => (super.noSuchMethod(
        Invocation.getter(#isLeakFlagSet),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  bool get isOrWillBeDisposed => (super.noSuchMethod(
        Invocation.getter(#isOrWillBeDisposed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void onClosedCleanly() => super.noSuchMethod(
        Invocation.method(
          #onClosedCleanly,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  int onClosedUncleanly(Object? cause) => (super.noSuchMethod(
        Invocation.method(
          #onClosedUncleanly,
          [cause],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  void onReopenSucceeded() => super.noSuchMethod(
        Invocation.method(
          #onReopenSucceeded,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<T> awaitBeforeDispose<T>(_i4.Future<T>? future) =>
      (super.noSuchMethod(
        Invocation.method(
          #awaitBeforeDispose,
          [future],
        ),
        returnValue: _FakeFuture_2<T>(
          this,
          Invocation.method(
            #awaitBeforeDispose,
            [future],
          ),
        ),
        returnValueForMissingStub: _FakeFuture_2<T>(
          this,
          Invocation.method(
            #awaitBeforeDispose,
            [future],
          ),
        ),
      ) as _i4.Future<T>);
  @override
  _i4.Future<Null> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i4.Future<Null>.value(),
        returnValueForMissingStub: _i4.Future<Null>.value(),
      ) as _i4.Future<Null>);
  @override
  void flagLeak([String? description]) => super.noSuchMethod(
        Invocation.method(
          #flagLeak,
          [description],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<T> getManagedDelayedFuture<T>(
    Duration? duration,
    T Function()? callback,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getManagedDelayedFuture,
          [
            duration,
            callback,
          ],
        ),
        returnValue: _FakeFuture_2<T>(
          this,
          Invocation.method(
            #getManagedDelayedFuture,
            [
              duration,
              callback,
            ],
          ),
        ),
        returnValueForMissingStub: _FakeFuture_2<T>(
          this,
          Invocation.method(
            #getManagedDelayedFuture,
            [
              duration,
              callback,
            ],
          ),
        ),
      ) as _i4.Future<T>);
  @override
  _i5.ManagedDisposer getManagedDisposer(_i5.Disposer? disposer) =>
      (super.noSuchMethod(
        Invocation.method(
          #getManagedDisposer,
          [disposer],
        ),
        returnValue: _FakeManagedDisposer_3(
          this,
          Invocation.method(
            #getManagedDisposer,
            [disposer],
          ),
        ),
        returnValueForMissingStub: _FakeManagedDisposer_3(
          this,
          Invocation.method(
            #getManagedDisposer,
            [disposer],
          ),
        ),
      ) as _i5.ManagedDisposer);
  @override
  _i4.Timer getManagedTimer(
    Duration? duration,
    void Function()? callback,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getManagedTimer,
          [
            duration,
            callback,
          ],
        ),
        returnValue: _FakeTimer_4(
          this,
          Invocation.method(
            #getManagedTimer,
            [
              duration,
              callback,
            ],
          ),
        ),
        returnValueForMissingStub: _FakeTimer_4(
          this,
          Invocation.method(
            #getManagedTimer,
            [
              duration,
              callback,
            ],
          ),
        ),
      ) as _i4.Timer);
  @override
  _i4.Timer getManagedPeriodicTimer(
    Duration? duration,
    void Function(_i4.Timer)? callback,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getManagedPeriodicTimer,
          [
            duration,
            callback,
          ],
        ),
        returnValue: _FakeTimer_4(
          this,
          Invocation.method(
            #getManagedPeriodicTimer,
            [
              duration,
              callback,
            ],
          ),
        ),
        returnValueForMissingStub: _FakeTimer_4(
          this,
          Invocation.method(
            #getManagedPeriodicTimer,
            [
              duration,
              callback,
            ],
          ),
        ),
      ) as _i4.Timer);
  @override
  _i4.StreamSubscription<T> listenToStream<T>(
    _i4.Stream<T>? stream,
    void Function(T)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #listenToStream,
          [
            stream,
            onData,
          ],
          {
            #onError: onError,
            #onDone: onDone,
            #cancelOnError: cancelOnError,
          },
        ),
        returnValue: _FakeStreamSubscription_5<T>(
          this,
          Invocation.method(
            #listenToStream,
            [
              stream,
              onData,
            ],
            {
              #onError: onError,
              #onDone: onDone,
              #cancelOnError: cancelOnError,
            },
          ),
        ),
        returnValueForMissingStub: _FakeStreamSubscription_5<T>(
          this,
          Invocation.method(
            #listenToStream,
            [
              stream,
              onData,
            ],
            {
              #onError: onError,
              #onDone: onDone,
              #cancelOnError: cancelOnError,
            },
          ),
        ),
      ) as _i4.StreamSubscription<T>);
  @override
  T manageAndReturnTypedDisposable<T extends _i5.Disposable>(T? disposable) =>
      (super.noSuchMethod(
        Invocation.method(
          #manageAndReturnTypedDisposable,
          [disposable],
        ),
        returnValue: _i8.shim_manageAndReturnTypedDisposable<T>(disposable),
        returnValueForMissingStub:
            _i8.shim_manageAndReturnTypedDisposable<T>(disposable),
      ) as T);
  @override
  _i4.Completer<T> manageCompleter<T>(_i4.Completer<T>? completer) =>
      (super.noSuchMethod(
        Invocation.method(
          #manageCompleter,
          [completer],
        ),
        returnValue: _FakeCompleter_6<T>(
          this,
          Invocation.method(
            #manageCompleter,
            [completer],
          ),
        ),
        returnValueForMissingStub: _FakeCompleter_6<T>(
          this,
          Invocation.method(
            #manageCompleter,
            [completer],
          ),
        ),
      ) as _i4.Completer<T>);
  @override
  void manageDisposable(_i5.Disposable? disposable) => super.noSuchMethod(
        Invocation.method(
          #manageDisposable,
          [disposable],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void manageStreamController(_i4.StreamController<dynamic>? controller) =>
      super.noSuchMethod(
        Invocation.method(
          #manageStreamController,
          [controller],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<Null> onDispose() => (super.noSuchMethod(
        Invocation.method(
          #onDispose,
          [],
        ),
        returnValue: _i4.Future<Null>.value(),
        returnValueForMissingStub: _i4.Future<Null>.value(),
      ) as _i4.Future<Null>);
  @override
  _i4.Future<Null> onWillDispose() => (super.noSuchMethod(
        Invocation.method(
          #onWillDispose,
          [],
        ),
        returnValue: _i4.Future<Null>.value(),
        returnValueForMissingStub: _i4.Future<Null>.value(),
      ) as _i4.Future<Null>);
}