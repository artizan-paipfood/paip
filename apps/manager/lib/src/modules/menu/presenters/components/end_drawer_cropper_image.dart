import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EndDrawerCropperImage extends StatefulWidget {
  final Function(CropperImageController controller) initStateFunc;
  final Function() delete;
  final Function(Uint8List? image) saveImage;
  final String label;

  const EndDrawerCropperImage({required this.initStateFunc, required this.delete, required this.saveImage, required this.label, super.key});

  @override
  State<EndDrawerCropperImage> createState() => _EndDrawerCropperImageState();
}

class _EndDrawerCropperImageState extends State<EndDrawerCropperImage> {
  final controller = CropperImageController();
  @override
  void initState() {
    widget.initStateFunc(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int rotate = 0;

  @override
  Widget build(BuildContext context) {
    return CwDialogEndDrawer(
      child: Padding(
        padding: PSize.ii.paddingAll,
        child: Column(
          children: [
            Align(alignment: Alignment.centerLeft, child: Text(widget.label, style: context.textTheme.titleLarge)),
            Align(alignment: Alignment.centerLeft, child: Text(context.i18n.descSelecionarImage)),
            PSize.iii.sizedBoxH,
            ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                return Material(
                  borderRadius: PSize.i.borderRadiusAll,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(border: Border.all(color: context.color.secondaryText), borderRadius: PSize.i.borderRadiusAll),
                    width: 300,
                    height: 300,
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: controller.imagePicker != null
                          ? Cropper(cropperKey: controller.cropperKey, backgroundColor: context.color.primaryBG, rotationTurns: rotate, overlayType: OverlayType.rectangle, image: Image.memory(controller.imagePicker!))
                          : Center(child: CwEmptyState(size: 100, icon: PaipIcons.camera, bgColor: false, label: context.i18n.selecioneUmaImagem)),
                    ),
                  ),
                );
              },
            ),
            PSize.ii.sizedBoxH,
            const Divider(),
            SizedBox(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CwTextButton(
                    label: context.i18n.deletarImagem,
                    icon: PaipIcons.trash,
                    onPressed: () async {
                      final message = context.i18n.imagemExcluidaSucesso;
                      final nav = Navigator.of(context);
                      await showDialog(context: context, builder: (context) => DialogDelete(onDelete: () async => await widget.delete()));
                      toast.showSucess(message);
                      nav.pop();
                    },
                  ),
                  CwTextButton(
                    icon: PaipIcons.uploadImage,
                    label: context.i18n.uploadImagem,
                    onPressedFuture: () async {
                      rotate = 0;
                      await controller.uploadImage(context: context);
                    },
                  ),
                ],
              ),
            ),
            PSize.iii.sizedBoxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () => setState(() => rotate--), icon: Icon(PaipIcons.roateLeft), color: context.color.secondaryColor),
                PSize.i.sizedBoxW,
                IconButton(onPressed: () => setState(() => rotate++), icon: const Icon(PaipIcons.roateRight), color: context.color.secondaryColor),
              ],
            ),
            PSize.iii.sizedBoxH,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(PaipIcons.help, size: 20, color: context.color.tertiaryColor), PSize.i.sizedBoxW, Text(context.i18n.descZoomImagem).center]),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CwTextButton(
                  label: context.i18n.cancelar,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                PSize.i.sizedBoxW,
                PButton(
                  label: context.i18n.salvar,
                  onPressedFuture: () async {
                    final i18n = context.i18n;
                    final navigator = Navigator.of(context);
                    if (controller.imagePicker != null) {
                      await controller.cropImage();
                      widget.saveImage(controller.imageResult);
                      navigator.pop();
                      toast.showSucess(i18n.imagemSalvaComSucesso);
                    } else {
                      toast.showError(i18n.vocePrecisaSelecionarUmaImagem);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
