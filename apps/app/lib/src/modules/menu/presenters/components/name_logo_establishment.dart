import 'package:flutter/material.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class NameLogoEstablishment extends StatelessWidget {
  final MenuViewmodel store;
  final double imageSize;
  const NameLogoEstablishment({
    super.key,
    required this.store,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PSize.ii.paddingHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Material(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: 100.0.borderRadiusAll,
                  child: Visibility(
                    visible: store.establishment.logo != null,
                    replacement: ColoredBox(color: context.color.black),
                    child: CachedNetworkImage(
                      cacheKey: store.establishment.cacheKeyLogo,
                      imageUrl: store.establishment.logoPath?.buildPublicUriBucket ?? PImageBucket.emptyCam,
                      fit: BoxFit.cover,
                      height: imageSize,
                      width: imageSize,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      store.changeTheme(!context.isDarkTheme);
                    },
                    icon: Icon(context.isDarkTheme ? PIcons.strokeRoundedMoon02 : PIcons.strokeRoundedSun02),
                    color: context.color.primaryText,
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icomoon.whatsapp_1),
                  //   color: context.color.primaryText,
                  // ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icomoon.share_08),
                  //   color: context.color.primaryText,
                  // )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
