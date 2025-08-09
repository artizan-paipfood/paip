import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardQrcodeDataLocal extends StatelessWidget {
  final OrderStatusStore store;

  const CardQrcodeDataLocal({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PSize.ii.paddingHorizontal,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll, border: Border.all(color: context.color.primaryColor)),
        child: Column(
          children: [
            Text(store.establishment.paymentMethod?.pixMetadata?.receipientName ?? "-", style: context.textTheme.titleMedium?.muted(context)),
            Text(store.establishment.paymentMethod?.pixMetadata?.type.label ?? "-", style: context.textTheme.titleMedium?.muted(context)),
            PSize.i.sizedBoxH,
            Text(store.establishment.paymentMethod?.pixMetadata?.key ?? "_", style: context.textTheme.titleMedium),
            PSize.i.sizedBoxH,
            Row(
              children: [
                Expanded(
                  child: PButton(
                    label: context.i18n.copiarChave,
                    onPressed: () {
                      if (store.establishment.paymentMethod?.pixMetadata?.key == null) {
                        banner.showInfo(context.i18n.chavePixNaoCadastradaEntreContatoEstabelecimento);
                        return;
                      }
                      Clipboard.setData(ClipboardData(text: store.establishment.paymentMethod!.pixMetadata!.key));
                      banner.showSucess(context.i18n.chaveCopiaComSucesso);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
