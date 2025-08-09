import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardItemEdit extends StatefulWidget {
  final ItemModel item;
  final ComplementModel complement;
  const CardItemEdit({required this.item, required this.complement, super.key});

  @override
  State<CardItemEdit> createState() => _CardItemEditState();
}

class _CardItemEditState extends State<CardItemEdit> {
  late final store = context.read<MenuStore>();
  final nameEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late ItemModel newItem;
  SizeModel? sizePreselected;
  String get _currency => LocaleNotifier.instance.currency;

  @override
  void initState() {
    newItem = widget.item.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: DecoratedBox(
          decoration: BoxDecoration(border: Border(left: BorderSide(color: context.color.tertiaryColor, width: 3))),
          child: Row(
            children: [
              Container(color: context.color.tertiaryColor, width: 8, height: 3),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: context.color.tertiaryColor, width: 3),
                      borderRadius: BorderRadius.circular(3),
                      color: context.color.primaryBG,
                      boxShadow: const [BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.25), blurRadius: 8, spreadRadius: -2, offset: Offset(0, 4)), BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.08), spreadRadius: 1)],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CwTextFormFild(autofocus: true, label: context.i18n.nome, initialValue: newItem.name, onChanged: (value) => newItem.name = value, maskUtils: MaskUtils.cRequired(), maxLength: 60, minLines: 1, maxLines: 3),
                          CwTextFormFild(label: context.i18n.descricao, initialValue: newItem.description, onChanged: (value) => newItem.description = value, minLines: 1, maxLines: 3),
                          Row(
                            children: [
                              CwTextFormFild(
                                label: context.i18n.preco,
                                initialValue: Utils.doubleToStringDecimal(newItem.price),
                                onChanged: (value) => newItem.price = Utils.stringToDouble(value),
                                maskUtils: MaskUtils.currency(isRequired: true),
                                prefixText: _currency,
                                flex: 2,
                                expanded: true,
                              ),
                              PSize.i.sizedBoxW,
                              CwTextFormFild(
                                label: context.i18n.precoPromocional,
                                initialValue: newItem.promotionalPrice.toStringAsFixed(2),
                                onChanged: (value) => newItem.promotionalPrice = Utils.stringToDouble(value),
                                maskUtils: MaskUtils.currency(
                                  customValidate: (value) {
                                    if (Utils.stringToDouble(value) > newItem.price) {
                                      return context.i18n.precoPromocionalDeveSerMenorQuePreco;
                                    }
                                    return null;
                                  },
                                ),
                                flex: 3,
                                expanded: true,
                                prefixText: _currency,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 8),
                              CwTextButton(onPressed: () => store.cancelSaveItem(complement: widget.complement, item: widget.item), label: context.i18n.cancelar),
                              const SizedBox(width: 20),
                              PButton(
                                label: context.i18n.salvar,
                                onPressed: () {
                                  if (formKey.currentState?.validate() ?? false) {
                                    widget.complement.items.addClone(origin: widget.item, clone: newItem);
                                    store.saveItem(item: newItem, complement: widget.complement);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
