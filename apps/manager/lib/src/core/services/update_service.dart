import 'dart:async';
import 'dart:io';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UpdateService {
  final IClient http;
  UpdateService({required this.http}) {
    PackageInfo.fromPlatform().then((value) => packageInfo = value);
  }

  PackageInfo? packageInfo;
  String get locale => LocaleNotifier.instance.locale.name;

  Future<VersionModel?> checkForUpdate(BuildContext context) async {
    final platform = getPlatForm();
    final request = await http.get("${Env.supaBaseUrl}/rest/v1/versions?order=created_at.desc&platform=eq.$platform&country_code=eq.$locale&select=*", headers: {"apiKey": Env.supaApiKey});

    final List list = request.data;
    if (list.isEmpty) return null;

    final versions = list.map<VersionModel>((data) {
      return VersionModel.fromMap(data);
    }).toList();

    final latestVersion = versions.first;
    final currentVersion = _getVersionParts();

    final newVersionParts = _buildVersionParts(latestVersion.version);

    if (_compareVersions(currentVersion, newVersionParts) < 0) {
      return latestVersion;
    }

    return null;
  }

  String getCurrentVersion() {
    String? buildNumber = packageInfo!.buildNumber;
    if ((buildNumber == packageInfo?.version) || buildNumber.isEmpty || buildNumber == '1') buildNumber = null;
    String versionString = '';

    if (buildNumber == null) {
      versionString = packageInfo!.version;
    } else {
      versionString = "${packageInfo!.version}+$buildNumber";
    }

    return versionString;
  }

  List<int> _buildVersionParts(String version) => Utils.onlyNumbersRgx(version.replaceAll('+', '.')).split('.').map(int.parse).toList();
  List<int> _getVersionParts() {
    return _buildVersionParts(getCurrentVersion());
  }

  int _compareVersions(List<int> v1, List<int> v2) {
    for (int i = 0; i < v1.length; i++) {
      if (i >= v2.length || v1[i] > v2[i]) return 1;
      if (v1[i] < v2[i]) return -1;
    }
    return v1.length < v2.length ? -1 : 0;
  }

  Future<void> installUpdate({required String urlDownload, required String exeFileName, void Function(int, int)? onReceiveProgress}) async {
    final dirDownloads = await getDownloadsDirectory();
    final String outputPath = '${dirDownloads!.path}/$exeFileName';
    final installer = File(outputPath);
    if (await installer.exists()) {
      await installer.delete();
    }

    if (isWindows) {
      await http.download(urlDownload, savePath: outputPath, onReceiveProgress: onReceiveProgress);
      unawaited(compute(_runExe, outputPath));
      Future.delayed(25.seconds, () => exit(0));
    }
  }
}

Future<void> _runExe(String outputPath) async {
  final process = await Process.start(outputPath, []);
  final outputCode = await process.exitCode;
  debugPrint('Processo concluído com código de saída: $outputCode');
}
