import 'package:address/address.dart';
import 'package:auth/auth.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:explore/src/presentation/components/card_establishment_explore.dart';
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
  void initState() {
    super.initState();
    if (_viewmodel.selectedAddress != null) {
      _viewmodel.refreshByLocation(address: _viewmodel.selectedAddress!);
    }
  }

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
                    padding: PSize.spacer.paddingHorizontal + PSize.ii.paddingTop + PSize.ii.paddingBottom,
                    child: ArtTextFormField(
                      placeholder: Text('Nome do estabelecimento'),
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
                Material(
                  child: ArtDivider.horizontal(margin: EdgeInsets.zero),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _viewmodel.establishments.length,
                    itemBuilder: (context, index) {
                      final establishment = _viewmodel.establishments[index];
                      return InkWell(
                        onTap: () {},
                        overlayColor: WidgetStateProperty.all(context.artColorScheme.primary.withValues(alpha: 0.1)),
                        child: Padding(
                          padding: PSize.iii.paddingHorizontal + PSize.ii.paddingVertical,
                          child: CardEstablishmentExplore(
                            establishment: establishment,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
