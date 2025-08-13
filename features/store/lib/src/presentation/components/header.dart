import 'package:artizan_ui/artizan_ui.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Header extends StatelessWidget {
  final EstablishmentEntity establishment;
  const Header({required this.establishment, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: AspectRatio(
            aspectRatio: 3 / 1,
            child: CachedNetworkImage(
              imageUrl: establishment.bannerPath!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: PSize.spacer.value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 100,
                  maxHeight: 100,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    border: Border.all(color: context.artColorScheme.border, width: 2),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(1000),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      imageUrl: establishment.logoPath!,
                    ),
                  ),
                ),
              ),
              PSize.iii.sizedBoxW,
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(establishment.fantasyName!, style: context.artTextTheme.table),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
