import 'package:flutter/material.dart';

class ManuallyPage extends StatelessWidget {
  final double lat;
  final double lng;
  const ManuallyPage({required this.lat, required this.lng, super.key});

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
