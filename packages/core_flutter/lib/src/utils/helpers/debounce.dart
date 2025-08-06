// part of 'package:paipfood_package/paipfood_package.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';

class Debounce {
  final int milliseconds;
  Timer? _timer;
  Isolate? _isolate;
  ReceivePort? _receivePort;
  bool _isDisposed = false;
  void Function(Object? error)? onError;

  Debounce({this.milliseconds = 500, this.onError});

  void dispose() {
    try {
      _isDisposed = true;
      _timer?.cancel();
      _isolate?.kill(priority: Isolate.immediate);
      _receivePort?.close();
    } catch (error) {
      onError?.call(error);
    }
  }

  void cancel() {
    try {
      _timer?.cancel();
      _isolate?.kill(priority: Isolate.immediate);
      _receivePort?.close();
    } catch (error) {
      onError?.call(error);
    }
  }

  void run(VoidCallback callback) {
    if (_isDisposed) return;

    try {
      _timer?.cancel();
      _isolate?.kill(priority: Isolate.immediate);
      _receivePort?.close();
    } catch (error) {
      onError?.call(error);
    }

    _timer = Timer(Duration(milliseconds: milliseconds), () {
      if (_isDisposed) return;

      try {
        if (kIsWeb) {
          callback();
        } else {
          _runInIsolate(callback);
        }
      } catch (error) {
        onError?.call(error);
      }
    });
  }

  void _runInIsolate(VoidCallback callback) {
    try {
      _receivePort = ReceivePort();

      // Para operações simples, executamos diretamente
      // Para operações complexas que precisam de isolate,
      // seria necessário uma abordagem diferente
      callback();

      _cleanupIsolate();
    } catch (error) {
      onError?.call(error);
      _cleanupIsolate();
    }
  }

  void _cleanupIsolate() {
    try {
      _isolate?.kill(priority: Isolate.immediate);
      _receivePort?.close();
      _isolate = null;
      _receivePort = null;
    } catch (error) {
      onError?.call(error);
    }
  }
}
