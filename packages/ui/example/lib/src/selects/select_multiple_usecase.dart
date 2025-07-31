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
@widgetbook.UseCase(name: 'Select multiple', type: UiSelect)
Widget buildSelectMultipleUseCase(BuildContext context) {
  return BaseWidget(
      title: 'Select multiple',
      child: Row(
        children: [
          Expanded(
            child: UiSelect<String>.multiple(
              placeholder: const Text('Select a fruit'),
              selectedOptionsBuilder: (context, values) => Text(values.map((e) => _fruits[e]!).join(', ')),
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
              onChanged: print,
            ),
          ),
        ],
      ));
}
