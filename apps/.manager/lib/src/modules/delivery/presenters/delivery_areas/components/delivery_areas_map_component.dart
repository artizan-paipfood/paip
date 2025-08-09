import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/components/cw_point_marker_polygon.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasMapComponent extends StatefulWidget {
  final DeliveryAreasViewmodel viewmodel;
  const DeliveryAreasMapComponent({required this.viewmodel, super.key});

  @override
  State<DeliveryAreasMapComponent> createState() => _DeliveryAreasMapComponentState();
}

class _DeliveryAreasMapComponentState extends State<DeliveryAreasMapComponent> {
  final mapController = MapController();
  LatLng get latLong => LatLng(establishmentProvider.value.address!.lat!, establishmentProvider.value.address!.long!);
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: latLong,
        onTap: (tapPosition, point) {
          if (widget.viewmodel.deliveryAreaPolygonViewmodel.selectedArea == null) {
            toast.showInfo(context.i18n.infoselecioneAreaEntregaAntesAddPonto);
            return;
          }

          widget.viewmodel.deliveryAreaPolygonViewmodel.onTapMap(point);
        },
      ),
      nonRotatedChildren: [
        TileLayer(urlTemplate: context.isDarkTheme ? Env.googleMapsDark : Env.googleMapsLight),
        if (widget.viewmodel.deliveryMethod == DeliveryMethod.miles)
          CircleLayer(circles: [
            ...widget.viewmodel.deliveryAreaPerMileViewmodel.areas.map(
              (e) => CircleMarker(
                point: latLong,
                radius: e.radius * 1000,
                useRadiusInMeter: true,
                borderColor: Colors.red,
                color: Colors.red.withOpacity(0.05),
                borderStrokeWidth: 1,
              ),
            ),
          ]),
        if (widget.viewmodel.deliveryMethod == DeliveryMethod.polygon)
          PolygonLayer(
            polygons: widget.viewmodel.deliveryAreaPolygonViewmodel.deliveryAreasSortByLabel
                .where((area) => area.latLongs.isNotEmpty && area.isDeleted == false)
                .map(
                  (area) => Polygon(
                    borderColor: area.color,
                    borderStrokeWidth: 3,
                    label: '${area.label} - ${area.price}',
                    labelStyle: TextStyle(color: context.color.primaryText, fontWeight: FontWeight.bold, shadows: [Shadow(color: context.color.primaryBG, offset: const Offset(0.5, 0.5))]),
                    isFilled: true,
                    color: area.color.withOpacity(0.5),
                    points: area.latLongs.where((l) => l.isDeleted == false).map((e) => e.latLng).toList(),
                  ),
                )
                .toList(),
          ),
        MarkerLayer(
          markers: [
            if (widget.viewmodel.deliveryMethod == DeliveryMethod.polygon)
              ...(widget.viewmodel.deliveryAreaPolygonViewmodel.selectedArea != null && widget.viewmodel.deliveryAreaPolygonViewmodel.selectedArea!.isDeleted == false && widget.viewmodel.deliveryAreaPolygonViewmodel.selectedArea!.latLongs.isNotEmpty)
                  ? widget.viewmodel.deliveryAreaPolygonViewmodel.selectedArea!.latLongs
                      .where((l) => l.isDeleted == false)
                      .toList()
                      .map(
                        (latLong) => Marker(
                          anchorPos: AnchorPos.exactly(Anchor(10, 7)),
                          width: 20,
                          height: 20,
                          point: latLong.latLng,
                          builder: (context) => CwPointMarkerPolygon(
                            area: widget.viewmodel.deliveryAreaPolygonViewmodel.selectedArea!,
                            point: latLong,
                            onRemove: (area, point) {
                              widget.viewmodel.deliveryAreaPolygonViewmodel.removeMarker(area: area, point: point);
                            },
                          ),
                        ),
                      )
                      .toList()
                  : [],
            Marker(point: latLong, builder: (context) => Image.asset(PImages.shop3d, height: 25, width: 25)),
          ],
        ),
      ],
    );
  }
}
