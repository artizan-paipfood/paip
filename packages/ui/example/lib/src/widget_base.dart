import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  final String title;
  const BaseWidget({
    super.key,
    required this.child,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class BaseWidgetForm extends StatefulWidget {
  final Widget child;
  final String title;
  const BaseWidgetForm({
    super.key,
    required this.child,
    this.title = '',
  });

  @override
  State<BaseWidgetForm> createState() => _BaseWidgetFormState();
}

class _BaseWidgetFormState extends State<BaseWidgetForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.child,
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: UiButton.outline(
                      // expands: true,
                      onTap: () {
                        formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                  Expanded(
                    child: UiButton(
                      // expands: true,
                      onTap: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: const Text('Validate'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
