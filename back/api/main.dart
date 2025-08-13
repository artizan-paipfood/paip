import 'dart:io';
import 'package:api/infra/services/back_initializer.dart';
import 'package:core/core.dart';
import 'package:dart_frog/dart_frog.dart';

Future<void> init(InternetAddress ip, int port) async {
  await SlangDartCore.initalize();
  BackInitializer.init();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  print('Running on $ip:$port');
  return await serve(handler, ip, port);
}
