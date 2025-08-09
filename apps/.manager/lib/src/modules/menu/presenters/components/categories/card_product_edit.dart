import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/divider.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/card_size.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardProductEdit extends StatefulWidget {
  final ProductModel product;
  final CategoryModel category;
  const CardProductEdit({required this.product, required this.category, super.key});

  @override
  State<CardProductEdit> createState() => _CardProductEditState();
}

class _CardProductEditState extends State<CardProductEdit> {
  late final store = context.read<MenuStore>();
  final nameEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late ProductModel newProduct;
  SizeModel? sizePreselected;

  String get _currency => LocaleNotifier.instance.currency;

  @override
  void initState() {
    newProduct = widget.product.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CwTextFormFild(autofocus: true, label: context.i18n.nome, initialValue: newProduct.name, onChanged: (value) => newProduct.name = value, maskUtils: MaskUtils.cRequired()),
                                    CwTextFormFild(label: context.i18n.descricao, initialValue: newProduct.description, minLines: 1, maxLines: 3, onChanged: (value) => newProduct.description = value),
                                  ],
                                ),
                              ),
                              if (newProduct.sizes.where((element) => !element.isDeleted).isEmpty)
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        children: [
                                          CwTextFormFild(
                                            label: context.i18n.preco,
                                            initialValue: Utils.doubleToStringDecimal(newProduct.price),
                                            onChanged: (value) => newProduct.price = Utils.stringToDouble(value),
                                            maskUtils: MaskUtils.currency(isRequired: true),
                                            prefixText: _currency,
                                          ),
                                          CwTextFormFild(
                                            label: context.i18n.precoPromocional,
                                            initialValue: newProduct.promotionalPrice?.toStringAsFixed(2),
                                            onChanged: (value) => newProduct.promotionalPrice = Utils.stringToDouble(value),
                                            maskUtils: MaskUtils.currency(
                                              customValidate: (value) {
                                                if (Utils.stringToDouble(value) > newProduct.price) {
                                                  return context.i18n.precoPromocionalDeveSerMenorQuePreco;
                                                }
                                                return null;
                                              },
                                            ),
                                            prefixText: _currency,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const CwDivider(),
                          if (newProduct.sizes.where((element) => element.isDeleted == false).isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.i18n.tamanhos, style: context.textTheme.titleMedium?.copyWith(color: context.color.tertiaryColor)),
                                const Divider(
                                    // color: context.color.secondaryColor,
                                    ),
                                ...newProduct.sizes.map((size) {
                                  if (size.isDeleted) {
                                    return const SizedBox.shrink();
                                  }
                                  return CardSize(size: size, setPreselected: () => setState(() => store.setPreselectedSize(product: newProduct, size: size)), onDelete: () => setState(() => store.deleteSize(product: newProduct, size: size)));
                                }),
                                const CwDivider(),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CwTextButton(
                                onPressed: () {
                                  setState(() {
                                    store.insertSize(newProduct);
                                  });
                                },
                                label: context.i18n.addOpcao,
                                icon: PaipIcons.add,
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  CwTextButton(onPressed: () => store.cancelSaveProduct(category: widget.category, product: widget.product), label: context.i18n.cancelar),
                                  const SizedBox(width: 20),
                                  PButton(
                                    label: context.i18n.salvar,
                                    onPressed: () {
                                      if (formKey.currentState?.validate() ?? false) {
                                        widget.category.products.addClone(origin: widget.product, clone: newProduct);
                                        store.saveProduct(product: newProduct, category: widget.category);
                                      }
                                    },
                                  ),
                                ],
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
