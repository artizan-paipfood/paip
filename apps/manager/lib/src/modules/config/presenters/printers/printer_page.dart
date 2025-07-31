import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/core/components/inner_container.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/printer_card.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({super.key});

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  late final viewmodel = context.read<PrinterViewmodel>();

  @override
  void initState() {
    _load = viewmodel.load();
    super.initState();
  }

  late Future<Status> _load;

  @override
  Widget build(BuildContext context) {
    return FutureState(
      future: _load,
      onComplete: (context, data) => ListenableBuilder(
        listenable: viewmodel,
        builder: (context, _) {
          return CwContainerShadow(
            child: Column(
              children: [
                CwHeaderCard(
                  titleLabel: context.i18n.impressoras,
                  actions: Row(
                    children: [
                      if (isWindows)
                        CwOutlineButton(
                          label: context.i18n.downloadDriverImpressora,
                          icon: PaipIcons.download,
                          onPressed: () async {
                            try {
                              Loader.show(context);
                              await viewmodel.downloadDriver();
                            } finally {
                              Loader.hide();
                            }
                          },
                        ),
                      PSize.spacer.sizedBoxW,
                      PButton(label: context.i18n.adicionar, onPressed: viewmodel.addPrinter, icon: PIcons.strokeRoundedAdd01),
                    ],
                  ),
                ),
                Expanded(
                  child: ListenableBuilder(
                    listenable: viewmodel,
                    builder: (context, _) {
                      return CwInnerContainer(
                        child: SingleChildScrollView(
                          child: Column(
                            children: viewmodel.printers.map((dto) {
                              return Padding(
                                padding: PSize.i.paddingBottom,
                                child: PrinterCard(
                                  printerDto: dto,
                                  onEdit: (printerDto) {
                                    viewmodel.onEditPrinter(printerDto);
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
