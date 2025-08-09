import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasDistanceCard extends StatefulWidget {
  final DeliveryAreaPerMileEntity area;
  final void Function(DeliveryAreaPerMileEntity area) onChange;
  final void Function(DeliveryAreaPerMileEntity area) onDelete;
  final bool isLast;
  const DeliveryAreasDistanceCard({
    required this.area,
    required this.onChange,
    required this.onDelete,
    required this.isLast,
    super.key,
  });

  @override
  State<DeliveryAreasDistanceCard> createState() => _DeliveryAreasDistanceCardState();
}

class _DeliveryAreasDistanceCardState extends State<DeliveryAreasDistanceCard> {
  late DeliveryAreaPerMileEntity _area = widget.area.copyWith();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ArtCard(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 80,
            child: CwTextFormFild(
              label: 'Distancia',
              suffixText: 'Km',
              initialValue: _area.radius.toString(),
              onChanged: (value) {
                final number = Utils.onlyNumbersRgx(value);
                if (number.isEmpty) return;
                _area = _area.copyWith(radius: double.parse(value));
                widget.onChange(_area);
              },
            ),
          ),
          PSize.spacer.sizedBoxW,
          Expanded(
            child: CwTextFormFild(
              label: context.i18n.taxaEntrega,
              initialValue: widget.area.price.toStringAsFixed(2),
              maskUtils: MaskUtils.currency(),
              onChanged: (value) {
                final number = Utils.onlyNumbersRgx(value);
                if (number.isEmpty) return;
                _area = _area.copyWith(price: double.parse(value));
                widget.onChange(_area);
              },
            ),
          ),
          if (widget.isLast)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 4),
              child: ArtIconButton.destructive(icon: Icon(Icons.close), onPressed: () => widget.onDelete(_area)),
            ),
        ],
      ),
    );
  }
}
