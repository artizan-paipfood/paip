import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class SelectedAdressDropIndicator extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback onTap;
  const SelectedAdressDropIndicator({required this.address, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: PSize.i.borderRadiusAll,
      overlayColor: MaterialStateProperty.all(context.artColorScheme.primary.withOpacity(0.1)),
      onTap: onTap,
      child: Padding(
        padding: PSize.i.paddingVertical + PSize.ii.paddingHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: PSize.ii.value,
          children: [
            Flexible(
              child: Text(
                address.mainText,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: context.artTextTheme.small.copyWith(
                    // fontWeight: FontWeight.,
                    ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22,
              color: context.artColorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
