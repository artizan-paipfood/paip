import 'package:cart/src/presentation/components/complement_sliver.dart';
import 'package:cart/src/presentation/components/header.dart';
import 'package:cart/src/presentation/components/safe_area_header_delegate.dart';
import 'package:cart/src/presentation/viewmodels/cart_product_viewmodel.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class CartProductPage extends StatefulWidget {
  final String productId;
  const CartProductPage({required this.productId, super.key});

  @override
  State<CartProductPage> createState() => _CartProductPageState();
}

class _CartProductPageState extends State<CartProductPage> {
  late final _viewmodel = context.read<CartProductViewmodel>();

  final _scrollController = ScrollController();

  final ValueNotifier<bool> _showSafeArea = ValueNotifier(false);

  final GlobalKey _firstStickyHeaderKey = GlobalKey();

  EdgeInsets get safeAreaPadding => MediaQuery.of(context).padding;

  double get topSafeArea => safeAreaPadding.top;

  @override
  void initState() {
    super.initState();
    _viewmodel.initialize(widget.productId);
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
      observers: [_viewmodel.load, _viewmodel],
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
              if (_viewmodel.product != null) Header(product: _viewmodel.product!),
            ],
          ),
        ),
        // SliverPersistentHeader(
        //   pinned: true,
        //   delegate: SafeAreaHeaderDelegate(
        //     height: topSafeArea,
        //     child: Material(
        //       color: context.artColorScheme.background,
        //       child: ValueListenableBuilder<bool>(
        //           valueListenable: _showSafeArea,
        //           builder: (context, showSafeArea, child) {
        //             return SizedBox();
        //           }),
        //     ),
        //   ),
        // ),
        ..._viewmodel.complements.asMap().entries.map(
          (entry) {
            final complement = entry.value;
            final index = _viewmodel.complements.indexOf(complement);
            return ComplementSliver(
              key: index == 0 ? _firstStickyHeaderKey : null,
              complement: complement,
              items: _viewmodel.getItemsByComplement(complement.id),
              complementQtySelected: _viewmodel.getComplementQtySelected(complement.id),
              onItemIncrement: (complementId, itemId) => _viewmodel.addItemToCart(complementId, itemId),
              onItemDecrement: (complementId, itemId) => _viewmodel.removeItemFromCart(complementId, itemId),
            );
          },
        ),
        SliverToBoxAdapter(
          child: PSize.vi.sizedBoxH,
        ),
      ],
    );
  }
}
