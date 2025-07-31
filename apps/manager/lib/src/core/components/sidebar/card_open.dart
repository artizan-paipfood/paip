import 'package:flutter/material.dart';
import 'package:manager/src/core/services/establishment_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardOpen extends StatelessWidget {
  final EstablishmentModel establishment;
  final EstablishmentService establishmentService;
  const CardOpen({required this.establishment, required this.establishmentService, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: PSize.i.borderRadiusAll,
      child: InkWell(
          borderRadius: PSize.i.borderRadiusAll,
          splashColor: Colors.greenAccent,
          onTap: () async {
            await establishmentService.openClose();
          },
          child: Ink(
            height: 53,
            width: 53,
            decoration: BoxDecoration(
              borderRadius: PSize.i.borderRadiusAll,
              color: context.color.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Material(
                borderRadius: PSize.i.borderRadiusAll,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Visibility(
                  visible: establishment.logo != null,
                  replacement: Icon(
                    PIcons.strokeRoundedRestaurant03,
                    color: context.color.black,
                  ),
                  child: CachedNetworkImage(
                    cacheKey: establishment.cacheKeyLogo,
                    imageUrl: establishment.logo?.buildPublicUriBucket ?? PImageBucket.emptyLogoEstablishment,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
