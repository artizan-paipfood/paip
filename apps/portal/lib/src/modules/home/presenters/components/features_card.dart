import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class FeaturesCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeaturesCard({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ArtCard(
      width: 300,
      height: 190,
      child: Column(
        children: [
          Icon(
            icon,
            color: context.artColorScheme.primary,
            size: 30,
          ),
          PSize.i.sizedBoxH,
          Text(
            title,
            style: context.artTextTheme.large,
            textAlign: TextAlign.center,
          ),
          PSize.i.sizedBoxH,
          Text(
            description,
            style: context.artTextTheme.muted,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
