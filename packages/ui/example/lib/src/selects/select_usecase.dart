import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:example/src/widget_base.dart';

final _fruits = {
  'apple': 'Apple',
  'banana': 'Banana',
  'blueberry': 'Blueberry',
  'grapes': 'Grapes',
  'pineapple': 'Pineapple',
};

@widgetbook.UseCase(name: 'Select', type: UiSelect)
Widget buildSelectUseCase(BuildContext context) {
  return BaseWidget(
      title: 'Select',
      child: Row(
        children: [
          Expanded(
            child: UiSelect<String>(
              placeholder: const Text('Select a fruit'),
              options: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(32, 6, 6, 6),
                  child: Text(
                    'Fruits',
                    textAlign: TextAlign.start,
                  ),
                ),
                ..._fruits.entries.map((e) => UiOption(value: e.key, child: Text(e.value))),
              ],
              selectedOptionBuilder: (context, value) => Text(_fruits[value]!),
              onChanged: print,
            ),
          ),
        ],
      ));
}
