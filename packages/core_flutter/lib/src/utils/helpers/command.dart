import 'dart:async';
import 'package:core_flutter/src/utils/helpers/overlay_loader.dart';
import 'package:flutter/cupertino.dart';

class Command0 {
  const Command0._();

  static FutureOr<T?> execute<T>(
    FutureOr<T> Function() action, {
    String? analyticsDesc,
    void Function(T r)? onSuccess,
    VoidCallback? onFinally,
    void Function(Object e, StackTrace s)? onError,
  }) async {
    try {
      // if (analyticsDesc != null) unawaited(_crashAnalytics?.addBreadcrumb(Breadcrumb.userInteraction(subCategory: analyticsDesc)));
      final result = await action();
      onSuccess?.call(result);
      return result;
    } catch (e, stackTrace) {
      // if (e is! GenericException) await _crashAnalytics?.captureException(e, stackTrace: stackTrace, hint: Hint.withMap({'analyticsDesc': analyticsDesc}));
      if (onError != null) {
        onError.call(e, stackTrace);
      } else {
        rethrow;
      }
      return null;
    } finally {
      onFinally?.call();
    }
  }

  static FutureOr<T?> executeWithLoader<T>(
    BuildContext context,
    FutureOr<T> Function() action, {
    String? analyticsDesc,
    void Function(T r)? onSuccess,
    VoidCallback? onFinally,
    void Function(Object e, StackTrace s)? onError,
  }) async {
    if (!context.mounted) return null;

    try {
      // if (analyticsDesc != null) unawaited(_crashAnalytics?.addBreadcrumb(Breadcrumb.userInteraction(subCategory: analyticsDesc)));

      final isFuture = action is Future Function();
      if (isFuture && context.mounted) Loader.show(context);

      final result = await action();
      if (context.mounted) onSuccess?.call(result);
      return result;
    } catch (e, stackTrace) {
      // if (e is! GenericException) await _crashAnalytics?.captureException(e, stackTrace: stackTrace, hint: Hint.withMap({'analyticsDesc': analyticsDesc}));

      if (onError != null) {
        onError.call(e, stackTrace);
      } else {
        rethrow;
      }
      return null;
    } finally {
      onFinally?.call();
      if (context.mounted) Loader.hide();
    }
  }
}
