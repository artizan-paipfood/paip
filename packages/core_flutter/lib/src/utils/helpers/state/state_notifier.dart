import 'package:flutter/material.dart';

/// Define os possíveis estados de uma operação
///
/// [load] - Estado de carregamento
/// [complete] - Operação finalizada com sucesso
/// [error] - Operação finalizada com erro
/// [initial] - Estado inicial
/// [empty] - Estado vazio (sem dados)
enum Status {
  load,
  complete,
  error,
  initial,
  empty;

  bool get isLoading => this == Status.load;
  bool get isComplete => this == Status.complete;
  bool get isError => this == Status.error;
  bool get isEmpty => this == Status.empty;
  bool get isInitial => this == Status.initial;
}

/// Classe que representa o estado atual junto com possível erro
class StateData {
  final Status status;
  final Object? error;

  const StateData._({
    required this.status,
    this.error,
  });

  /// Cria um estado inicial
  factory StateData.initial() => StateData._(status: Status.initial);

  /// Cria um estado de carregamento
  factory StateData.loading() => StateData._(status: Status.load);

  /// Cria um estado completo
  factory StateData.complete() => StateData._(status: Status.complete);

  /// Cria um estado vazio
  factory StateData.empty() => StateData._(status: Status.empty);

  /// Cria um estado de erro
  factory StateData.error(Object error) => StateData._(status: Status.error, error: error);
}

/// Widget que observa mudanças de estado e renderiza o conteúdo apropriado
///
/// Utiliza [ValueNotifier] para notificar mudanças de estado e permite
/// definir widgets específicos para cada estado através de callbacks.
class StateNotifier extends StatelessWidget {
  /// Notificador de estado
  final ValueNotifier<StateData> stateNotifier;

  /// Widget a ser exibido no estado inicial
  final Widget Function(BuildContext context)? onInitial;

  /// Widget a ser exibido durante o carregamento
  final Widget Function(BuildContext context)? onLoad;

  /// Widget a ser exibido quando a operação for completada
  final Widget Function(BuildContext context)? onComplete;

  /// Widget a ser exibido em caso de erro
  final Widget Function(BuildContext context, Object? error)? onError;

  /// Widget a ser exibido quando não houver dados
  final Widget Function(BuildContext context)? onEmpty;

  const StateNotifier({
    required this.stateNotifier,
    super.key,
    this.onInitial,
    this.onLoad,
    this.onComplete,
    this.onError,
    this.onEmpty,
  });

  Widget _buildDefaultLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDefaultEmpty() {
    return const Center(
      child: Text('Nenhum dado encontrado'),
    );
  }

  Widget _buildDefaultError(Object? error) {
    return Center(
      child: Text('Ocorreu um erro: ${error?.toString() ?? "Erro desconhecido"}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StateData>(
      valueListenable: stateNotifier,
      builder: (context, state, _) {
        switch (state.status) {
          case Status.initial:
            return onInitial?.call(context) ?? const SizedBox.shrink();
          case Status.load:
            return onLoad?.call(context) ?? _buildDefaultLoading();
          case Status.complete:
            return onComplete?.call(context) ?? const SizedBox.shrink();
          case Status.empty:
            return onEmpty?.call(context) ?? _buildDefaultEmpty();
          case Status.error:
            return onError?.call(context, state.error) ?? _buildDefaultError(state.error);
        }
      },
    );
  }
}
