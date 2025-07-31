import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:app/src/core/helpers/assets.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardLocationEstablishment extends StatefulWidget {
  final EstablishmentModel establishment;
  const CardLocationEstablishment({
    super.key,
    required this.establishment,
  });

  @override
  State<CardLocationEstablishment> createState() => _CardLocationEstablishmentState();
}

class _CardLocationEstablishmentState extends State<CardLocationEstablishment> {
  final controller = MapController();
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: 0.5.borderRadiusAll,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: 80,
        child: FlutterMap(
          mapController: controller,
          options: MapOptions(
            enableScrollWheel: false,
            minZoom: 10,
            maxZoom: 18,
            zoom: 15,
            screenSize: const Size(double.infinity, 200),
            center: widget.establishment.latLng,
          ),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate: context.isDarkTheme ? Env.mapboxDark : Env.mapboxlight,
            ),
            CircleLayer(
              circles: [CircleMarker(point: widget.establishment.latLng, radius: 100, color: PColors.primaryColor_.withOpacity(0.3), useRadiusInMeter: true, borderColor: PColors.primaryColor_, borderStrokeWidth: 2)],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: widget.establishment.latLng,
                  builder: (context) => Image.asset(PImages.shop3d, height: 25, width: 25),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
