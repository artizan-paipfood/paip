import 'package:flutter/material.dart';

/// Widget que gerencia estados de Future de forma simplificada.
///
/// Permite tratar diferentes estados de uma operação assíncrona:
/// - Loading: Estado de carregamento
/// - Error: Estado de erro
/// - Empty: Estado vazio (opcional)
/// - Complete: Estado com dados
class FutureState<T> extends StatelessWidget {
  /// Se true, ignora a verificação de lista vazia
  final bool ignoreListEmpty;

  /// Future que será observado
  final Future<T> future;

  /// Dados iniciais opcionais
  final T? initialData;

  /// Builder para estado de erro
  final Widget Function(BuildContext context, Object? error)? onError;

  /// Builder para estado de carregamento
  final Widget Function(BuildContext context)? onLoading;

  /// Builder para estado completo com dados
  final Widget Function(BuildContext context, T data) onComplete;

  /// Builder para estado vazio
  final Function(BuildContext context)? onEmpty;

  const FutureState({
    required this.future,
    required this.onComplete,
    super.key,
    this.initialData,
    this.onError,
    this.onLoading,
    this.onEmpty,
    this.ignoreListEmpty = false,
  });

  bool _isEmptyData(T? data) {
    if (data == null) return true;
    if (data is List) return data.isEmpty;
    if (data is Map) return data.isEmpty;
    if (data is String) return data.isEmpty;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (context, snapshot) {
        final status = snapshot.connectionState;

        if (status == ConnectionState.waiting) {
          if (onLoading != null) {
            return onLoading!(context);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }

        if (status == ConnectionState.done) {
          if (snapshot.hasData && !_isEmptyData(snapshot.data)) {
            return onComplete(context, snapshot.data as T);
          }
          if (!snapshot.hasData && ignoreListEmpty) {
            return onComplete(context, snapshot.data as T);
          }
          if (onEmpty != null) {
            return onEmpty!(context);
          }
        }

        if (snapshot.hasError) {
          debugPrint('FutureState Error: ${snapshot.error}');
          if (onError != null) {
            return onError!(context, snapshot.error);
          }
          throw Exception('FutureState error: ${snapshot.error}');
        }

        return const SizedBox.shrink();
      },
    );
  }
}
