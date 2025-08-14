import 'dart:math';

import 'package:address/address.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:store/src/presentation/components/category_sliver.dart';
import 'package:store/src/presentation/components/establishment_header_data.dart';
import 'package:store/src/presentation/components/header.dart';
import 'package:store/src/presentation/components/safe_area_header_delegate.dart';
import 'package:store/src/presentation/viewmodels/store_viewmodel.dart';
import 'package:ui/ui.dart';

class StorePage extends StatefulWidget {
  final String establishmentId;
  const StorePage({required this.establishmentId, super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final _viewmodel = context.read<StoreViewmodel>();

  final _scrollController = ScrollController();

  final ValueNotifier<bool> _showSafeArea = ValueNotifier(false);

  final GlobalKey _firstStickyHeaderKey = GlobalKey();

  EdgeInsets get safeAreaPadding => MediaQuery.of(context).padding;

  double get topSafeArea => safeAreaPadding.top;

  @override
  void initState() {
    super.initState();
    _viewmodel.initialize(widget.establishmentId);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final bool shouldShowSafeArea = offset > 200; // Threshold simples baseado no scroll

    if (shouldShowSafeArea != _showSafeArea.value) {
      _showSafeArea.value = shouldShowSafeArea;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      observers: [_viewmodel.load],
      builder: (context) {
        if (_viewmodel.load.value) {
          return const Center(child: PaipLoader());
        }
        return Scaffold(
          body: _buildContent(context),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(establishment: _viewmodel.establishment!),
              Padding(
                padding: PSize.iii.paddingHorizontal + PSize.i.paddingVertical,
                child: EstablishmentHeaderData(
                  establishment: _viewmodel.establishment!,
                  address: _viewmodel.establishmentAddress!,
                  openingHoursToday: _viewmodel.openingHoursToday,
                ),
              ),
            ],
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SafeAreaHeaderDelegate(
            height: topSafeArea + 69,
            child: Material(
              color: context.artColorScheme.background,
              child: ValueListenableBuilder<bool>(
                  valueListenable: _showSafeArea,
                  builder: (context, showSafeArea, child) {
                    return Padding(
                      padding: PSize.iii.paddingHorizontal + PSize.i.paddingBottom,
                      child: Column(
                        children: [
                          Visibility.maintain(
                            visible: !showSafeArea,
                            child: CardLocation(
                              address: _viewmodel.establishmentAddress!,
                              height: topSafeArea,
                            ),
                          ),
                          PSize.iii.sizedBoxH,
                          ArtTextFormField(
                            placeholder: Text('Nome do produto'),
                            // readOnly: true,
                            // enabled: false,

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
                          PSize.iii.sizedBoxH,
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),

        // Lista de categorias
        ..._viewmodel.categories.asMap().entries.map((entry) {
          final category = entry.value;
          final index = _viewmodel.categories.indexOf(category);

          return CategorySliver(
            key: index == 0 ? _firstStickyHeaderKey : null,
            category: category,
            products: _viewmodel.productsByCategory(category.id),
            onProductTap: (product) {
              // context.pushNamed(Routes.product, arguments: product);
            },
          );
        }),
      ],
    );
  }
}
