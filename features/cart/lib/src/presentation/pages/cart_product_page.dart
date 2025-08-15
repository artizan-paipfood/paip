import 'package:flutter/material.dart';

class CartProductPage extends StatelessWidget {
  final String productId;

  const CartProductPage({required this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
