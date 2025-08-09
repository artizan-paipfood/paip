import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'package:paipfood_package/paipfood_package.dart';

class EstablishmentAvaliationCard extends StatelessWidget {
  final String coment;
  final String clientName;
  final String establishmentName;

  const EstablishmentAvaliationCard({
    super.key,
    required this.coment,
    required this.clientName,
    required this.establishmentName,
  });

  @override
  Widget build(BuildContext context) {
    return ArtCard(
      width: 300,
      height: 235,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
            ],
          ),
          PSize.i.sizedBoxH,
          Text(
            coment,
            style: context.artTextTheme.muted,
            textAlign: TextAlign.start,
          ),
          PSize.i.sizedBoxH,
          Text(
            clientName,
            style: context.artTextTheme.large,
            textAlign: TextAlign.start,
          ),
          Text(
            establishmentName,
            style: context.artTextTheme.muted,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
