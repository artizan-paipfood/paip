import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/command.dart';
import 'package:app/src/modules/user/presenters/viewmodels/search_address_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddressResultsList extends StatelessWidget {
  final SearchAddressViewmodel searchViewModel;
  final Function(AddressEntity address) onSelect;
  final double? latReference;
  final double? lonReference;
  const AddressResultsList({
    super.key,
    required this.onSelect,
    required this.searchViewModel,
    required this.latReference,
    required this.lonReference,
  });
  Future<void> _onSelectAddress(BuildContext context, AddressModel address) async {
    Command0.executeWithLoader(context, () async {
      final result = await searchViewModel.selectAddress(
        address: address,
        latReference: latReference,
        lonReference: lonReference,
      );
      await onSelect(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: searchViewModel,
      builder: (context, child) {
        if (searchViewModel.addresses.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          itemCount: searchViewModel.addresses.length,
          itemBuilder: (context, index) {
            final address = searchViewModel.addresses[index];
            return _buildAddressListTile(context, address);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: PSize.viii.paddingTop,
      child: Center(
        child: ValueListenableBuilder(
            valueListenable: searchViewModel.isLoadingNotifier,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    PaipIcons.search,
                    size: 48,
                    color: context.color.muted,
                  ),
                  PSize.ii.sizedBoxH,
                  Text(
                    context.i18n.digiteUmEnderecoParaBuscar,
                    style: context.textTheme.bodyMedium?.muted(context),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildAddressListTile(BuildContext context, AddressModel address) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      onTap: () => _onSelectAddress(context, address),
      leading: CircleAvatar(
        backgroundColor: context.color.black,
        child: Icon(
          PaipIcons.mapPin,
          color: context.color.white,
          size: 24,
        ),
      ),
      title: Text(
        address.mainText,
        style: context.textTheme.titleMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        address.secondaryText,
        style: context.textTheme.bodySmall?.muted(context),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
