import 'package:flutter/material.dart';

class RowTitleValueOrder extends StatelessWidget {
  final String title;
  final String value;
  const RowTitleValueOrder({
    super.key,
    this.title = '',
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
