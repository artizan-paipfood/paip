import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/divider.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/i_payment_controller.dart';
import 'package:manager/src/modules/pdv/domain/payment_pdv_dto.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/card_order_resume_table_widget.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class FinishOrderDataTableComponent extends StatefulWidget {
  final IPaymentController store;
  final PaymentPdvDto dto;
  const FinishOrderDataTableComponent({required this.store, required this.dto, super.key});

  @override
  State<FinishOrderDataTableComponent> createState() => _FinishOrderDataTableComponentState();
}

class _FinishOrderDataTableComponentState extends State<FinishOrderDataTableComponent> {
  late final tableStore = context.read<TableStore>();
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.isDarkTheme ? context.color.neutral300 : context.color.surface,
      child: Padding(
        padding: PSize.ii.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [const Icon(PIcons.strokeRoundedTable02, size: 35), PSize.i.sizedBoxW, Expanded(child: TableWidget(table: tableStore.selectedTable!))]),
            const CwDivider(),
            Text(context.i18n.pedidos, style: context.textTheme.titleLarge),
            PSize.ii.sizedBoxH,
            Expanded(
              child: ListView.builder(
                itemCount: widget.store.orders.length,
                itemBuilder: (context, index) {
                  final order = widget.store.orders[index];
                  return Padding(padding: const EdgeInsets.only(bottom: 8), child: CardOrderResumeTableWidget(initiallyExpanded: true, order: order));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
