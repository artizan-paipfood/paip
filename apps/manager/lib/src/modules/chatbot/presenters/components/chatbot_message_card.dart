import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/extensions/context.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChatbotMessageCard extends StatefulWidget {
  final MessageModel message;
  final Future<void> Function(MessageModel message) onSave;
  const ChatbotMessageCard({required this.message, required this.onSave, super.key});

  @override
  State<ChatbotMessageCard> createState() => _ChatbotMessageCardState();
}

class _ChatbotMessageCardState extends State<ChatbotMessageCard> {
  late final messageEC = TextEditingController(text: widget.message.message);
  late MessageModel _message = widget.message.copyWith();

  @override
  void dispose() {
    messageEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ArtCard(
      padding: PSize.i.paddingVertical + PSize.ii.paddingHorizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PSize.i.sizedBoxH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.message.status!.name.i18n().toUpperCase(), style: context.textTheme.titleMedium),
              ArtSwitch(
                initialValue: _message.enable,
                onChanged: (value) => _message = _message.copyWith(enable: value),
              ),
            ],
          ),
          PSize.i.sizedBoxH,
          ArtTextFormField(
            controller: messageEC,
            decoration: ArtDecoration(color: context.artColors().muted.withValues(alpha: 0.5)),
            onChanged: (value) => _message = _message.copyWith(message: value),
          ),
          PSize.i.sizedBoxH,
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: ReplaceMessageEnum.values
                      .map(
                        (e) => CwTagButton(
                          label: e.name.toUpperCase(),
                          colorSelected: context.color.neutral600,
                          onTap: () {
                            _insertTextAtCursor(messageEC, e.code);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ArtButton.outline(
                    child: Text(context.i18n.restaurar),
                    onPressed: () {
                      messageEC.text = widget.message.status!.messageDefaut.i18n();
                      _message = _message.copyWith(message: messageEC.text);
                      toast.showSucess(context.i18n.restauracaoEfetuada);
                    },
                  ),
                  PSize.i.sizedBoxW,
                  ArtButton(
                    child: Text(context.i18n.salvar),
                    onPressed: () async {
                      await widget.onSave(_message);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _insertTextAtCursor(TextEditingController controller, String textToInsert) {
    final text = controller.text;
    final cursorPosition = controller.selection.baseOffset;

    if (cursorPosition == -1) {
      controller
        ..text = text + textToInsert
        ..selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    } else {
      final newText = text.replaceRange(cursorPosition, cursorPosition, textToInsert);
      controller
        ..text = newText
        ..selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition + textToInsert.length));
    }
  }
}
