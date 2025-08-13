import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class CardEstablishmentExplore extends StatelessWidget {
  final EstablishmentExplore establishment;

  const CardEstablishmentExplore({required this.establishment, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (establishment.logoUrl != null)
          Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: context.artColorScheme.border),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(100),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  establishment.isOpen ? Colors.transparent : Colors.grey,
                  BlendMode.saturation,
                ),
                child: CachedNetworkImage(
                  imageUrl: establishment.logoUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 1500),
                  fadeOutDuration: const Duration(milliseconds: 1500),
                  errorWidget: (context, url, error) => CircleAvatar(),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              ),
            ),
          ),
        PSize.iii.sizedBoxW,
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(establishment.fantasyName, style: context.artTextTheme.h2.copyWith(fontSize: 14))),
                    Visibility(
                      visible: establishment.isOpen,
                      replacement: ArtBadge.destructive(
                        child: Text('Fechado'),
                      ),
                      child: Icon(Icons.circle, size: 10, color: Colors.green),
                    )
                  ],
                ),
                SizedBox(height: 2),
                Text(establishment.address.secondaryText, style: context.artTextTheme.muted.copyWith(fontSize: 12)),
                Text('${(establishment.distanceKm * 1.5).toStringAsFixed(2)} km', style: context.artTextTheme.muted.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
