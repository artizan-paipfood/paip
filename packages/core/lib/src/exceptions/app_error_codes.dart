// ignore_for_file: constant_identifier_names
import 'dart:io';

class AppErrorScope {
  final String key;
  final int min;
  final int max;

  AppErrorScope({required this.key, required this.min, required this.max});
}

class AppErrorValue {
  final int code;
  final int httpStatus;

  const AppErrorValue({required this.code, this.httpStatus = HttpStatus.badRequest});
}

class ErrorCode {
  // Autenticação (1000-1399)
  static List<AppErrorScope> scopes = [
    AppErrorScope(key: 'erros_de_autenticacao', min: 1000, max: 1399),
    AppErrorScope(key: 'erros_de_endereco', min: 1400, max: 1499),
    AppErrorScope(key: 'erros_de_validacao', min: 2000, max: 2999),
    AppErrorScope(key: 'erros_de_rede', min: 3000, max: 3999),
    AppErrorScope(key: 'erros_de_servidor', min: 4000, max: 4999),
    AppErrorScope(key: 'erros_de_banco_de_dados', min: 5000, max: 5999),
    AppErrorScope(key: 'erros_de_arquivo', min: 6000, max: 6999),
    AppErrorScope(key: 'erros_de_generico', min: 9000, max: 9999),
  ];

  static List<AppErrorValue> values = [
    CREDENCIAIS_INVALIDAS,
    TOKEN_EXPIRADO,
    TOKEN_INVALIDO,
    USUARIO_NAO_AUTORIZADO,
    SESSAO_EXPIRADA,
    ENDERECO_FORA_DO_RAIO_DE_ENTREGA,
    ENDERECO_NAO_ENCONTRADO,
    CEP_INVALIDO,
    DADOS_INVALIDOS,
    SEM_CONEXAO,
    TIMEOUT,
    CONEXAO_RECUSADA,
  ];

  // Autenticação (1000-1399)
  static const AppErrorValue CREDENCIAIS_INVALIDAS = AppErrorValue(code: 1001, httpStatus: HttpStatus.unauthorized);
  static const AppErrorValue TOKEN_EXPIRADO = AppErrorValue(code: 1002, httpStatus: HttpStatus.unauthorized);
  static const AppErrorValue TOKEN_INVALIDO = AppErrorValue(code: 1003, httpStatus: HttpStatus.unauthorized);
  static const AppErrorValue USUARIO_NAO_AUTORIZADO = AppErrorValue(code: 1004, httpStatus: HttpStatus.unauthorized);
  static const AppErrorValue SESSAO_EXPIRADA = AppErrorValue(code: 1005, httpStatus: HttpStatus.unauthorized);
  static const AppErrorValue REFRESH_TOKEN_NOT_FOUND = AppErrorValue(code: 1006, httpStatus: HttpStatus.unauthorized);
  static const AppErrorValue REFRESH_TOKEN_EXPIRED = AppErrorValue(code: 1007, httpStatus: HttpStatus.unauthorized);
  static const AppErrorValue DISPOSITIVE_AUTH_ID_EXPIRED = AppErrorValue(code: 1008, httpStatus: HttpStatus.unauthorized);

  // Endereço (1400-1499)

  static const AppErrorValue ENDERECO_FORA_DO_RAIO_DE_ENTREGA = AppErrorValue(code: 1401, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue ENDERECO_NAO_ENCONTRADO = AppErrorValue(code: 1402, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue CEP_INVALIDO = AppErrorValue(code: 1403, httpStatus: HttpStatus.badRequest);

  // Validação (2000-2999)

  static const AppErrorValue DADOS_INVALIDOS = AppErrorValue(code: 2001, httpStatus: HttpStatus.badRequest);

  // Rede (3000-3999)

  static const AppErrorValue SEM_CONEXAO = AppErrorValue(code: 3001, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue CONEXAO_RECUSADA = AppErrorValue(code: 3003, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue TIMEOUT = AppErrorValue(code: 3002, httpStatus: HttpStatus.badRequest);

  // Arquivo (6000-6999)

  static const AppErrorValue ARQUIVO_NAO_ENCONTRADO = AppErrorValue(code: 6001, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue ERRO_LEITURA_ARQUIVO = AppErrorValue(code: 6002, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue ERRO_ESCRITA_ARQUIVO = AppErrorValue(code: 6003, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue ARQUIVO_CORROMPIDO = AppErrorValue(code: 6004, httpStatus: HttpStatus.badRequest);
  static const AppErrorValue PERMISSAO_NEGADA = AppErrorValue(code: 6005, httpStatus: HttpStatus.badRequest);
}
