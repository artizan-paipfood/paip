import 'dart:developer';
import 'dart:io';
import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LogService {
  late final String _logsPath;

  LogService() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (isWindows) {
      final Directory? directory = await getDownloadsDirectory();
      _logsPath = join(directory!.path, "logs.txt");
    } else {
      // Defina um caminho de arquivo de log alternativo para sistemas não-Windows, se necessário
      _logsPath = "logs.txt";
    }
  }

  Future<void> insertLog({required String content}) async {
    if (!isDesktop) return;
    final File file = File(_logsPath);
    late IOSink sink;

    try {
      sink = file.openWrite(mode: FileMode.append)..writeln(_formatLog(content));
    } catch (e) {
      log("Erro ao gravar log: $e");
    } finally {
      await sink.close();
    }
  }

  String _formatLog(String content) {
    return '''
===============================================
🕒 ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())} 🕒
$content
''';
  }

  String generateRequestLog({required bool isResponse, required String path, required var response, required Map params, String? error}) {
    final icon = isResponse ? '🚧' : '🌍';
    return '''
🕒 ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())} 🕒
$icon PATH: $path,
$icon PARAMS: $params 
$icon DATA: ${response.toString()},
${error != null ? "❌ $error" : ""}
''';
  }
}
