import 'package:dart_frog/dart_frog.dart';
import 'package:api/infra/services/process_env.dart';

Response onRequest(RequestContext context) {
  final port = ProcessEnv.port;

  final replacedPort = port.toString().replaceAll(RegExp(r'\d'), '!');

  return Response(body: 'Wellcome API Teste Paip Food $replacedPort', headers: {'Content-Type': 'text/plain'});
}
