import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardSize extends StatefulWidget {
  final SizeModel size;
  final void Function() setPreselected;
  final void Function() onDelete;
  const CardSize({required this.size, required this.setPreselected, required this.onDelete, super.key});

  @override
  State<CardSize> createState() => _CardSizeState();
}

class _CardSizeState extends State<CardSize> {
  String get _currency => LocaleNotifier.instance.currency;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CwTextFormFild(autofocus: true, label: context.i18n.nome, expanded: true, initialValue: widget.size.name, onChanged: (value) => widget.size.name = value, maskUtils: MaskUtils.cRequired()),
            PSize.ii.sizedBoxW,
            SizedBox(
              width: 260,
              child: Row(
                children: [
                  CwTextFormFild(
                    expanded: true,
                    label: context.i18n.preco,
                    initialValue: Utils.doubleToStringDecimal(widget.size.price),
                    onChanged: (value) => widget.size.price = Utils.stringToDouble(value),
                    maskUtils: MaskUtils.currency(isRequired: true),
                    flex: 2,
                    prefixText: _currency,
                  ),
                  PSize.ii.sizedBoxW,
                  CwTextFormFild(
                    expanded: true,
                    label: context.i18n.precoPromocional,
                    initialValue: widget.size.promotionalPrice?.toStringAsFixed(2),
                    onChanged: (value) => widget.size.promotionalPrice = Utils.stringToDouble(value),
                    maskUtils: MaskUtils.currency(),
                    flex: 3,
                    prefixText: _currency,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CwTextFormFild(label: context.i18n.descricao, expanded: true, initialValue: widget.size.description, onChanged: (value) => widget.size.description = value),
            PSize.ii.sizedBoxW,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.5),
              child: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: widget.size.isPreSelected ? context.color.tertiaryColor.withOpacity(0.1) : Colors.transparent,
                      borderRadius: PSize.i.borderRadiusAll,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Ink(
                        decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll, border: Border.all(color: widget.size.isPreSelected ? context.color.tertiaryColor : Colors.transparent, width: 2)),
                        child: InkWell(
                          hoverColor: context.color.tertiaryColor.withOpacity(0.1),
                          onTap: widget.setPreselected,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Row(
                              children: [
                                Icon(widget.size.isPreSelected ? PaipIcons.check : PaipIcons.checkCircle, color: widget.size.isPreSelected ? context.color.tertiaryColor : context.color.primaryText),
                                PSize.i.sizedBoxW,
                                Text(context.i18n.preSelecionado, style: TextStyle(color: widget.size.isPreSelected ? context.color.tertiaryColor : context.color.primaryText, fontWeight: widget.size.isPreSelected ? FontWeight.w500 : null)).center,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: widget.onDelete, icon: const Icon(PIcons.strokeRoundedDelete02)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
