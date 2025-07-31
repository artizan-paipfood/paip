import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardOptionOrderTakeway extends StatelessWidget {
  final UserStore userStore;
  final AddressEntity? establishmentAddress;
  final void Function() onTap;
  final bool isSelected;

  const CardOptionOrderTakeway({required this.userStore, required this.onTap, required this.isSelected, this.establishmentAddress, super.key});

  @override
  Widget build(BuildContext context) {
    // bool isSelected = (store.order.orderType == OrderTypeEnum.takeWay && AuthNotifier.instance.auth.user != null);
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
                  child: Icon(PIcons.strokeRoundedShoppingBag03, color: isSelected ? context.color.neutral100 : context.color.primaryColor),
                ),
                PSize.i.sizedBoxW,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(context.i18n.retirada)]),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  establishmentAddress?.formattedAddress(LocaleNotifier.instance.locale) ?? context.i18n.cliqueParaAdicionarEnderecoEntrega,
                                  style: context.textTheme.bodySmall?.muted(context),
                                  maxLines: 2,
                                ),
                              ],
                            ),
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
