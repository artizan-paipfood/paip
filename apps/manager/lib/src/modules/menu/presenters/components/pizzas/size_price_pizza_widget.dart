import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SizePricePizzaWidget extends StatefulWidget {
  final ProductModel product;
  final SizeModel size;
  const SizePricePizzaWidget({
    required this.product,
    required this.size,
    super.key,
  });

  @override
  State<SizePricePizzaWidget> createState() => _SizePricePizzaWidgetState();
}

class _SizePricePizzaWidgetState extends State<SizePricePizzaWidget> {
  bool isHover = false;
  int indexSpace = 0;
  String get _currency => LocaleNotifier.instance.currency;
  @override
  void initState() {
    indexSpace = widget.product.name.indexOf(" ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.withOpacity(0.2),
      borderRadius: 0.5.borderRadiusAll,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8), child: Text("${widget.product.name[indexSpace + 1]} - $_currency ${widget.size.price.toStringAsFixed(2)}", style: context.textTheme.bodyMedium?.copyWith(color: Colors.blue)).center),
    );
  }
}
