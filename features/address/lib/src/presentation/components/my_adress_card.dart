import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class MyAdressCard extends StatefulWidget {
  final bool isSelected;
  const MyAdressCard({super.key, this.isSelected = false});

  @override
  State<MyAdressCard> createState() => _MyAdressCardState();
}

class _MyAdressCardState extends State<MyAdressCard> {
  @override
  Widget build(BuildContext context) {
    return ArtCard(
      padding: EdgeInsets.zero,
      border: widget.isSelected ? Border.all(color: context.artColorScheme.ring, width: 1.2) : null,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16) + EdgeInsets.only(left: 16),
            child: Row(
              children: [
                PaipIcon(PaipIcons.homeBold, color: context.artColorScheme.mutedForeground),
                SizedBox(width: 22),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Casa', style: context.artTextTheme.h2.copyWith(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('R. Maria José Tramonte Borguetti, 540'),
                      Text('Res. Torre, Poços de Caldas - MG', style: context.artTextTheme.muted),
                      Text('Apartamento 11', style: context.artTextTheme.muted.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 40), // Espaço para o botão
              ],
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: ArtIconButton.ghost(
                icon: Icon(
              Icons.more_vert,
              color: context.artColorScheme.ring,
            )),
          ),
        ],
      ),
    );
  }
}
