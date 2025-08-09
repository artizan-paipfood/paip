import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/card_location_establishment.dart';
import 'package:paipfood_package/paipfood_package.dart';

class InfoEstablishment extends StatelessWidget {
  final MenuViewmodel store;
  const InfoEstablishment({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PSize.ii.paddingHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: store.establishment.fantasyName,
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              children: [
                const WidgetSpan(child: Padding(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 7), child: Icon(Icons.circle, size: 5))),
                TextSpan(text: context.i18n.tempoAbreviado(store.establishment.getTimesDelivery[0], store.establishment.getTimesDelivery[1]), style: context.textTheme.bodySmall?.muted(context)),
              ],
            ),
          ),
          _builRichText(context, label: "", content: context.i18n.pedidoMinimoAbreviado(store.establishment.minimunOrder.toStringCurrency)),
          if (!store.establishment.isOpen) Text(context.i18n.fechado, style: context.textTheme.titleSmall?.copyWith(color: context.color.errorColor)),
          if (store.establishment.isOpen) _builRichText(context, label: context.i18n.aberto, content: context.i18n.ate(store.openingHour?.closingEnumValue.label ?? " -- ")),
          PSize.i.sizedBoxH,
          Text(context.i18n.localizacaoDoEstabelecimento, style: context.textTheme.titleMedium?.copyWith()),
          Text(store.establishment.address!.formattedAddress(LocaleNotifier.instance.locale), maxLines: 2, style: context.textTheme.bodyMedium?.muted(context)),
          PSize.i.sizedBoxH,
          CardLocationEstablishment(establishment: store.establishment),
        ],
      ),
    );
  }

  Widget _builRichText(BuildContext context, {required String label, required String content}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: context.textTheme.bodySmall?.copyWith().muted(context),
        children: [const WidgetSpan(child: Padding(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5), child: Icon(Icons.circle, size: 5))), TextSpan(text: content, style: context.textTheme.bodySmall?.muted(context))],
      ),
    );
  }
}
