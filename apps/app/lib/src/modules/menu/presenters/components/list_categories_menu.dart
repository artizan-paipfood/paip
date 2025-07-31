import 'package:flutter/material.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/view_models/cart_product_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/price_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListCategoriesMenu extends StatefulWidget {
  final CategoryModel categoryModel;
  const ListCategoriesMenu({
    required this.categoryModel,
    super.key,
  });

  @override
  State<ListCategoriesMenu> createState() => _ListCategoriesMenuState();
}

class _ListCategoriesMenuState extends State<ListCategoriesMenu> {
  late final store = context.read<CartProductViewmodel>();
  late final menuStore = context.read<MenuViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: context.color.surface,
          ),
          child: Padding(
            padding: PSize.i.paddingVertical + PSize.ii.paddingHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.categoryModel.name.toUpperCase(), style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        ...widget.categoryModel.productsSortIndex.map((product) {
          final index = widget.categoryModel.productsSortIndex.indexOf(product);
          final bool isLast = index == widget.categoryModel.productsSortIndex.length - 1;
          return Column(
            children: [
              Padding(
                padding: PSize.i.paddingHorizontal,
                child: Material(
                  child: InkWell(
                    onTap: () async {
                      context.push(
                        Routes.cartProduct(establishmentId: menuStore.establishment.id, productId: product.id),
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: context.color.primaryBG,
                          border: !isLast
                              ? Border(
                                  bottom: BorderSide(
                                  color: context.isDarkTheme ? context.color.neutral300 : context.color.neutral100,
                                ))
                              : null),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(product.name, style: context.textTheme.titleSmall),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      product.description,
                                      style: context.textTheme.bodyMedium?.muted(context),
                                    ),
                                  ),
                                  PriceWidget(
                                    price: product.price,
                                    priceFrom: product.priceFrom,
                                    promotionalPrice: product.promotionalPrice,
                                    textStyle: context.textTheme.titleSmall,
                                    colorText: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            PSize.ii.sizedBoxW,
                            if (product.image != null)
                              Hero(
                                tag: product.id,
                                child: Material(
                                  borderRadius: PSize.i.borderRadiusAll,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: CachedNetworkImage(
                                    cacheKey: product.imageCacheIdThumb,
                                    imageUrl: product.imagePathThumb.buildPublicUriBucket,
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
