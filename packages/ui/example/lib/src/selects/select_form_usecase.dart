import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:example/src/widget_base.dart';

final verifiedEmails = [
  'm@example.com',
  'm@google.com',
  'm@support.com',
];

@widgetbook.UseCase(name: 'Select form', type: UiSelect)
Widget buildSelectFormFormUseCase(BuildContext context) {
  return BaseWidgetForm(
      title: 'Select form',
      child: Row(
        children: [
          Expanded(
            child: UiSelectFormField<String>(
              id: 'email',
              minWidth: 350,
              initialValue: 'oi@gmail.com',
              options: verifiedEmails.map((email) => UiOption(value: email, child: Text(email))).toList(),
              selectedOptionBuilder: (context, value) => value == 'none' ? const Text('Select a verified email to display') : Text(value),
              placeholder: const Text('Select a verified email to display'),
              validator: (v) {
                if (v == null) {
                  return 'Please select an email to display';
                }
                return null;
              },
            ),
          ),
        ],
      ));
}
