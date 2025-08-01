import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardOptionOrderDelivery extends StatelessWidget {
  final AddressEntity? address;
  final DeliveryTaxResponse? deliveryTax;
  final bool isSelected;
  final void Function() onEdit;
  final void Function() onTap;
  final DeliveryAreaPerMileEntity? deliveryAreaPerMile;
  const CardOptionOrderDelivery({required this.onTap, required this.onEdit, required this.isSelected, super.key, this.address, this.deliveryTax, this.deliveryAreaPerMile});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: PSize.i.borderRadiusAll,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: context.color.primaryColor,
        onTap: onTap,
        child: Ink(
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll, color: context.color.primaryBG, border: Border.all(color: isSelected ? context.color.primaryColor : context.color.neutral300, width: isSelected ? 2 : 1)),
          child: Padding(
            padding: PSize.i.paddingAll,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(color: isSelected ? context.color.primaryColor : context.color.surface, borderRadius: PSize.i.borderRadiusAll, border: Border.all(color: context.color.primaryColor)),
                  child: Icon(PIcons.strokeRoundedScooter02, color: isSelected ? context.color.neutral100 : context.color.primaryColor),
                ),
                PSize.i.sizedBoxW,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.i18n.entrega),
                          if (address != null)
                            Builder(builder: (context) {
                              final price = deliveryTax?.price ?? 0;

                              // Se o preço é maior que 0, mostra o valor
                              if (price > 0) {
                                return Text(price.toStringCurrency);
                              }

                              // Se o preço é exatamente 0, mostra "Gratuita"
                              if (price == 0 && deliveryTax != null) {
                                return Text(context.i18n.gratuita);
                              }

                              // Se não há taxa carregada, mostra loading
                              return Text(" -- ");
                            })
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  address?.formattedAddress(LocaleNotifier.instance.locale) ?? context.i18n.cliqueParaAdicionarEnderecoEntrega,
                                  style: context.textTheme.bodySmall?.muted(context),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          if (address != null)
                            InkWell(
                              borderRadius: PSize.i.borderRadiusAll,
                              onTap: onEdit,
                              child: Padding(padding: const EdgeInsets.only(top: 7, bottom: 7, right: 8, left: 8), child: Text(context.i18n.editar.toUpperCase(), style: context.textTheme.bodyMedium?.copyWith(color: context.color.primaryColor, fontWeight: FontWeight.bold))),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
