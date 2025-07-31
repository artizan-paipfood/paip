import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:example/src/widget_base.dart';

final verifiedEmails = [
  'm@example.com',
  'm@google.com',
  'm@support.com',
];
final controller = TextEditingController();
final mask = MaskTextInputFormatter(mask: '###.###.###-###', filter: {"#": RegExp(r'[0-9]')});
final formatter = CpfCnpjValidator();

@widgetbook.UseCase(name: 'Form', type: UiSelect)
Widget buildFormUseCase(BuildContext context) {
  return BaseWidgetForm(
      title: 'Select form',
      child: Column(
        children: [
          UiInputFormField(
            label: const Text('CPF/CNPJ'),
            controller: controller,
            formController: formatter,
            // inputFormatters: [mask],
            onChanged: (value) {
              print(value);
            },
          ),

          // TextFormField(
          //   controller: controller,
          //   inputFormatters: [mask],
          //   onChanged: (value) {
          //     if (value.length > 8) {
          //       controller.value = mask.updateMask(mask: '##.###.###/####-##');
          //     }
          //   },
          // )
        ],
      ));
}
