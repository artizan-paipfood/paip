import 'package:flutter/material.dart';

import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/i_payment_controller.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/payment_bill_controller.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/payment_order_controller.dart';
import 'package:manager/src/modules/pdv/domain/payment_pdv_dto.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/finish_order_data_component.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/finish_order_data_table_component.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/finish_order_payment_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EndDrawerFinishOrder extends StatefulWidget {
  final PaymentPdvDto dto;
  const EndDrawerFinishOrder({
    required this.dto,
    super.key,
  });

  @override
  State<EndDrawerFinishOrder> createState() => _EndDrawerFinishOrderState();
}

class _EndDrawerFinishOrderState extends State<EndDrawerFinishOrder> {
  late final IPaymentController controller;

  late final List<Widget> _children = [
    if (widget.dto.bill != null) Expanded(child: FinishOrderDataTableComponent(store: controller, dto: widget.dto)),
    if (widget.dto.bill == null) Expanded(child: FinishOrderDataComponent(store: controller)),
    Expanded(
        child: FinishOrderPaymentComponent(
      controller: controller,
      onPay: (isFinish) {},
    )),
  ];

  @override
  void initState() {
    if (widget.dto.bill != null) controller = context.read<PaymentBillController>();
    if (widget.dto.bill == null) controller = context.read<PaymentOrderController>();

    controller.initialize(widget.dto);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CwDialogEndDrawer(
        widthFactor: 1,
        child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return Row(
                children: [
                  _children[0],
                  _children[1],
                ],
              );
            }));
  }
}
