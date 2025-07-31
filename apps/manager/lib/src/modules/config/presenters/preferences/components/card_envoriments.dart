import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CardEnvoriments extends StatefulWidget {
  final String label;
  final String description;
  final Widget child;
  const CardEnvoriments({
    required this.child,
    super.key,
    this.label = '',
    this.description = '',
  });

  @override
  State<CardEnvoriments> createState() => _CardEnvorimentsState();
}

class _CardEnvorimentsState extends State<CardEnvoriments> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PSize.i.paddingBottom,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: PSize.i.borderRadiusAll,
          color: context.color.surface,
        ),
        child: Padding(
          padding: PSize.i.paddingAll,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity, child: Text(widget.label, style: context.textTheme.titleMedium)),
                    if (widget.description != '') SizedBox(width: double.infinity, child: Text(widget.description, style: context.textTheme.bodyMedium?.muted(context))),
                  ],
                ),
              ),
              PSize.i.sizedBoxW,
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
