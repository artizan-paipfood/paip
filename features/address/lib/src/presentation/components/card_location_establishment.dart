import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui/ui.dart';

class CardLocation extends StatelessWidget {
  final AddressEntity address;
  CardLocation({
    required this.address,
    super.key,
  }) {
    if (address.lat == null || address.long == null) {
      throw Exception("Address must have a latitude and longitude");
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        borderRadius: PSize.i.borderRadiusAll,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          height: 80,
          child: FlutterMap(
              options: MapOptions(
                // enableScrollWheel: false,
                minZoom: 10,
                maxZoom: 18,
                initialCenter: LatLng(address.lat!, address.long!),
                // zoom: 15,
                // screenSize: const Size(double.infinity, 200),
                // center: LatLng(address.latitude, address.longitude),
              ),
              children: [
                TileLayer(
                  urlTemplate: false ? AppConstants.mapDarkUrl : AppConstants.mapLightUrl,
                ),
                // CircleLayer(
                //   circles: [CircleMarker(point: widget.establishment.latLng, radius: 100, color: PColors.primaryColor_.withOpacity(0.3), useRadiusInMeter: true, borderColor: PColors.primaryColor_, borderStrokeWidth: 2)],
                // ),
                // MarkerLayer(
                //   markers: [
                //     Marker(
                //       point: widget.establishment.latLng,
                //       builder: (context) => Image.asset(PImages.shop3d, height: 25, width: 25), child: null,
                //     )
                //   ],
                // ),
              ]),
        ),
      ),
    );
  }
}
