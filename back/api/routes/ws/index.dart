import 'package:dart_frog/dart_frog.dart';
import 'package:api/services/ws/ws_teste_service.dart'; // Biblioteca para gerar IDs únicos

final ws = WsTesteService();

Future<Response> onRequest(RequestContext context) async {
  return ws.onRequest(context, onEvent: (event) {
    print('batatinha: $event');
  });
}
