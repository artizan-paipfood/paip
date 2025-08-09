import 'package:flutter/material.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/config/aplication/stores/aparence_store.dart';
import 'package:manager/src/modules/config/presenters/appearance/widgets/end_drawer_cropper_image_establishment.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwBanner extends StatefulWidget {
  final AparenceStore store;
  const CwBanner({required this.store, super.key});

  @override
  State<CwBanner> createState() => _CwBannerState();
}

class _CwBannerState extends State<CwBanner> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Material(
              child: InkWell(
                  onHover: (value) => setState(() => onHover = value),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => EndDrawerCropperImageEstablishment(
                              label: "Banner",
                              aspectRatio: 3 / 1,
                              delete: () async {
                                await widget.store.deleteImage(false);
                              },
                              initStateFunc: (controller) {
                                if (widget.store.establishment.bannerBytes != null) {
                                  controller.imagePicker = widget.store.establishment.bannerBytes;
                                }
                              },
                              saveImage: (image) async {
                                if (image == null) return;
                                await widget.store.saveImage(bytes: image, isLogo: false);
                              },
                            ));
                  },
                  child: AspectRatio(
                    aspectRatio: 3 / 1,
                    child: Visibility(
                      visible: widget.store.establishment.banner != null,
                      replacement: Center(
                        child: CwEmptyState(
                          size: 50,
                          icon: PIcons.strokeRoundedCamera01,
                        ),
                      ),
                      child: CachedNetworkImage(
                        cacheKey: establishmentProvider.value.cacheKeybanner,
                        imageUrl: widget.store.establishment.banner?.buildPublicUriBucket ?? '',
                        fit: BoxFit.cover,
                        color: widget.store.establishment.banner?.buildPublicUriBucket != null ? null : PColors.primaryColor_,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  )),
            ),
          ),
          Visibility(
            visible: onHover,
            child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: PColors.primaryColor_,
                  child: Icon(PaipIcons.add, color: Colors.white, size: 20),
                )),
          )
        ],
      ),
    );
  }
}
