import 'package:flutter/material.dart';
import 'package:manager/src/modules/pdv/presenter/pdv_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogPdv extends StatelessWidget {
  const DialogPdv({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height - 30,
              width: MediaQuery.sizeOf(context).width - 20,
              child: Material(
                borderRadius: PSize.i.borderRadiusAll,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: const PdvPage(
                  isModal: true,
                ),
              ),
            ),
          ),
          Positioned(
            right: -10,
            top: -10,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                backgroundColor: context.color.primaryBG,
                radius: 15,
                child: const Icon(PIcons.strokeRoundedCancel01),
              ),
            ),
          )
        ],
      ),
    );
  }
}
