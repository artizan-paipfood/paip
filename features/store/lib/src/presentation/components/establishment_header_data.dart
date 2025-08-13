import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/_i18n/gen/strings.g.dart';
import 'package:ui/ui.dart';

class EstablishmentHeaderData extends StatefulWidget {
  final EstablishmentEntity establishment;
  final AddressEntity address;
  final OpeningHoursEntity? openingHoursToday;
  const EstablishmentHeaderData({
    required this.establishment,
    required this.address,
    required this.openingHoursToday,
    super.key,
  });

  @override
  State<EstablishmentHeaderData> createState() => _EstablishmentHeaderDataState();
}

class _EstablishmentHeaderDataState extends State<EstablishmentHeaderData> {
  TextStyle get muted => context.textTheme.bodySmall!.copyWith(color: context.artColorScheme.mutedForeground);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(widget.establishment.fantasyName ?? '--')),
            PSize.i.sizedBoxW,
            ArtBadge.secondary(
              backgroundColor: Colors.green.withValues(alpha: 0.2),
              child: Text(
                'Aberto'.toUpperCase(),
              ),
            ),
          ],
        ),

        // _builRichText(context, label: "", content: context.i18n.pedidoMinimoAbreviado(store.establishment.minimunOrder.toStringCurrency)),
        // if (!establishment.isOpen) Text(context.i18n.fechado, style: context.textTheme.titleSmall?.copyWith(color: context.color.errorColor)),
        // Text(context.i18n.localizacaoDoEstabelecimento, style: context.textTheme.titleMedium?.copyWith()),
        Row(
          children: [
            Expanded(child: Text("${widget.address.mainText}\n${widget.address.secondaryText}", maxLines: 2, style: muted)),
            ArtBadge.secondary(child: Text(t.tempo_abreviado(initialTime: widget.establishment.getTimesDelivery[0], endTime: widget.establishment.getTimesDelivery[1])))
          ],
        ),
        PSize.i.sizedBoxH,
      ],
    );
  }

  Widget _builRichText(BuildContext context, {required String label, required String content}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: muted,
        children: [const WidgetSpan(child: Padding(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5), child: Icon(Icons.circle, size: 5))), TextSpan(text: content, style: context.artTextTheme.muted)],
      ),
    );
  }
}
