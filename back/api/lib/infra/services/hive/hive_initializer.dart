import 'dart:developer';
import 'dart:io';

import 'package:api/infra/services/hive/hive_registrar.g.dart';
import 'package:hive_ce/hive.dart';

class HiveInitializer {
  HiveInitializer._();
  static void init() {
    try {
      String hivePath = Directory.current.path;

      if (hivePath.isEmpty || hivePath == '/') {
        hivePath = '/tmp/cache';
      } else {
        hivePath = '$hivePath/caches';
      }

      final hiveDir = Directory(hivePath);
      if (!hiveDir.existsSync()) {
        hiveDir.createSync(recursive: true);
      }

      log('Inicializando Hive no diretório: $hivePath');

      Hive
        ..init(hivePath)
        ..registerAdapters();
    } catch (e) {
      log('Erro ao inicializar Hive: $e');
      // Fallback para diretório temporário
      final fallbackPath = '/tmp/hive_fallback';
      final fallbackDir = Directory(fallbackPath);
      if (!fallbackDir.existsSync()) {
        fallbackDir.createSync(recursive: true);
      }

      log('Usando diretório fallback: $fallbackPath');
      Hive
        ..init(fallbackPath)
        ..registerAdapters();
    }
  }
}
