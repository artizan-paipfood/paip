import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:store/src/_i18n/gen/strings.g.dart';
import 'package:store/src/data/events/select_product.dart';
import 'package:store/src/presentation/components/card_product.dart';
import 'package:store/src/presentation/viewmodels/store_viewmodel.dart';
import 'package:ui/ui.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final StoreViewmodel _viewmodel = context.read<StoreViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaipAppBar(
        title: Text(t.pesquisar_produto),
      ),
      body: Column(
        children: [
          Padding(
            padding: PSize.spacer.paddingHorizontal + PSize.i.paddingTop + PSize.ii.paddingBottom,
            child: ArtTextFormField(
              placeholder: Text(t.pesquisar_produto_placeholder),
              autofocus: true,
              decoration: ArtDecoration(color: context.artColorScheme.muted),
              onChanged: (value) {
                _viewmodel.searchProducts(value);
              },
              trailing: PaipIcon(
                PaipIcons.searchLinear,
                color: context.artColorScheme.ring,
                size: 18,
              ),
            ),
          ),
          PSize.spacer.sizedBoxH,
          Expanded(child: _buildListAddresses())
        ],
      ),
    );
  }

  Widget _buildListAddresses() {
    return ValueListenableBuilder(
        valueListenable: _viewmodel.productsFiltered,
        builder: (context, products, child) {
          if (products.isEmpty) {
            return Center(
              child: ArtEmptyState.minimal(
                icon: PaipIcon(
                  PaipIcons.searchDuotone,
                  color: context.artColorScheme.primary,
                ),
                title: t.nenhum_produto_encontrado,
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return CardProduct(
                product: product,
                onProductTap: (product) => ModularEvent.fire(SelectProduct(establishmentId: _viewmodel.establishment!.id, productId: product.id)),
              );
            },
          );
        });
  }
}
