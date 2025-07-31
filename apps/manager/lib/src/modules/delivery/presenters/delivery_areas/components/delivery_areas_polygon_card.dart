import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/delivery/domain/utils/colors_utils.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_polygon_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasPolygonCard extends StatefulWidget {
  final DeliveryAreaModel area;
  final DeliveryAreasPolygonViewmodel viewmodel;
  final void Function(DeliveryAreaModel area) onSave;
  const DeliveryAreasPolygonCard({required this.area, required this.viewmodel, required this.onSave, super.key});

  @override
  State<DeliveryAreasPolygonCard> createState() => _DeliveryAreasPolygonCardState();
}

class _DeliveryAreasPolygonCardState extends State<DeliveryAreasPolygonCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: context.color.secondaryText.withOpacity(0.3))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              InkWell(
                onTap: () => widget.viewmodel.cleanOrSelectArea(area: widget.area),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          PopupMenuButton(
                            color: context.color.primaryBG,
                            tooltip: context.i18n.mudarCor,
                            elevation: 2,
                            offset: const Offset(245, 37),
                            surfaceTintColor: context.color.secondaryColor,
                            child: Icon(Icons.circle, color: widget.area.color),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: ColorsUtils.colors
                                      .map(
                                        (color) => InkWell(onTap: () => widget.viewmodel.changeColorArea(color: color, area: widget.area), child: DecoratedBox(decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Icon(Icons.circle, color: color))),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: SizedBox(child: Text(widget.area.label.toUpperCase(), style: context.textTheme.bodyLarge))),
                        ],
                      ),
                    ),
                    Row(children: [Text(widget.area.price.toString()), Icon(widget.viewmodel.selectedArea == widget.area ? Icons.expand_less : Icons.expand_more_outlined)]),
                  ],
                ),
              ),
              Visibility(
                visible: widget.area == widget.viewmodel.selectedArea,
                child: Column(
                  children: [
                    PSize.spacer.sizedBoxH,
                    CwTextFormFild(label: context.i18n.bairro, initialValue: widget.area.label, onChanged: (value) => widget.area.label = value),
                    CwTextFormFild(label: context.i18n.taxaEntrega, initialValue: widget.area.price.toStringAsFixed(2), maskUtils: MaskUtils.currency(), onChanged: (value) => widget.area.price = Utils.stringToDouble(value)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.viewmodel.deleteArea(area: widget.area);
                          },
                          icon: Icon(PaipIcons.trash, color: context.color.errorColor),
                        ),
                        Row(
                          children: [
                            CwTextButton(
                              onPressed: () {
                                if (widget.area.createdAt != null) {
                                  widget.viewmodel.cleanSelectedArea();
                                } else {
                                  widget.viewmodel.removeArea(area: widget.area);
                                }
                              },
                              label: context.i18n.cancelar,
                            ),
                            PSize.i.sizedBoxW,
                            PButton(onPressed: () => widget.onSave(widget.area), label: context.i18n.salvar),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
