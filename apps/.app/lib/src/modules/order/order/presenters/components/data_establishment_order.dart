import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DataEstablishmentOrder extends StatelessWidget {
  final EstablishmentModel establishment;
  final OrderTypeEnum orderType;
  const DataEstablishmentOrder({super.key, required this.establishment, required this.orderType});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Material(
                          borderRadius: 100.0.borderRadiusAll,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CachedNetworkImage(cacheKey: establishment.cacheKeyLogo, imageUrl: establishment.logo?.buildPublicUriBucket ?? PImageBucket.emptyCam, fit: BoxFit.cover),
                        ),
                      ),
                      PSize.i.sizedBoxW,
                      Text(establishment.fantasyName, style: context.textTheme.titleMedium),
                    ],
                  ),
                  IconButton.filled(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CwDialog(
                          title: Text("${context.i18n.desejaIrAte(establishment.fantasyName)}?"),
                          actions: [
                            PButton(
                              label: context.i18n.tracarRotaNoMapa,
                              onPressed: () {
                                final uri = Uri.parse(establishment.address!.buildGoogleMapsDestination());
                                launchUrl(uri);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(PIcons.strokeRoundedRoute02, color: PColors.primaryColor_),
                    style: IconButton.styleFrom(backgroundColor: context.color.neutral100),
                  ),
                ],
              ),
              PSize.i.sizedBoxH,
              if (orderType == OrderTypeEnum.takeWay)
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(context.i18n.enderecoParaFazerRetirada, style: context.textTheme.titleSmall), Text(establishment.address?.formattedAddress(LocaleNotifier.instance.locale) ?? "", style: context.textTheme.bodyMedium?.muted(context))]),
            ],
          ),
        ),
      ],
    );
  }
}
