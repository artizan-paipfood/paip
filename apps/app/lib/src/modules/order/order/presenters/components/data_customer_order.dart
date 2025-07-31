import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DataCustomerOrder extends StatelessWidget {
  final OrderStatusStore store;
  const DataCustomerOrder({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return BaseCardMenu(
      width: double.infinity,
      children: [
        Padding(
          padding: PSize.i.paddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildLabelContent(context, label: context.i18n.para, content: store.order.orderType!.i18nText.i18n()), _buildLabelContent(context, label: context.i18n.data, content: store.order.createdAtFormatedDateHour, crossAxisAlignment: CrossAxisAlignment.end)],
              ),
              PSize.i.sizedBoxH,
              _buildLabelContent(context, label: context.i18n.nome, content: store.customer.name),
              PSize.i.sizedBoxH,
              _buildLabelContent(context, label: context.i18n.telefone, content: store.customer.phone),
              if (store.order.orderType == OrderTypeEnum.delivery) Column(children: [PSize.i.sizedBoxH, _buildLabelContent(context, label: context.i18n.enderecoDeEntrega, content: store.customer.address?.formattedAddress(LocaleNotifier.instance.locale) ?? "")]),
              PSize.i.sizedBoxH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabelContent(context, label: context.i18n.total, content: store.order.amount.toStringCurrency),
                  _buildLabelContent(context, label: context.i18n.codigo, isFocused: true, content: store.customer.phone.substring(store.customer.phone.length - 4), crossAxisAlignment: CrossAxisAlignment.end),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabelContent(BuildContext context, {required String label, required String content, CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start, bool isFocused = false}) {
    return Column(crossAxisAlignment: crossAxisAlignment, children: [Text(label, style: context.textTheme.bodyMedium?.muted(context)), Text(content, style: isFocused ? context.textTheme.titleMedium?.copyWith(color: context.color.primaryColor) : context.textTheme.titleMedium)]);
  }
}
