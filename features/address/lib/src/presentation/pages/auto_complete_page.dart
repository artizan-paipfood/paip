import 'package:address/i18n/gen/strings.g.dart';
import 'package:address/src/presentation/viewmodels/auto_complete_viewmodel.dart';
import 'package:address/src/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class AutoCompletePage extends StatefulWidget {
  final AutoCompleteViewmodel viewmodel;

  const AutoCompletePage({required this.viewmodel, super.key});

  @override
  State<AutoCompletePage> createState() => _AutoCompletePageState();
}

class _AutoCompletePageState extends State<AutoCompletePage> {
  AutoCompleteViewmodel get viewmodel => widget.viewmodel;

  String _query = '';

  void _onSearchByPostcode() => context.pushNamed(Routes.postcodeNamed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaipAppBar(
        title: Text(t.buscar_endereco),
      ),
      body: Column(
        children: [
          Padding(
            padding: PSize.spacer.paddingHorizontal + PSize.i.paddingTop + PSize.ii.paddingBottom,
            child: ArtTextFormField(
              placeholder: Text(t.buscar_endereco_placeholder),
              autofocus: true,
              decoration: ArtDecoration(color: context.artColorScheme.muted),
              onChanged: (value) {
                _query = value;
                viewmodel.autocomplete(query: value);
              },
              trailing: PaipIcon(
                PaipIcons.searchLinear,
                color: context.artColorScheme.ring,
                size: 18,
              ),
            ),
          ),
          Padding(
            padding: PSize.iii.paddingRight,
            child: Align(
              alignment: Alignment.topRight,
              child: ArtButton.ghost(
                child: Text(t.buscar_por_cep),
                onPressed: () => _onSearchByPostcode(),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shake(delay: 5.seconds)
                  .then()
                  .shake(),
            ),
          ),
          Expanded(child: _buildListAddresses())
        ],
      ),
    );
  }

  Widget _buildListAddresses() {
    return ListenableBuilder(
        listenable: Listenable.merge([viewmodel.load, viewmodel]),
        builder: (context, child) {
          final loading = viewmodel.load.value;
          if (loading) {
            return const Center(child: PaipLoader());
          }

          if (loading == false && _query.length > 10 && viewmodel.addresses.isEmpty) {
            return Center(
              child: ArtEmptyState.small(
                icon: PaipIcon(
                  PaipIcons.ufo3Bold,
                  color: context.artColorScheme.primary,
                ),
                title: t.nenhum_endereco_encontrado,
                action: ArtButton.ghost(
                  child: Text(t.buscar_por_cep),
                  onPressed: () => _onSearchByPostcode(),
                ),
              ),
            );
          }
          if (loading == false && viewmodel.addresses.isEmpty) {
            return Center(
              child: ArtEmptyState.minimal(
                icon: PaipIcon(
                  PaipIcons.searchDuotone,
                  color: context.artColorScheme.primary,
                ),
                title: t.insira_seu_endereco_no_campo_acima,
              ),
            );
          }

          return ListView.builder(
            itemCount: viewmodel.addresses.length,
            itemBuilder: (context, index) {
              final address = viewmodel.addresses[index];
              return Padding(
                padding: PSize.spacer.paddingHorizontal + PSize.iii.paddingVertical,
                child: Row(
                  children: [
                    PaipIcon(PaipIcons.mapPointBold, size: 32, color: context.artColorScheme.ring),
                    PSize.iii.sizedBoxW,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.mainText,
                            style: context.artTextTheme.muted.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.artColorScheme.foreground,
                            ),
                          ),
                          Text(
                            address.secondaryText,
                            style: context.artTextTheme.muted.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
