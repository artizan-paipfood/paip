import 'package:flutter/material.dart';

import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/layout_printer_store.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer_usecase.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_card.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_dialog_delete.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_dialog_style_manager.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LayoutDialogManager extends StatefulWidget {
  const LayoutDialogManager({
    super.key,
  });

  @override
  State<LayoutDialogManager> createState() => _LayoutDialogManagerState();
}

LayoutPrinterDto _createLayout() {
  final dto = LayoutPrinterStore.instance.getByName('default');
  return dto.copyWith(layoutPrinter: dto.layoutPrinter.copyWith(id: uuid, establishmentId: establishmentProvider.value.id, name: dto.layoutPrinter.name + (LayoutPrinterStore.instance.layoutPrinters.length - 1).toString()));
}

class _LayoutDialogManagerState extends State<LayoutDialogManager> {
  late final layoutPrinterUsecase = Modular.get<LayoutPrinterUsecase>();
  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Row(
        children: [
          Text('Gerenciar Layouts'),
          PSize.v.sizedBoxW,
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.95,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: PSize.spacer.value,
                runSpacing: PSize.spacer.value,
                children: LayoutPrinterStore.instance.layoutPrinters
                    .map(
                      (dto) => LayoutCard(
                        layoutPrinterDto: dto,
                        onDelete: () {
                          showDialog(
                              context: context,
                              builder: (context) => LayoutDialogDelete(
                                    onDelete: () async {
                                      try {
                                        Loader.show(context);
                                        await layoutPrinterUsecase.delete(id: dto.layoutPrinter.id);
                                        LayoutPrinterStore.instance.removeLayout(name: dto.layoutPrinter.name);
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                        setState(() {});
                                      } catch (e) {
                                        toast.showError(e.toString());
                                      } finally {
                                        Loader.hide();
                                      }
                                    },
                                  ));
                        },
                        onEdit: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => LayoutDialogStyleManager(layoutPrinterDto: dto),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Center(
                child: PButton(
                  label: 'Adicionar',
                  icon: PIcons.strokeRoundedAdd01,
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => LayoutDialogStyleManager(layoutPrinterDto: _createLayout()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
