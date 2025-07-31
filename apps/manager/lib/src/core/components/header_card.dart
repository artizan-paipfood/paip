import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwHeaderCard extends StatelessWidget {
  final String titleLabel;
  final Widget? title;
  final String description;
  final Widget? actions;
  final EdgeInsets? contentPadding;

  const CwHeaderCard({
    super.key,
    this.title,
    this.titleLabel = '',
    this.description = '',
    this.actions,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding ?? PSize.i.paddingBottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: title ??
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleLabel, style: context.textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(description, style: context.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
          ),
          actions ?? const SizedBox.shrink()
        ],
      ),
    );
  }
}
