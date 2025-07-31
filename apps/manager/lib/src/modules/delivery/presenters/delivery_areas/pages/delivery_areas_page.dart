// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/components/delivery_areas_map_component.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/components/side_bar_delivery_area_polygon_component.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/components/side_bar_delivery_area_radius_component.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_per_mile_viewmodel.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_polygon_viewmodel.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/p_tab_bar_simple.dart';

class DeliveryAreasPage extends StatefulWidget {
  const DeliveryAreasPage({super.key});

  @override
  State<DeliveryAreasPage> createState() => _DeliveryAreasPageState();
}

class _DeliveryAreasPageState extends State<DeliveryAreasPage> {
  late final deliveryAreasPolygonViewmodel = context.read<DeliveryAreasPolygonViewmodel>();
  late final deliveryAreaPerMileViewmodel = context.read<DeliveryAreasPerMileViewmodel>();
  late final viewmodel = context.read<DeliveryAreasViewmodel>();
  late final dataS = context.read<DataSource>();

  Future<void> _toggleType(DeliveryMethod deliveryMethod) async {
    try {
      Loader.show(context);
      await viewmodel.changeDeliveryType(deliveryMethod);
    } catch (e) {
      toast.showError(e.toString());
    } finally {
      Loader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureState(
      ignoreListEmpty: true,
      future: viewmodel.load(),
      onError: (_, value) => Container(width: 50, color: Colors.black, child: Text(value.toString())),
      onComplete: (context, data) => ListenableBuilder(
        listenable: viewmodel.listenables,
        builder: (context, _) {
          return CwContainerShadow(
            child: Column(
              children: [
                CwHeaderCard(titleLabel: context.i18n.areasEntrega, description: context.i18n.descAreasEntrega),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: DeliveryAreasMapComponent(
                            viewmodel: viewmodel,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        color: context.color.primaryBG,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            children: [
                              PSize.spacer.sizedBoxH,
                              PTabBarSimple(
                                children: [
                                  PTabSimple(
                                    label: 'POLYGON',
                                    isSelected: viewmodel.deliveryMethod == DeliveryMethod.polygon,
                                    onTap: () async {
                                      deliveryAreasPolygonViewmodel.cleanSelectedArea();
                                      await _toggleType(DeliveryMethod.polygon);
                                    },
                                  ),
                                  PTabSimple(
                                    label: 'KM',
                                    isSelected: viewmodel.deliveryMethod == DeliveryMethod.miles,
                                    onTap: () async {
                                      deliveryAreasPolygonViewmodel.cleanSelectedArea();
                                      await _toggleType(DeliveryMethod.miles);
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: viewmodel.deliveryMethod == DeliveryMethod.polygon
                                    ? //
                                    SideBarDeliveryAreaPolygonComponent(viewmodel: deliveryAreasPolygonViewmodel)
                                    : SideBarDeliveryAreaRadiusComponent(viewmodel: deliveryAreaPerMileViewmodel),
                              ),
                              PSize.i.sizedBoxH,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
