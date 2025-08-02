import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyPositionViewmodel extends ChangeNotifier {
  final MapController mapController = MapController();
  late LatLng _latLng;
  LatLng get latLng => _latLng;

  static const double pointY = 400;

  Timer? _timerEnableButton;
  bool _isEnabledButton = true;

  MyPositionViewmodel({required double lat, required double lng}) {
    _latLng = LatLng(lat, lng);
  }

  bool get isEnabledButton => _isEnabledButton;

  void enableButton() {
    _timerEnableButton?.cancel();
    _timerEnableButton = Timer(const Duration(milliseconds: 250), () {
      _isEnabledButton = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    });
  }

  void updatePoint(BuildContext context) {
    _isEnabledButton = false;
    _latLng = mapController.camera.screenOffsetToLatLng(Offset(_getPointX(context), pointY));
    notifyListeners();
    enableButton();
  }

  double _getPointX(BuildContext context) => MediaQuery.sizeOf(context).width / 2;

  @override
  void dispose() {
    _timerEnableButton?.cancel();
    mapController.dispose();
    super.dispose();
  }
}
