import 'package:flutter/material.dart';

class Observer extends StatefulWidget {
  final List<Listenable> observers;
  final WidgetBuilder builder;

  const Observer({
    super.key,
    required this.observers,
    required this.builder,
  });

  @override
  State<Observer> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  late Listenable _merged;

  @override
  void initState() {
    super.initState();
    _merged = Listenable.merge(widget.observers);
    _merged.addListener(_listener);
  }

  void _listener() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(Observer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.observers != widget.observers) {
      _merged.removeListener(_listener);
      _merged = Listenable.merge(widget.observers);
      _merged.addListener(_listener);
    }
  }

  @override
  void dispose() {
    _merged.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
