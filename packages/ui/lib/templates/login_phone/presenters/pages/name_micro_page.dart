import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class NameMicroPage extends StatefulWidget {
  final String? initialValue;
  final Function(String name) onSubmit;
  final String title;
  final String hint;
  const NameMicroPage({
    required this.onSubmit,
    required this.title,
    required this.hint,
    this.initialValue,
    super.key,
  });

  @override
  State<NameMicroPage> createState() => _NameState();
}

class _NameState extends State<NameMicroPage> {
  final formKey = GlobalKey<FormState>();
  late String name = widget.initialValue ?? '';

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      widget.onSubmit(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      floatingActionButton: FloatingActionButton(
        onPressed: _onSubmit,
        child: const Icon(Icons.arrow_forward),
      ),
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: PSize.ii.paddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: context.textTheme.titleLarge,
              ),
              CwTextFormFild.underlinded(
                hintText: widget.hint,
                style: context.textTheme.titleLarge,
                initialValue: widget.initialValue,
                autofocus: true,
                autocorrect: true,
                maskUtils: MaskUtils.cRequired(),
                keyboardType: TextInputType.name,
                onChanged: (value) => name = value,
                onFieldSubmitted: (value) => _onSubmit(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
