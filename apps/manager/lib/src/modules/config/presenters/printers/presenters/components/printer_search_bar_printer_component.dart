import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/services/printer/printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/printer_config_dialog.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class PrinterSearchBarComponent extends StatefulWidget {
  final void Function(PrinterDto printerDto) savePrinter;
  final PrinterDto printerDto;
  const PrinterSearchBarComponent({required this.savePrinter, required this.printerDto, super.key});

  @override
  State<PrinterSearchBarComponent> createState() => _PrinterSearchBarComponentState();
}

class _PrinterSearchBarComponentState extends State<PrinterSearchBarComponent> {
  PrinterEntity get _printer => widget.printerDto.printer;
  late final impressoraEC = TextEditingController(text: _printer.name);
  late final viewmodel = context.read<PrinterViewmodel>();

  List<PrinterEntity> printers = [];

  ValueNotifier<StateData> state = ValueNotifier(StateData.loading());

  @override
  void initState() {
    load(_printer.printerType);
    super.initState();
  }

  Future<void> load(PaipPrinterType printerType) async {
    state.value = StateData.loading();
    if (printerType == PaipPrinterType.network) {
      state.value = StateData.complete();
      return;
    }
    printers = await viewmodel.getPrinters(printerType);
    state.value = StateData.complete();
  }

  @override
  void dispose() {
    impressoraEC.dispose();
    super.dispose();
  }

  PrinterEntity? _getInitialValue(PrinterDto printer) {
    final result = printers.firstWhereOrNull((element) => element.name == printer.printer.name);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: StateNotifier(
            stateNotifier: state,
            onComplete: (context) => Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(padding: const EdgeInsets.only(bottom: 12), child: Icon(Icons.circle, color: widget.printerDto.enable ? Colors.green : Colors.red)),
                    PSize.spacer.sizedBoxW,
                    Expanded(
                      child: CwTextFormFild(
                        label: "Printer name",
                        initialValue: widget.printerDto.name,
                        onChanged: (value) {
                          widget.savePrinter(widget.printerDto.copyWith(printer: _printer.copyWith(), name: value));
                        },
                      ),
                    ),
                    PSize.spacer.sizedBoxW,
                    RadioMenuButton(
                      value: PaipPrinterType.usb,
                      groupValue: _printer.printerType,
                      onChanged: (value) {
                        widget.savePrinter(widget.printerDto.copyWith(printer: _printer.copyWith(printerType: PaipPrinterType.usb)));
                        load(PaipPrinterType.usb);
                      },
                      child: const Text("USB"),
                    ),
                    RadioMenuButton(
                      value: PaipPrinterType.network,
                      groupValue: _printer.printerType,
                      onChanged: (value) {
                        widget.savePrinter(widget.printerDto.copyWith(printer: _printer.copyWith(printerType: PaipPrinterType.network)));
                      },
                      child: const Text("WIFI"),
                    ),
                    if (isWindows == false)
                      RadioMenuButton(
                        value: PaipPrinterType.bluetooth,
                        groupValue: _printer.printerType,
                        onChanged: (value) {
                          widget.savePrinter(widget.printerDto.copyWith(printer: _printer.copyWith(printerType: PaipPrinterType.bluetooth)));
                          load(PaipPrinterType.bluetooth);
                        },
                        child: const Text("Bluetooth"),
                      ),
                  ],
                ),
                PSize.i.sizedBoxH,
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    PSize.i.sizedBoxW,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_printer.printerType == PaipPrinterType.usb)
                          Expanded(
                            child: PDropMenuForm<PrinterEntity?>(
                              hintText: context.i18n.selecioneUmaImpressora,
                              labelText: context.i18n.impressora,
                              isExpanded: true,
                              controller: impressoraEC,
                              initialSelection: _getInitialValue(widget.printerDto),
                              onSelected: (printer) {
                                widget.savePrinter(widget.printerDto.copyWith(printer: printer!, enable: true));
                              },
                              dropdownMenuEntries: printers.map((device) => DropdownMenuEntry(value: device, label: device.name, leadingIcon: const Icon(PaipIcons.printer))).toList(),
                            ),
                          ),
                        if (_printer.printerType == PaipPrinterType.network)
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CwTextFormFild(
                                    label: "IP:",
                                    initialValue: _printer.ip,
                                    onChanged: (value) {
                                      widget.savePrinter(widget.printerDto.copyWith(printer: _printer.copyWith(ip: value)));
                                    },
                                  ),
                                ),
                                PSize.spacer.sizedBoxW,
                                Expanded(
                                  child: CwTextFormFild(
                                    label: "PORT:",
                                    initialValue: _printer.port,
                                    onChanged: (value) {
                                      widget.savePrinter(widget.printerDto.copyWith(printer: _printer.copyWith(port: value)));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_printer.printerType == PaipPrinterType.bluetooth)
                          Expanded(
                            child: PDropMenuForm<PrinterEntity?>(
                              hintText: "Selecione uma impressora bluetooth",
                              labelText: "Impressora",
                              isExpanded: true,
                              controller: impressoraEC,
                              initialSelection: _printer,
                              onSelected: (printer) {
                                widget.savePrinter(widget.printerDto.copyWith(printer: printer, enable: true, qtyCopy: widget.printerDto.qtyCopy));
                              },
                              dropdownMenuEntries: printers.map((device) => DropdownMenuEntry(value: device, label: device.name, leadingIcon: const Icon(PaipIcons.printer))).toList(),
                            ),
                          ),
                        if (viewmodel.printers.length > 1)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4, left: 16),
                            child: PButton(
                              color: Colors.red,
                              icon: PaipIcons.trash,
                              label: context.i18n.deletar,
                              onPressed: () {
                                viewmodel.deletePrinter(widget.printerDto);
                              },
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4, left: 16),
                          child: CwOutlineButton(
                            label: l10n.configuracoes,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => PrinterConfigDialog(
                                  printerDto: widget.printerDto,
                                  viewmodel: viewmodel,
                                  onSave: (dto) async {
                                    try {
                                      Loader.show(context);
                                      await viewmodel.savePrinter(dto);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    } catch (e) {
                                      toast.showError(e.toString());
                                    } finally {
                                      Loader.hide();
                                    }
                                  },
                                ),
                              );
                            },
                            icon: PIcons.strokeRoundedConfiguration02,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
