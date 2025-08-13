import 'package:api/domain/dtos/cep_awesomeapi.dart';
import 'package:api/infra/services/process_env.dart';
import 'package:core/core.dart';

class CepAwesomeApi {
  final IClient client;
  CepAwesomeApi({required this.client});

  Future<AddressModel> getAddressByCep({required String cep}) async {
    try {
      final response = await client.get('https://cep.awesomeapi.com.br/json/${cep.onlyNumbers()}?token=${ProcessEnv.awesomeApiToken}');
      final data = response.data;
      final cepAwesomeapi = CepAwesomeapi.fromMap(data);
      return cepAwesomeapi.toAddressModel();
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'invalid') throw CepInvalidException();
      throw e;
    }
  }
}
