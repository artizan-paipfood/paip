import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart' hide AddressModel;

class CwSearchAddress extends StatefulWidget {
  final IAddressApi addressApi;
  final String country;
  final TextEditingController? neighborhoodEC;
  final Function(AddressEntity address) onSelectAddress;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final bool autoUnfocus;
  final bool autoFocus;
  final String? hint;
  final TextStyle? textStyle;
  final AddressEntity? establishmentAddress;
  final Widget? onEmptyWidget;

  final double? maxheight;
  const CwSearchAddress({
    required this.addressApi,
    required this.onSelectAddress,
    required this.country,
    this.establishmentAddress,
    super.key,
    this.neighborhoodEC,
    this.initialValue = "",
    this.label,
    this.hintText,
    this.maxheight,
    this.autoUnfocus = true,
    this.autoFocus = false,
    this.hint,
    this.textStyle,
    this.onEmptyWidget,
  });

  @override
  State<CwSearchAddress> createState() => _CwSearchAddressState();
}

class _CwSearchAddressState extends State<CwSearchAddress> {
  final SearchController controller = SearchController();

  Future<List<Widget>> searchAddress({required String query, AddressEntity? establishmentAdress}) async {
    if (query.isEmpty) return [];
    List<AddressModel> result = [];

    result = await widget.addressApi.autocomplete(request: AutoCompleteRequest(query: query, locale: LocaleNotifier.instance.locale, provider: AutoCompleteProvider.mapbox, lat: establishmentAdress?.lat, lon: establishmentAdress?.long));

    if (query.length > 15 && result.isEmpty) return [widget.onEmptyWidget ?? Container()];

    return result
        .map((address) => ListTile(
              visualDensity: VisualDensity.standard,
              onTap: () async {
                try {
                  Loader.show(context);
                  final response = await widget.addressApi.geocode(
                    request: GeocodeRequest(
                      query: query,
                      provider: AutoCompleteProvider.mapbox,
                      locale: LocaleNotifier.instance.locale,
                      address: address,
                      lat: establishmentAdress?.lat,
                      lon: establishmentAdress?.long,
                      radius: 20,
                    ),
                  );
                  final entity = AddressEntity.fromAddressModel(response);
                  widget.onSelectAddress(entity);
                  controller
                    ..closeView(entity.address)
                    ..selection = TextSelection.fromPosition(const TextPosition(offset: 0));
                  if (widget.autoUnfocus) {
                    Future.delayed(200.ms, () {
                      if (mounted) FocusScope.of(context).unfocus();
                    });
                  }
                } catch (e) {
                  banner.showError(e.toString());
                } finally {
                  Loader.hide();
                }
              },
              tileColor: context.color.onPrimaryBG,
              leading: CircleAvatar(
                  backgroundColor: context.color.primaryText,
                  radius: 18,
                  child: Icon(
                    Icons.location_on_outlined,
                    color: context.color.primaryBG,
                  )),
              title: Text(
                address.mainText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                address.secondaryText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.textTheme.bodyMedium?.muted(context),
              ),
            ))
        .toList();
  }

  @override
  void dispose() {
    if (mounted) {
      Future.delayed(2.seconds, () {
        controller.dispose();
      });
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.autoFocus) {
      Future.delayed(100.ms, () {
        controller.openView();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CwSearchFild(
      maxheight: widget.maxheight,
      initialValue: widget.initialValue,
      debounceMilisecons: 450,
      searchOnTap: false,
      autoFocus: widget.autoFocus,
      textStyle: widget.textStyle,
      hintText: widget.hint ?? "Pesquise: Rua, Bairro, Cidade",
      label: widget.label ?? "Endereço do Estabelecimento",
      searchController: controller,
      onChanged: (value) async {
        // if (_onSelectedDelay) return [];
        return await searchAddress(query: value, establishmentAdress: widget.establishmentAddress);
      },
    );
  }
}
