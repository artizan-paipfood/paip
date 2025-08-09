import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app/src/core/errors/generic_error.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> execute(
  BuildContext context, {
  required FutureOr<void> Function() action,
  VoidCallback? onSuccess,
  VoidCallback? onFinally,
  VoidCallback? onError,
  bool rethrowError = false,
}) async {
  final isFuture = action is Future;
  try {
    if (isFuture) {
      Loader.show(context);
    }
    await action();
    if (context.mounted) {
      onSuccess?.call();
    }
  } catch (e, stackTrace) {
    if (e is! GenericError) Sentry.captureException(e, stackTrace: stackTrace);
    onError ?? banner.showError(e.toString());
    if (rethrowError) rethrow;
  } finally {
    onFinally?.call();
    if (isFuture) {
      Loader.hide();
    }
  }
}
