import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:api/services/_back_initializer.dart';

Future<void> init(InternetAddress ip, int port) async {
  BackInitializer.init();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  print('Running on $ip:$port');
  return await serve(handler, ip, port);
}
