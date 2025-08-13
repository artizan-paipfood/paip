import 'package:address/address.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:store/src/presentation/components/establishment_header_data.dart';
import 'package:store/src/presentation/components/header.dart';
import 'package:store/src/presentation/viewmodels/store_viewmodel.dart';
import 'package:ui/ui.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class StorePage extends StatefulWidget {
  final String establishmentId;
  const StorePage({required this.establishmentId, super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final _viewmodel = context.read<StoreViewmodel>();

  @override
  void initState() {
    super.initState();
    _viewmodel.initialize(widget.establishmentId);
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
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(establishment: _viewmodel.establishment!),
                    Padding(
                      padding: PSize.iii.paddingHorizontal + PSize.i.paddingVertical,
                      child: EstablishmentHeaderData(establishment: _viewmodel.establishment!, address: _viewmodel.establishmentAddress!, openingHoursToday: _viewmodel.openingHoursToday),
                    ),
                    Padding(
                      padding: PSize.iii.paddingHorizontal,
                      child: CardLocation(address: _viewmodel.establishmentAddress!),
                    ),
                    ArtDivider.horizontal(
                      margin: PSize.i.paddingVertical + PSize.iii.paddingHorizontal,
                    ),
                  ],
                ),
              ),
              // Lista de categorias
              ..._viewmodel.categories.map((category) => SliverStickyHeader(
                    header: Container(
                      height: 70,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final productIndex = index + 1;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Imagem do produto (placeholder)
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.fastfood,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Informações do produto
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Produto $productIndex da ${category.name}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Descrição do produto $productIndex - ${_getRandomDescription()}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'R\$ ${(9.99 + (productIndex * 0.50)).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Botão de adicionar
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: 15, // 15 produtos por categoria
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  String _getRandomDescription() {
    final descriptions = [
      'Descrição detalhada do produto 1',
      'Descrição detalhada do produto 2',
      'Descrição detalhada do produto 3',
      'Descrição detalhada do produto 4',
      'Descrição detalhada do produto 5',
    ];
    return descriptions[DateTime.now().millisecond % descriptions.length];
  }
}
