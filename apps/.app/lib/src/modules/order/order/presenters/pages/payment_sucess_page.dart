import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class PaymentSucessPage extends StatefulWidget {
  final String orderId;
  const PaymentSucessPage({
    super.key,
    required this.orderId,
  });

  @override
  State<PaymentSucessPage> createState() => _PaymentSucessPageState();
}

class _PaymentSucessPageState extends State<PaymentSucessPage> {
  bool _callPop = false;

  @override
  void initState() {
    Future.delayed(2.5.seconds, () {
      if (mounted) {
        setState(() {
          _callPop = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_callPop) {
      context.pop();
    }
    return Stack(
      children: [
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(color: context.color.primaryColor, shape: BoxShape.circle),
          ),
        ).animate().scale(begin: const Offset(1, 1), end: const Offset(13, 13), duration: 3.seconds, curve: Curves.easeInOutQuart),
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(PIcons.strokeRoundedTick02, color: PColors.primaryColor_, size: 80),
          ),
        ).animate().scale(begin: const Offset(0, 0), end: const Offset(1, 1), curve: Curves.easeInOutBack, delay: 2.seconds)
      ],
    );
  }
}
