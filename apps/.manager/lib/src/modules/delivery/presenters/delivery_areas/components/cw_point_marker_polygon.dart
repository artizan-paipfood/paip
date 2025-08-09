import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwPointMarkerPolygon extends StatefulWidget {
  final DeliveryAreaModel area;
  final LatLongModel point;
  final void Function()? onDoubleTap;
  final void Function(DeliveryAreaModel area, LatLongModel point) onRemove;

  const CwPointMarkerPolygon({
    required this.area,
    required this.point,
    required this.onRemove,
    super.key,
    this.onDoubleTap,
  });

  @override
  State<CwPointMarkerPolygon> createState() => _CwPointMarkerPolygonState();
}

class _CwPointMarkerPolygonState extends State<CwPointMarkerPolygon> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          hover = value;
        });
      },
      onTap: () => widget.onRemove(widget.area, widget.point),
      onDoubleTap: widget.onDoubleTap,
      child: Stack(
        children: [
          Align(
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade400, offset: const Offset(0, 1), spreadRadius: 2)]),
            ),
          ),
          Visibility(
            visible: hover,
            child: const Align(
              alignment: Alignment.topRight,
              child: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                child: Icon(
                  Icons.close,
                  size: 10,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
