import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class ICrashAnalytics {
  Future<void> addBreadcrumb(Breadcrumb breadcrumb);
  Future<void> captureException(dynamic throwable, {dynamic stackTrace, Hint? hint, FutureOr<void> Function(Scope)? withScope});
}

class SentryCrashAnalytics implements ICrashAnalytics {
  @override
  Future<void> addBreadcrumb(Breadcrumb breadcrumb) async {
    await Sentry.addBreadcrumb(breadcrumb);
  }

  @override
  Future<void> captureException(dynamic throwable, {dynamic stackTrace, Hint? hint, FutureOr<void> Function(Scope)? withScope}) async {
    await Sentry.captureException(
      throwable,
      stackTrace: stackTrace,
      hint: hint,
      withScope: withScope,
    );
  }
}

ICrashAnalytics? _crashAnalytics;

void initializeCrashAnalytics(ICrashAnalytics crashAnalytics) {
  _crashAnalytics = crashAnalytics;
}

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
      if (analyticsDesc != null) unawaited(_crashAnalytics?.addBreadcrumb(Breadcrumb.userInteraction(subCategory: analyticsDesc)));
      final result = await action();
      onSuccess?.call(result);
      return result;
    } catch (e, stackTrace) {
      if (e is! GenericException) await _crashAnalytics?.captureException(e, stackTrace: stackTrace, hint: Hint.withMap({'analyticsDesc': analyticsDesc}));
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
      if (analyticsDesc != null) unawaited(_crashAnalytics?.addBreadcrumb(Breadcrumb.userInteraction(subCategory: analyticsDesc)));

      final isFuture = action is Future Function();
      if (isFuture && context.mounted) Loader.show(context);

      final result = await action();
      if (context.mounted) onSuccess?.call(result);
      return result;
    } catch (e, stackTrace) {
      if (e is! GenericException) await _crashAnalytics?.captureException(e, stackTrace: stackTrace, hint: Hint.withMap({'analyticsDesc': analyticsDesc}));

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
