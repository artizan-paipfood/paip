import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddTableWidget extends StatefulWidget {
  final void Function() onTap;
  const AddTableWidget({
    required this.onTap,
    super.key,
  });

  @override
  State<AddTableWidget> createState() => _AddTableWidgetState();
}

class _AddTableWidgetState extends State<AddTableWidget> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: widget.onTap, onHover: (value) => setState(() => _isHover = value), child: _isHover ? DottedBorder(color: context.color.neutral500, child: Center(child: Icon(PIcons.strokeRoundedAdd01, color: context.color.neutral500, size: 30))) : const SizedBox.shrink());
  }
}
