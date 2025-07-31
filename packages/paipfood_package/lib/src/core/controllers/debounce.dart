// part of 'package:paipfood_package/paipfood_package.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';

class Debounce<T> {
  final int milliseconds;

  Completer<T?>? _completer;
  Timer? _timer;
  Isolate? _isolate;
  ReceivePort? _receivePort;
  bool _isDisposed = false;

  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);

  Debounce({this.milliseconds = 500});

  ValueNotifier<bool> get isLoadingNotifier => _isLoadingNotifier;

  bool get isLoading => _isLoadingNotifier.value;

  void dispose() {
    _isDisposed = true;
    cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();
    _isLoadingNotifier.dispose();
  }

  void cancel() {
    if (!_isDisposed && _completer?.isCompleted == false) {
      _completer?.complete(null);
    }
    _timer?.cancel();

    if (!_isDisposed) {
      _isLoadingNotifier.value = false;
    }
  }

  Future<T?> startTimer({required String value, required FutureOr<T> Function() onComplete, required int length}) async {
    if (_isDisposed) return null;

    cancel();

    _completer = Completer<T?>();
    _isLoadingNotifier.value = true;

    _timer = Timer(Duration(milliseconds: milliseconds), () async {
      if (_isDisposed) return;

      try {
        if (value.length >= length) {
          final result = await onComplete.call();
          if (!_isDisposed && _completer?.isCompleted == false) {
            _completer?.complete(result);
          }
        } else {
          if (!_isDisposed && _completer?.isCompleted == false) {
            _completer?.complete(null);
          }
        }
      } catch (error) {
        if (!_isDisposed && _completer?.isCompleted == false) {
          _completer?.completeError(error);
        }
      } finally {
        if (!_isDisposed) {
          _isLoadingNotifier.value = false;
        }
      }
    });

    return _completer?.future;
  }

  Future<T?> startTimerWithIsolate({
    required String value,
    required Map<String, dynamic> isolateData,
    required int length,
  }) async {
    if (_isDisposed) return null;

    cancel();

    _completer = Completer<T?>();
    _isLoadingNotifier.value = true;

    _timer = Timer(Duration(milliseconds: milliseconds), () async {
      if (_isDisposed) return;

      try {
        if (value.length >= length) {
          T? result;

          if (kIsWeb) {
            result = await _processDataDirectly(isolateData);
          } else {
            result = await _runInIsolate(isolateData);
          }

          if (!_isDisposed && _completer?.isCompleted == false) {
            _completer?.complete(result);
          }
        } else {
          if (!_isDisposed && _completer?.isCompleted == false) {
            _completer?.complete(null);
          }
        }
      } catch (error) {
        if (!_isDisposed && _completer?.isCompleted == false) {
          _completer?.completeError(error);
        }
      } finally {
        if (!_isDisposed) {
          _isLoadingNotifier.value = false;
        }
      }
    });

    return _completer?.future;
  }

  Future<T?> _processDataDirectly(Map<String, dynamic> data) async {
    if (_isDisposed) return null;

    try {
      return await Future.microtask(() {
        return _processInIsolate(data) as T?;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<T?> _runInIsolate(Map<String, dynamic> data) async {
    if (_isDisposed) return null;

    _receivePort = ReceivePort();

    try {
      _isolate = await Isolate.spawn(
        _isolateEntryPoint,
        _IsolateMessage(
          sendPort: _receivePort!.sendPort,
          data: data,
        ),
      );

      final completer = Completer<T?>();

      _receivePort!.listen((message) {
        if (message is _IsolateResult) {
          if (message.error != null) {
            completer.completeError(message.error!);
          } else {
            completer.complete(message.result as T?);
          }
        }
        _isolate?.kill(priority: Isolate.immediate);
        _receivePort?.close();
      });

      return await completer.future;
    } catch (error) {
      _isolate?.kill(priority: Isolate.immediate);
      _receivePort?.close();
      rethrow;
    }
  }

  static void _isolateEntryPoint(_IsolateMessage message) {
    try {
      final result = _processInIsolate(message.data);

      message.sendPort.send(_IsolateResult(result: result));
    } catch (error) {
      message.sendPort.send(_IsolateResult(error: error.toString()));
    }
  }

  static dynamic _processInIsolate(Map<String, dynamic> data) {
    return data['result'];
  }
}

class _IsolateMessage {
  final SendPort sendPort;
  final Map<String, dynamic> data;

  _IsolateMessage({required this.sendPort, required this.data});
}

class _IsolateResult {
  final dynamic result;
  final String? error;

  _IsolateResult({this.result, this.error});
}
