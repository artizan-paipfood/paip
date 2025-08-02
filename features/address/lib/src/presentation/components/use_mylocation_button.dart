import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class UseMylocationButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final AddressEntity address;

  const UseMylocationButton({required this.address, this.onTap, super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(context.artColorScheme.primary.withValues(alpha: 0.05)),
      onTap: onTap,
      child: Ink(
        color: context.artColorScheme.background,
        child: Padding(
          padding: padding ?? PSize.ii.paddingAll,
          child: Row(
            children: [
              PaipIcon(
                PaipIcons.gpsDuotone,
                color: context.artColorScheme.primary,
                size: 28,
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .scaleXY(begin: 1.0, end: 1.1)
                  .scaleXY(delay: 700.milliseconds, begin: 1.15, end: 1.0),
              SizedBox(width: 22),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Usar localização atual', style: context.artTextTheme.h2.copyWith(fontSize: 16)),
                    SizedBox(height: 4),
                    Text(address.mainText(DbLocale.br)),
                    Text(address.secondaryText(DbLocale.br), style: context.artTextTheme.muted),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
