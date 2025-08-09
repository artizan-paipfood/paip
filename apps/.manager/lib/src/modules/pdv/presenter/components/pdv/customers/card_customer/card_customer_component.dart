import 'package:flutter/material.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';

import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_customer/card_customer_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_customer/card_single_customer_widget.dart';

class CardCustomerComponent extends StatefulWidget {
  final bool onDrawer;
  final OrderPdvStore store;
  final GlobalKey<FormState> formKey;
  const CardCustomerComponent({
    required this.onDrawer,
    required this.store,
    required this.formKey,
    super.key,
  });

  @override
  State<CardCustomerComponent> createState() => _CardCustomerComponentState();
}

class _CardCustomerComponentState extends State<CardCustomerComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: widget.store.customer.isSingleCustomer,
        replacement: CardCustomerWidget(store: widget.store),
        child: CardSingleCustomerWidget(store: widget.store, onDrawer: widget.onDrawer, formKey: widget.formKey),
      ),
    );
  }
}
