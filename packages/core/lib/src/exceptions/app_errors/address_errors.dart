import 'package:core/core.dart';

class EnderecoForaDoRaioDeEntregaError extends AppError {
  EnderecoForaDoRaioDeEntregaError() : super(code: ErrorCode.ENDERECO_FORA_DO_RAIO_DE_ENTREGA.code);
}

class CepInvalidException extends AppError {
  CepInvalidException() : super(code: ErrorCode.CEP_INVALIDO.code);
}

class AddressError {
  static bool isEnderecoForaDoRaioDeEntrega(AppError erro) {
    return erro.code == ErrorCode.ENDERECO_FORA_DO_RAIO_DE_ENTREGA.code;
  }

  static bool isCepInvalid(AppError erro) {
    return erro.code == ErrorCode.CEP_INVALIDO.code;
  }
}
