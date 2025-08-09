import 'package:address/address.dart';
import 'package:auth/auth.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:explore/src/presentation/viewmodels/explore_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late final _viewmodel = context.read<ExploreViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Observer(
        observers: [UserMe.observer],
        builder: (context) {
          return Scaffold(
            appBar: PaipAppBar(
              title: Padding(
                padding: PSize.spacer.paddingHorizontal,
                child: SelectedAdressDropIndicator(
                  address: _viewmodel.selectedAddress!,
                  onTap: () => ModularEvent.fire(GoMyAddressesEvent(go: true)),
                ),
              ),
            ),
            body: Column(
              children: [
                ColoredBox(
                  color: context.artColorScheme.background,
                  child: Padding(
                    padding: PSize.spacer.paddingHorizontal + PSize.ii.paddingBottom,
                    child: ArtTextFormField(
                      placeholder: Text('Nome do estabelecimento'),
                      readOnly: true,
                      // enabled: _isNotLoading,
                      // onPressed: () => _onPressedSearch(),
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
              ],
            ),
          );
        });
  }
}
