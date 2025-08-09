import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_customer/phone_fild_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/pdv_drawer_search_customer.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/resume_order/card_address_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardSingleCustomerWidget extends StatefulWidget {
  final OrderPdvStore store;
  final bool onDrawer;
  final GlobalKey<FormState> formKey;
  const CardSingleCustomerWidget({required this.store, required this.onDrawer, required this.formKey, super.key});

  @override
  State<CardSingleCustomerWidget> createState() => _CardSingleCustomerWidgetState();
}

class _CardSingleCustomerWidgetState extends State<CardSingleCustomerWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        key: ValueKey(widget.store.order.id),
        children: [
          Flex(
            direction: widget.onDrawer ? Axis.horizontal : Axis.vertical,
            children: [
              CwTextFormFild(
                expanded: widget.onDrawer,
                suffixIcon: IconButton(
                  tooltip: context.i18n.selecionarCliente,
                  onPressed: () {
                    showDialog(context: context, builder: (context) => const PdvDrawerSearchCustomer());
                  },
                  style: IconButton.styleFrom(backgroundColor: context.color.muted.withOpacity(0.05)),
                  icon: Icon(PIcons.strokeRoundedUserAdd02, color: context.color.primaryColor),
                ),
                initialValue: widget.store.customer.name,
                onChanged: (value) => widget.store.customer.name = value,
                maskUtils: MaskUtils.cRequired(),
              ),
              if (widget.onDrawer) PSize.ii.sizedBoxW,
              PhoneFildWidget(
                expanded: widget.onDrawer,
                initialPhone: widget.store.customer.phone,
                initialCountryCode: widget.store.customer.phoneCountryCode,
                onChanged: (countryCode, phone) {
                  widget.store.onEdit(widget.store.order.copyWith(customer: widget.store.customer.copyWith(phoneCountryCode: countryCode, phone: phone)));
                },
              ),
            ],
          ),
          if (widget.store.customer.address != null && widget.store.order.orderType == OrderTypeEnum.delivery) //
            CardAddressOrder(store: widget.store),
        ],
      ),
    );
  }
}
