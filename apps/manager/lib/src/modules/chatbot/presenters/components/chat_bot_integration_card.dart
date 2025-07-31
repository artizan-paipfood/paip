import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChatBotIntegrationCard extends StatelessWidget {
  final bool initialValue;
  final Function(bool value) onChanged;
  const ChatBotIntegrationCard({required this.initialValue, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          ArtCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(PaipIcons.whatsApp),
                        PSize.i.sizedBoxW,
                        Text('Whatsapp'),
                      ],
                    ),
                    PSize.ii.sizedBoxW,
                    ArtBadge(
                      backgroundColor: initialValue ? Colors.green.withValues(alpha: .2) : Colors.red.withValues(alpha: .2),
                      foregroundColor: initialValue ? Colors.green : Colors.red,
                      child: Text(initialValue ? context.i18n.ativo : context.i18n.inativo),
                    ),
                  ],
                ),
                PSize.spacer.sizedBoxH,
                Align(
                  alignment: Alignment.centerRight,
                  child: ArtSwitch(
                    key: ValueKey(initialValue),
                    initialValue: initialValue,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
