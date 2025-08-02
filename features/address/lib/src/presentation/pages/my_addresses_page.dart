import 'package:address/src/presentation/components/use_mylocation_button.dart';
import 'package:address/src/presentation/viewmodels/my_addresses_viewmodel.dart';
import 'package:address/src/utils/routes.dart';
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
  void _onPressedSearch() {}

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
      appBar: AppBar(
        title: Text(
          'ENDEREÇOS DE ENTREGA',
          style: context.artTextTheme.h4.copyWith(fontSize: 16, color: context.artColorScheme.foreground),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0) + EdgeInsets.only(bottom: 12.0),
            child: ArtTextFormField(
              placeholder: Text('Endereço e número'),
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
              // prefixIcon: Icon(PaipIcons.searchLinear)
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _viewmodel.loading,
        builder: (context, value, child) {
          switch (value) {
            case true:
              return const Center(child: PaipLoader());
            case false:
              return _buildBody();
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (_viewmodel.locationPermission && _viewmodel.myCurrentAddress != null)
            UseMylocationButton(
              address: _viewmodel.myCurrentAddress!,
              onTap: () {
                context.pushNamed(
                  Routes.myPositionNamed,
                  queryParameters: {
                    'lat': _viewmodel.myCurrentAddress!.lat.toString(),
                    'lng': _viewmodel.myCurrentAddress!.long.toString(),
                  },
                );
              },
            ),
          Padding(
            padding: PSize.i.paddingAll + EdgeInsets.only(top: 12),
            child: Column(
              children: [
                MyAdressCard(isSelected: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
