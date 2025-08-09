import 'package:address/src/_i18n/gen/strings.g.dart';
import 'package:address/src/domain/models/address_manually_model.dart';
import 'package:address/src/presentation/components/address_manually_form.dart';
import 'package:address/src/presentation/viewmodels/address_manually_viewmodel.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui/ui.dart';

class AddressManuallyPage extends StatefulWidget {
  final double lat;
  final double lng;
  final AddressEntity? address;
  const AddressManuallyPage({required this.lat, required this.lng, this.address, super.key});

  @override
  State<AddressManuallyPage> createState() => _AddressManuallyPageState();
}

class _AddressManuallyPageState extends State<AddressManuallyPage> {
  late final _viewModel = context.read<AddressManuallyViewmodel>();
  AddressManuallyModel get _addressManuallyModel => _viewModel.addressManuallyModel;
  AddressEntity get _address => _addressManuallyModel.address;
  final _formKey = GlobalKey<FormState>();

  EdgeInsetsGeometry get _effectivePadding => PSize.spacer.paddingAll;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _viewModel.initialize(lat: widget.lat, lng: widget.lng, address: widget.address));
  }

  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await Command0.executeWithLoader(
        context,
        () async => await _viewModel.saveAddress(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaipAppBar(
        title: Text(t.complete_seu_endereco.toUpperCase()),
      ),
      body: ListenableBuilder(
          listenable: Listenable.merge([_viewModel.loading, _viewModel]),
          builder: (context, child) {
            if (_viewModel.loading.value) {
              return Center(child: const PaipLoader());
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* Mapa
                        IgnorePointer(
                          child: SizedBox(
                            height: 200,
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(widget.lat, widget.lng),
                                initialZoom: 18,
                                minZoom: 18,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: AppConstants.mapLightUrl,
                                ),
                                MarkerLayer(markers: [
                                  Marker(
                                    point: LatLng(widget.lat, widget.lng),
                                    height: 45,
                                    width: 45,
                                    child: Stack(
                                      children: [
                                        PaipIcon(
                                          PaipIcons.mapPointBold,
                                          size: 45,
                                          color: context.artColorScheme.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        //* Resumo do endereço
                        Padding(
                          padding: _effectivePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_address.mainText, style: context.artTextTheme.large),
                              Text(_address.secondaryText, style: context.artTextTheme.muted),
                            ],
                          ),
                        ),
                        //* Formulário
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: _effectivePadding,
                            child: AddressManuallyForm(
                              viewmodel: _viewModel,
                              onChanged: (addressManuallyModel) => _viewModel.changeAddressManually(addressManuallyModel),
                              onAddressWithoutNumberChanged: (value) => _viewModel.changeAddressWithoutNumber(value),
                              onAddressWithoutComplementChanged: (value) => _viewModel.changeAddressWithoutComplement(value),
                            ),
                          ),
                        ),
                        //* Espaçamento final
                        PSize.v.sizedBoxH,
                      ],
                    ),
                  ),
                ),
                //* Botão de salvar endereço
                DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(color: context.artColorScheme.border),
                  )),
                  child: Padding(
                    padding: PSize.spacer.paddingAll,
                    child: ArtButton(
                      onPressed: () => _saveAddress(),
                      expands: true,
                      child: Text(t.salvar_endereco),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
