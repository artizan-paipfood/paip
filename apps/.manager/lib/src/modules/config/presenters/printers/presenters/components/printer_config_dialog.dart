import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/stores/layout_printer_store.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/core/services/printer/printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/ui_order_print.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_dialog_manager.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/switch_required_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/p_drop_menu_form.dart';

class PrinterConfigDialog extends StatefulWidget {
  final PrinterViewmodel viewmodel;
  final void Function(PrinterDto printerDto) onSave;
  final PrinterDto printerDto;
  const PrinterConfigDialog({required this.viewmodel, required this.onSave, required this.printerDto, super.key});

  @override
  State<PrinterConfigDialog> createState() => _PrinterConfigDialogState();
}

class _PrinterConfigDialogState extends State<PrinterConfigDialog> {
  late PrinterDto _dto = widget.printerDto.copyWith();
  OrderModel get order => OrdersStore.instance.orders.isNotEmpty ? OrdersStore.instance.orders.last : OrderModel(id: uuid, establishmentId: uuid, cartProducts: [], customer: CustomerModel(addresses: []));

  late final qtyPrinterEC = TextEditingController(text: widget.printerDto.qtyCopy.toString());
  late final numberColumnsEC = TextEditingController(text: widget.printerDto.numberColumns.toString());
  late final layoutPrinterEC = TextEditingController(text: widget.printerDto.layoutPrinter.toString());
  LayoutPrinterDto get layoutPrinter => LayoutPrinterStore.instance.getByName(layoutPrinterEC.text);
  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text(context.i18n.configuracoes),
      actions: [
        Row(children: [Expanded(child: PButton(label: context.i18n.salvar, onPressed: () => widget.onSave(_dto)))]),
      ],
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListenableBuilder(
            listenable: LayoutPrinterStore.instance,
            builder: (context, _) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PDropMenuForm(
                        isExpanded: true,
                        labelText: context.i18n.quantidade,
                        controller: qtyPrinterEC,
                        initialSelection: _dto.qtyCopy,
                        dropdownMenuEntries: widget.viewmodel.qtys.map((e) => DropdownMenuEntry(value: e, label: "$e")).toList(),
                        onSelected: (value) {
                          _dto = _dto.copyWith(qtyCopy: value);
                        },
                      ),
                      PDropMenuForm<int>(
                        hintText: "Default 55",
                        labelText: context.i18n.colunas,
                        isExpanded: true,
                        controller: numberColumnsEC,
                        initialSelection: _dto.numberColumns,
                        onSelected: (columns) {
                          _dto = _dto.copyWith(numberColumns: columns);
                        },
                        dropdownMenuEntries: widget.printerDto.getColumns().map((device) => DropdownMenuEntry(value: device, label: (device).toString())).toList(),
                      ),
                      PSize.spacer.sizedBoxH,
                      SizedBox(
                        width: double.infinity,
                        child: SwitchRequiredWidget(
                          label: context.i18n.ativa,
                          onChanged: (value) {
                            setState(() {
                              _dto = _dto.copyWith(enable: value);
                            });
                          },
                          value: _dto.enable,
                        ),
                      ),
                      PSize.spacer.sizedBoxH,
                      SizedBox(
                        width: double.infinity,
                        child: SwitchRequiredWidget(
                          label: context.i18n.beep,
                          onChanged: (value) {
                            setState(() {
                              _dto = _dto.copyWith(beep: value);
                            });
                          },
                          value: _dto.beep,
                        ),
                      ),
                      PSize.spacer.sizedBoxH,
                      SizedBox(
                        width: double.infinity,
                        child: SwitchRequiredWidget(
                          label: "80mm",
                          onChanged: (value) {
                            setState(() {
                              _dto = _dto.copyWith(is80mm: value);
                            });
                          },
                          value: _dto.is80mm,
                        ),
                      ),
                      PSize.spacer.sizedBoxH,
                      SizedBox(
                        width: double.infinity,
                        child: SwitchRequiredWidget(
                          label: context.i18n.espelharHorizontalmente,
                          onChanged: (value) {
                            setState(() {
                              _dto = _dto.copyWith(mirror: value);
                            });
                          },
                          value: _dto.mirror,
                        ),
                      ),
                      PSize.spacer.sizedBoxH,
                      CwTextFormFild(
                        label: 'Text Scale',
                        initialValue: widget.printerDto.textScale.toString(),
                        maskUtils: MaskUtils.decimalDot(),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _dto = _dto.copyWith(textScale: double.tryParse(value) ?? 1);
                            });
                          }
                        },
                      ),
                      PSize.spacer.sizedBoxH,
                      PDropMenuForm<LayoutPrinterDto>(
                        isExpanded: true,
                        labelText: context.i18n.layoutImpresssao,
                        controller: layoutPrinterEC,
                        dropdownMenuEntries: LayoutPrinterStore.instance.layoutPrinters.map((e) => DropdownMenuEntry(value: e, label: e.layoutPrinter.name)).toList(),
                        onSelected: (value) {
                          setState(() {
                            layoutPrinterEC.text = value!.layoutPrinter.name;
                            _dto = _dto.copyWith(layoutPrinter: value.layoutPrinter.name);
                          });
                        },
                        initialSelection: LayoutPrinterStore.instance.getByName(_dto.layoutPrinter),
                      ),
                      PSize.spacer.sizedBoxH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CwOutlineButton(
                              label: 'Gerenciar layouts',
                              onPressed: () {
                                showDialog(context: context, builder: (context) => LayoutDialogManager());
                              },
                              icon: PIcons.strokeRoundedSettings02,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          VerticalDivider(color: context.color.border),
          SingleChildScrollView(child: SizedBox(width: 300, child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: _dto.textScale * .54), child: UiOrderPrint(layoutPrinterDto: layoutPrinter, order: order, tableNumber: null)))),
        ],
      ),
    );
  }
}
