import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:paipfood_package/paipfood_package.dart';
import '../../../aplication/stores/information_store.dart';

class AddressEstablishment extends StatefulWidget {
  const AddressEstablishment({super.key});

  @override
  State<AddressEstablishment> createState() => _AddressEstablishmentState();
}

class _AddressEstablishmentState extends State<AddressEstablishment> {
  late final store = context.read<InformationStore>();
  late final searchAddressRepo = context.read<IAddressApi>();
  late final neighborhoodEC = TextEditingController(text: store.address.neighborhood);
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final latLon = LatLng(store.address.lat!, store.address.long!);

    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CwHeaderCard(titleLabel: context.i18n.endereco, description: context.i18n.descEndereco),
          CwSearchAddress(
            country: LocaleNotifier.instance.locale.name,
            initialValue: store.address.address,
            addressApi: searchAddressRepo,
            onSelectAddress: (value) {
              final latLonAfter = LatLng(value.lat!, value.long!);
              setState(() {
                store.establishment.city = value.city;
                store.address = value.copyWith(id: store.address.id, number: store.address.number, complement: store.address.complement, neighborhood: store.address.neighborhood, establishmentId: store.establishment.id);
              });
              Future.delayed(100.ms, () {
                mapController.move(latLonAfter, 15);
              });
            },
            neighborhoodEC: neighborhoodEC,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CwTextFormFild(
                initialValue: store.address.number,
                label: context.i18n.numero,
                expanded: true,
                maskUtils: MaskUtils.cRequired(),
                onChanged: (value) {
                  store.address = store.address.copyWith(number: value);
                },
              ),
              PSize.iv.sizedBoxW,
              CwTextFormFild(
                controller: neighborhoodEC,
                label: l10nProiver.aPartirDe(''),
                maskUtils: MaskUtils.cRequired(),
                expanded: true,
                onChanged: (value) {
                  store.address = store.address.copyWith(neighborhood: value);
                },
              ),
            ],
          ),
          CwTextFormFild(
            initialValue: store.address.complement,
            label: context.i18n.complemento,
            onChanged: (value) {
              store.address = store.address.copyWith(complement: value);
            },
          ),
          PSize.i.sizedBoxH,
          Material(
            borderRadius: PSize.ii.borderRadiusAll,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: SizedBox(
              height: 200,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(enableScrollWheel: false, minZoom: 10, maxZoom: 18, zoom: 15, screenSize: const Size(double.infinity, 200), center: latLon),
                nonRotatedChildren: [
                  TileLayer(urlTemplate: context.isDarkTheme ? Env.googleMapsDark : Env.googleMapsLight),
                  CircleLayer(circles: [CircleMarker(point: latLon, radius: 100, color: PColors.primaryColor_.withOpacity(0.3), useRadiusInMeter: true, borderColor: PColors.primaryColor_, borderStrokeWidth: 2)]),
                  MarkerLayer(markers: [Marker(point: latLon, builder: (context) => Image.asset(PImages.shop3d, height: 25, width: 25))]),
                ],
              ),
            ),
          ),
          PSize.i.sizedBoxH,
          CwTextFormFild(
            initialValue: store.establishment.deliveryRadius.toString(),
            label: context.i18n.raioEntrega,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
            onChanged: (value) {
              store.establishment = store.establishment.copyWith(deliveryRadius: int.tryParse(value) ?? 0);
            },
          ),
        ],
      ),
    );
  }
}
