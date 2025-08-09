import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/helpers/breakpoints.dart';
import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/card_selector_complement.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/switch_required_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EndDrawerComplement extends StatefulWidget {
  final ComplementModel complement;
  final bool isEdit;
  const EndDrawerComplement({required this.complement, super.key, this.isEdit = false});

  @override
  State<EndDrawerComplement> createState() => _EndDrawerComplementState();
}

class _EndDrawerComplementState extends State<EndDrawerComplement> {
  late final store = context.read<MenuStore>();
  late ComplementModel newComplement = widget.complement.clone();
  ValueNotifier<int> buildSelectorsVN = ValueNotifier(0);
  late final qtyMinEC = TextEditingController(text: newComplement.qtyMin.toString());
  late final identifierEC = TextEditingController(text: newComplement.identifier);
  late bool identifierChange = newComplement.identifier.isEmpty ? false : true;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return CwDialogEndDrawer(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: PSize.iii.paddingHorizontal + PSize.iii.paddingTop,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.isEdit ? context.i18n.tituloEditarComplemento : context.i18n.tituloComplemento, style: context.textTheme.headlineLarge),
                      PSize.v.sizedBoxH,
                      ListenableBuilder(
                        listenable: store,
                        builder: (context, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CwTextFormFild(
                                          label: context.i18n.nome,
                                          hintText: context.i18n.extras,
                                          initialValue: newComplement.name,
                                          onChanged: (value) {
                                            newComplement.name = value;
                                            if (identifierChange == false) {
                                              identifierEC.text = value;
                                              newComplement.identifier = value;
                                            }
                                          },
                                          autofocus: true,
                                          maxLength: 40,
                                          tooltipMessage: context.i18n.tooltipNomeComplemento,
                                          maskUtils: MaskUtils.cRequired(),
                                        ),
                                        CwTextFormFild(
                                          label: context.i18n.identifier,
                                          hintText: context.i18n.hintIdentifier,
                                          controller: identifierEC,
                                          onChanged: (value) => newComplement.identifier = value,
                                          maxLength: 25,
                                          tooltipMessage: context.i18n.tooltipIdentificador,
                                          maskUtils: MaskUtils.cRequired(),
                                        ),

                                        Row(
                                          children: [
                                            CwTextFormFild(
                                              controller: qtyMinEC,
                                              onChanged: (value) {
                                                newComplement.qtyMin = int.tryParse(value) ?? 0;
                                                _qtyMinToRequired();
                                              },
                                              label: context.i18n.quantidadeMinima,
                                              hintText: context.i18n.hintQuantidadeMinima,
                                              autovalidateMode: AutovalidateMode.disabled,
                                              expanded: true,
                                              maskUtils: MaskUtils.onlyInt(isRequired: true),
                                            ),
                                            PSize.ii.sizedBoxW,
                                            CwTextFormFild(
                                              initialValue: newComplement.qtyMax.toString(),
                                              onChanged: (value) => newComplement.qtyMax = int.tryParse(value) ?? 0,
                                              label: context.i18n.quantidadeMaxima,
                                              hintText: context.i18n.hintQuantidadeMaxima,
                                              expanded: true,
                                              autovalidateMode: AutovalidateMode.disabled,
                                              maskUtils: MaskUtils.onlyInt(
                                                isRequired: true,
                                                customValidate: (value) {
                                                  final qtyMin = int.tryParse(qtyMinEC.text) ?? 0;
                                                  final qtyMax = int.tryParse(value ?? "") ?? 0;
                                                  if (qtyMax < qtyMin && qtyMax != 0) {
                                                    return context.i18n.validatorQuantidadeMaxima;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        // CwTextFormFild(),
                                      ],
                                    ),
                                  ),
                                  PSize.ii.sizedBoxW,
                                ],
                              ),
                              PSize.i.sizedBoxH,
                              ValueListenableBuilder(
                                valueListenable: buildSelectorsVN,
                                builder: (context, _, __) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(context.i18n.tipoDoSeletor, style: context.textTheme.labelMedium),
                                          SwitchRequiredWidget(
                                            value: newComplement.isRequired,
                                            onChanged: (value) {
                                              newComplement.isRequired = value;
                                              _switchRequiredToEC(value);
                                              buildSelectorsVN.value++;
                                            },
                                          ),
                                        ],
                                      ),
                                      PSize.ii.sizedBoxH,
                                      Flex(
                                        direction: PaipBreakpoint.phone.isBreakpoint(context) ? Axis.vertical : Axis.horizontal,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CardSelectorComplement(
                                            isSelected: newComplement.isMultiple == false,
                                            label: context.i18n.seletorUnico,
                                            body: context.i18n.descSeletorUnico,
                                            isMultiple: false,
                                            onTap: () {
                                              newComplement.isMultiple = false;
                                              buildSelectorsVN.value++;
                                            },
                                          ),
                                          CardSelectorComplement(
                                            isSelected: newComplement.isMultiple == true,
                                            label: context.i18n.seletorMultiplo,
                                            body: context.i18n.descSeletorMultiplo,
                                            isMultiple: true,
                                            onTap: () {
                                              newComplement.isMultiple = true;
                                              buildSelectorsVN.value++;
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: PSize.iii.paddingHorizontal + PSize.ii.paddingBottom + PSize.i.paddingTop,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PButton(
                    label: context.i18n.salvar,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        store.insertComplement(newComplement);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _qtyMinToRequired() {
    final qty = int.tryParse(qtyMinEC.text) ?? 0;
    if (qty > 0) {
      newComplement.isRequired = true;
    } else {
      newComplement.isRequired = false;
    }
    buildSelectorsVN.value++;
  }

  void _switchRequiredToEC(bool value) {
    if (!value) {
      qtyMinEC.text = 0.toString();
      newComplement.qtyMin = 0;
    }
    if (value) {
      qtyMinEC.text = 1.toString();
      newComplement.qtyMin = 1;
    }
  }
}
