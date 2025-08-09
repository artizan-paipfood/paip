import 'package:flutter/material.dart';

import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/modules/changelog/presenters/viewmodels/changelog_viewmodel.dart';

class ChangelogPage extends StatefulWidget {
  final String project;
  const ChangelogPage({super.key, required this.project});

  @override
  State<ChangelogPage> createState() => _ChangelogPageState();
}

class _ChangelogPageState extends State<ChangelogPage> {
  final String _language = 'en';

  final _textEC = TextEditingController(text: '');
  final _viewmodel = ChangelogViewmodel();

  String _getLanguage(BuildContext context) {
    final pathParams = Modular.stateOf(context).uri.queryParameters;
    return pathParams['language'] ?? 'en';
  }

  void _setMarkdown(String markdown) {
    _textEC.text = markdown;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final language = _getLanguage(context);
      final project = ChangelogProject.values.byName(widget.project);
      _viewmodel.loadMarkdown(project: project, language: language);
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    _textEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: PSize.ii.paddingAll,
          child: StateNotifier(
            stateNotifier: _viewmodel.status,
            onComplete: (_) {
              _setMarkdown(_viewmodel.markdown);
              return SelectionArea(
                child: MarkdownAutoPreview(
                  controller: _textEC,
                  readOnly: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
