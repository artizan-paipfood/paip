import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

// ignore: must_be_immutable
class Teste extends StatefulWidget {
  final String label;
  final Color? color;

  Teste({
    super.key,
    this.label = '',
    this.underline = false,
    this.color,
  });

  bool underline = false;
  set underlineSet(bool value) {
    underline = value;
  }

  @override
  State<Teste> createState() => _TesteState();
  static Widget underlines({required String label, required BuildContext context}) {
    final t = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Teste(label: label, color: context.color.primaryBG)..underlineSet = true,
    );
    return t;
  }
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.label);
  }
}

class TesteB extends StatelessWidget {
  const TesteB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Teste.underlines(label: "Teste", context: context),
    );
  }
}
