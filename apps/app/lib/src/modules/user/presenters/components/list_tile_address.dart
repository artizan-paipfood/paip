import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:paipfood_package/paipfood_package.dart';

class ListTileAddress extends StatelessWidget {
  final AddressEntity address;
  final bool isSelected;
  final void Function() onTap;
  final void Function() onDelete;

  const ListTileAddress({
    required this.address,
    required this.onTap,
    required this.onDelete,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: PSize.i.borderRadiusAll,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(color: context.color.primaryBG, border: Border.all(color: isSelected ? context.color.primaryColor : context.color.neutral300, width: isSelected ? 2.5 : 1), borderRadius: PSize.i.borderRadiusAll),
        child: Padding(
          padding: PSize.i.paddingLeft + PSize.ii.paddingRight + PSize.i.paddingVertical,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: isSelected ? context.color.primaryColor : context.color.onPrimaryBG,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
              PSize.ii.sizedBoxW,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.nickName,
                    style: context.textTheme.bodySmall,
                  ),
                  0.5.sizedBoxH,
                  Text(
                    address.mainText(LocaleNotifier.instance.locale),
                    style: context.textTheme.bodySmall,
                  ),
                  Text(
                    address.secondaryText(LocaleNotifier.instance.locale),
                    style: context.textTheme.bodySmall?.muted(context),
                  ),
                ],
              )),
              if (!isSelected) IconButton(onPressed: onDelete, icon: const Icon(PIcons.strokeRoundedDelete01))
            ],
          ),
        ),
      ),
    );
  }
}
