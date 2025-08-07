import 'package:auth/auth.dart';
import 'package:core/core.dart';

class SupabaseAuthInterceptor extends Interceptor {
  final Dio dio;

  SupabaseAuthInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Verifica se a requisição precisa de autenticação

    // Busca os tokens do cache
    final tokens = await AuthTokensCache.getTokens();
    if (tokens?.accessToken != null && tokens!.accessToken.isNotEmpty) {
      // Adiciona o token Bearer no header Authorization
      options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final dto = _HandleDto(err: err, handler: handler, dio: dio);
    switch (err.response?.statusCode) {
      case 401:
        await _handle401(dto);
        break;
      case 418:
        await _handle418(dto);
        break;
      case 404:
        await _handle404(dto);
        break;
      case 422:
        await _handle422(dto);
        break;

      case 428:
        await _handle428(dto);
        break;
      default:
        handler.next(err);
        break;
    }
  }
}

/// 401 - Token inválido
Future<void> _handle401(_HandleDto dto) async {
  await AuthTokensCache.clear();
  // ModularEvent.fire(LogoutEvent());
  dto.handler.next(dto.err);
}

/// 418 - Token expirado
Future<void> _handle418(_HandleDto dto) async {
  // try {
  //   final tokens = await AuthTokensCache.getTokens();
  //   if (tokens?.refreshToken != null && tokens!.refreshToken.isNotEmpty) {
  //     // Faz refresh do token
  //     final authResponse = await dto.authApi.refreshToken(
  //       refreshToken: tokens.refreshToken,
  //       authorization: tokens.accessToken,
  //     );

  //     final newTokens = AuthTokens(refreshToken: authResponse.refreshToken, accessToken: authResponse.accessToken);

  //     // Salva os novos tokens
  //     await dto.authCacheService.saveTokens(newTokens);

  //     // Refaz a requisição original com o novo token
  //     final requestOptions = dto.err.requestOptions;
  //     requestOptions.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';

  //     // Cria um novo cliente Dio para refazer a requisição
  //     final dioResponse = await dto.dio.fetch(requestOptions);

  //     return dto.handler.resolve(dioResponse);
  //   } else {
  //     await dto.authCacheService.deleteTokens();
  //     ModularEvent.fire(UnauthorizedEvent());
  //   }
  // } catch (e) {
  //   // Se falhar o refresh, limpa os tokens e deixa o erro passar
  //   await dto.authCacheService.deleteTokens();
  //   if (e is DioException) return dto.handler.next(e);
  // }
}

/// 404 - Recurso não encontrado
Future<void> _handle404(_HandleDto dto) async {
  // ModularEvent.fire(NotFoundEvent());
  dto.handler.next(dto.err);
}

/// 422 - Erro de formulário
Future<void> _handle422(_HandleDto dto) async {
  // ModularEvent.fire(FormExceptionEvent(message: dto.message));
  dto.handler.next(dto.err);
}

/// 428 - Precisa selecionar estabelecimento
Future<void> _handle428(_HandleDto dto) async {
  // ModularEvent.fire(NeedSelectEstablishmentEvent());
  dto.handler.next(dto.err);
}

class _HandleDto {
  final DioException err;
  final ErrorInterceptorHandler handler;
  final Dio dio;
  final String? message;

  _HandleDto({
    required this.err,
    required this.handler,
    required this.dio,

    // ignore: unused_element_parameter
    this.message,
  });
}
