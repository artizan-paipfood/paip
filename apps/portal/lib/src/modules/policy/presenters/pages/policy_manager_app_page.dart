import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/modules/policy/domain/markdows/policy_manager_app.dart';

class PolicyManagerAppPage extends StatefulWidget {
  const PolicyManagerAppPage({super.key});

  @override
  State<PolicyManagerAppPage> createState() => _PolicyManagerAppPageState();
}

class _PolicyManagerAppPageState extends State<PolicyManagerAppPage> {
  final textEC = TextEditingController(text: PolicyManagerApp.mdText);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: PSize.ii.paddingAll,
          child: MarkdownAutoPreview(
            controller: textEC,
            readOnly: true,
          ),
        ),
      ),
    );
  }
}
