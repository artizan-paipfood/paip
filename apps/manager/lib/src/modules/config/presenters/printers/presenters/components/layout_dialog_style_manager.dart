import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/layout_printer_store.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/ui_order_print.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer_usecase.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_structure_config_component.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_properties_component.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/layout_printer_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LayoutDialogStyleManager extends StatefulWidget {
  final LayoutPrinterDto layoutPrinterDto;
  const LayoutDialogStyleManager({required this.layoutPrinterDto, super.key});

  @override
  State<LayoutDialogStyleManager> createState() => _LayoutDialogStyleManagerState();
}

class _LayoutDialogStyleManagerState extends State<LayoutDialogStyleManager> {
  final viewmodel = LayoutPrinterViewmodel(layoutPrinterUsecase: Modular.get<LayoutPrinterUsecase>());
  final layoutPrinterUsecase = Modular.get<LayoutPrinterUsecase>();

  OrderModel get order => OrdersStore.instance.orders.isNotEmpty ? OrdersStore.instance.orders.last : OrderModel(id: uuid, establishmentId: uuid, cartProducts: [], customer: CustomerModel(addresses: []));
  @override
  void initState() {
    viewmodel.initialize(widget.layoutPrinterDto);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text('Layout de impressão'),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.95,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 350,
              child: LayoutStructureConfigComponent(
                viewmodel: viewmodel,
                order: order,
                onSave: () async {
                  try {
                    Loader.show(context);
                    await viewmodel.save(viewmodel.layoutPrinter);
                    final result = await layoutPrinterUsecase.getByEstablishmentId(establishmentProvider.value.id);
                    LayoutPrinterStore.instance.reload(layouts: result);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      toast.showSucess(context.i18n.salvoComSucesso);
                    }
                  } on Exception catch (e) {
                    toast.showError(e.toString());
                  } finally {
                    Loader.hide();
                  }
                },
              ),
            ),
            VerticalDivider(color: context.color.border),
            Expanded(child: LayoutPropertiesComponent(viewmodel: viewmodel)),
            VerticalDivider(color: context.color.border),
            SizedBox(
              width: 300,
              child: ListenableBuilder(
                listenable: viewmodel,
                builder: (context, _) {
                  return SingleChildScrollView(child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: .78), child: UiOrderPrint(layoutPrinterDto: viewmodel.layoutPrinter, order: order, tableNumber: null)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
