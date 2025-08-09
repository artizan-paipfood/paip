import 'package:address/address.dart';
import 'package:address/src/.i18n/gen/strings.g.dart';
import 'package:address/src/data/events/route_events.dart';
import 'package:address/src/presentation/components/confirm_delete_dialog.dart';
import 'package:address/src/presentation/components/use_mylocation_button.dart';
import 'package:address/src/presentation/viewmodels/my_addresses_viewmodel.dart';
import 'package:auth/auth.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import '../components/my_adress_card.dart';

class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({super.key});

  @override
  State<MyAddressesPage> createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {
  late final _viewmodel = context.read<MyAddressesViewmodel>();

  void _onPressedSearch() => ModularEvent.fire(GoAutoCompleteEvent());

  void _onUseMyLocation() => ModularEvent.fire(GoMyPositionEvent(
        lat: _viewmodel.myCurrentAddress!.lat!,
        lng: _viewmodel.myCurrentAddress!.long!,
      ));

  bool get _isLoading => _viewmodel.loading.value;
  bool get _isNotLoading => !_isLoading;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _viewmodel.initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.artColorScheme.muted,
      appBar: PaipAppBar(
        title: Text(t.enderecos_de_entrega.toUpperCase()),
      ),
      body: ValueListenableBuilder(
        valueListenable: _viewmodel.loading,
        builder: (context, value, child) {
          switch (value) {
            case true:
              return const Center(child: PaipLoader());
            case false:
              return Column(
                children: [
                  ColoredBox(
                    color: context.artColorScheme.background,
                    child: Padding(
                      padding: PSize.spacer.paddingHorizontal + PSize.ii.paddingBottom,
                      child: ArtTextFormField(
                        placeholder: Text(t.buscar_endereco_placeholder),
                        readOnly: true,
                        enabled: _isNotLoading,
                        onPressed: () => _onPressedSearch(),
                        decoration: ArtDecoration(
                          color: context.artColorScheme.muted,
                        ),
                        trailing: PaipIcon(
                          PaipIcons.searchLinear,
                          color: context.artColorScheme.ring,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: _buildBody()),
                ],
              );
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (_viewmodel.locationPermission == AppLocationPermission.enabled && _viewmodel.myCurrentAddress != null)
            UseMylocationButton(
              address: _viewmodel.myCurrentAddress!,
              padding: PSize.spacer.paddingHorizontal + PSize.ii.paddingVertical,
              onTap: () => _onUseMyLocation(),
            ),
          Padding(
            padding: PSize.iii.paddingHorizontal + PSize.iii.paddingTop,
            child: Column(children: [
              if (UserMe.me != null)
                ...UserMe.me!.addresses.map(
                  (address) => Padding(
                    padding: EdgeInsets.only(bottom: PSize.iii.value),
                    child: MyAdressCard(
                      isSelected: address.id == UserMe.me!.data.selectedAddressId,
                      address: address,
                      onTap: (address) {},
                      onDelete: (address) async {
                        await showConfirmDeleteDialog(
                          context,
                          title: t.excluir_endereco,
                          description: t.excluir_endereco_descricao,
                          onConfirm: () async {
                            await Command0.executeWithLoader(
                              context,
                              () async => await _viewmodel.deleteAddress(address),
                            );
                          },
                        );
                      },
                      onEdit: (address) {},
                    ),
                  ),
                ),
              PSize.v.sizedBoxH,
            ]),
          ),
        ],
      ),
    );
  }
}
