import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:example/src/widget_base.dart';

List<String> typePressed = ['onTap', 'onTapFuture'];

onTap(String type) async {
  if (type == 'onTap') {
    log('onTap');
  } else {
    await Future.delayed(const Duration(seconds: 1), () {
      log('onTapFuture');
    });
  }
}

@UseCase(name: 'Primary', type: UiButton)
Widget primaryButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return _base(
    child: UiButton(
      suffixIcon: context.knobs.boolean(label: 'SuffixIcon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      icon: context.knobs.boolean(label: 'Icon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      onTap: () async {
        await onTap(type);
      },
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Text')),
    ),
  );
}

@UseCase(name: 'Destructive', type: UiButton)
Widget destructiveButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return _base(
    child: UiButton.destructive(
      suffixIcon: context.knobs.boolean(label: 'SuffixIcon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      icon: context.knobs.boolean(label: 'Icon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      onTap: () async {
        await onTap(type);
      },
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Text')),
    ),
  );
}

@UseCase(name: 'Secondary', type: UiButton)
Widget secondaryButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return _base(
    child: UiButton.secondary(
      suffixIcon: context.knobs.boolean(label: 'SuffixIcon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      icon: context.knobs.boolean(label: 'Icon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      onTap: () async {
        await onTap(type);
      },
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Text')),
    ),
  );
}

@UseCase(name: 'Outline', type: UiButton)
Widget outlineButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return _base(
    child: UiButton.outline(
      suffixIcon: context.knobs.boolean(label: 'SuffixIcon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      icon: context.knobs.boolean(label: 'Icon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      onTap: () async {
        await onTap(type);
      },
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Text')),
    ),
  );
}

@UseCase(name: 'Ghost', type: UiButton)
Widget ghostButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return _base(
    child: UiButton.ghost(
      suffixIcon: context.knobs.boolean(label: 'SuffixIcon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      icon: context.knobs.boolean(label: 'Icon', initialValue: true) ? const Icon(Icons.ac_unit) : null,
      onTap: () async {
        await onTap(type);
      },
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Text')),
    ),
  );
}

@UseCase(name: 'Link', type: UiButton)
Widget linkButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return _base(
    child: UiButton.link(
      onTap: () async {
        await onTap(type);
      },
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Text')),
    ),
  );
}

@UseCase(name: 'Raw', type: UiButton)
Widget rawButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return _base(
    child: UiButton.link(
      onTap: () async {
        await onTap(type);
      },
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Text')),
    ),
  );
}

@UseCase(name: 'Icon', type: UiButton)
Widget iconButton(BuildContext context) {
  final type = context.knobs.list(label: 'Pressed type', options: typePressed);
  return BaseWidget(
    child: UiButton.outline(
      onTap: () async {
        await onTap(type);
      },
      icon: const Icon(Icons.ac_unit),
      enabled: context.knobs.boolean(
        label: 'Enable',
        initialValue: true,
      ),
    ),
  );
}

Widget _base({required Widget child}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Row(
          children: [
            Expanded(child: child),
          ],
        ),
      ),
    ),
  );
}
