import 'package:api/dtos/cep_awesomeapi.dart';
import 'package:api/services/process_env.dart';
import 'package:core/core.dart';

class CepAwesomeApi {
  final IClient client;
  CepAwesomeApi({required this.client});

  Future<AddressModel> getAddressByCep({required String cep}) async {
    final response = await client.get('https://cep.awesomeapi.com.br/json/${cep.onlyNumbers()}?token=${ProcessEnv.awesomeApiToken}');
    final data = response.data;
    final cepAwesomeapi = CepAwesomeapi.fromMap(data);
    return cepAwesomeapi.toAddressModel();
  }
}
