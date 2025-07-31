import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChangelogViewmodel extends ChangeNotifier {
  String _markdown = '';

  String get markdown => _markdown;

  final ValueNotifier<StateData> _status = ValueNotifier(StateData.loading());
  ValueNotifier<StateData> get status => _status;

  Future<String> loadMarkdown({required ChangelogProject project, required String language}) async {
    final path = "assets/changelog/${project.name}/CHANGELOG_$language.md";
    _markdown = await rootBundle.loadString(path);
    _status.value = StateData.complete();
    return _markdown;
  }

  void emit() {
    notifyListeners();
  }
}
