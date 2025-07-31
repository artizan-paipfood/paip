import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/divider.dart';
import 'package:manager/src/modules/config/aplication/stores/aparence_store.dart';
import 'package:manager/src/modules/config/presenters/appearance/widgets/cw_banner.dart';
import 'package:manager/src/modules/config/presenters/appearance/widgets/end_drawer_cropper_image_establishment.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ImagesApp extends StatelessWidget {
  final AparenceStore store;
  const ImagesApp({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    final double w = context.w;
    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.i18n.imagens, style: context.textTheme.titleLarge), Text(context.i18n.descImagens, style: context.textTheme.bodySmall)]),
          const CwDivider(),
          Container(
            width: w * 0.6,
            decoration: BoxDecoration(border: Border.all(color: context.color.primaryBG, width: 2)),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CwBanner(store: store),
                    ColoredBox(
                      color: context.color.primaryBG,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(color: context.color.onPrimaryBG, height: 20, width: w * 0.2),
                            const SizedBox(height: 15),
                            Container(color: context.color.onPrimaryBG, height: 20, width: w * 0.25),
                            const SizedBox(height: 15),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                Container(color: context.color.onPrimaryBG, height: 20, width: w * 0.09),
                                Container(color: context.color.onPrimaryBG, height: 20, width: w * 0.09),
                                Container(color: context.color.onPrimaryBG, height: 20, width: w * 0.09),
                                Container(color: context.color.onPrimaryBG, height: 20, width: w * 0.09),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140, right: 50),
                    child: CwImageWidget(
                      cacheKey: store.establishment.cacheKeyLogo,
                      imageBytes: store.establishment.logoBytes,
                      pathImage: store.establishment.logo != null ? store.establishment.buildLogoPath : null,
                      size: w * 0.16,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => EndDrawerCropperImageEstablishment(
                            label: "Logo",
                            delete: () async {
                              await store.deleteImage(true);
                            },
                            initStateFunc: (controller) {
                              if (store.establishment.logoBytes != null) {
                                controller.imagePicker = store.establishment.logoBytes;
                              }
                            },
                            saveImage: (image) async {
                              if (image == null) return;
                              await store.saveImage(bytes: image, isLogo: true);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
