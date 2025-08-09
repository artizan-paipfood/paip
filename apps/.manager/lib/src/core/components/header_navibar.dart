import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/services/establishment_service.dart';
import 'package:manager/src/core/components/sidebar/card_closed.dart';
import 'package:manager/src/core/components/sidebar/card_open.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HeaderNavibar extends StatelessWidget {
  final EstablishmentService establishmentService;
  final EstablishmentModel establishment;
  const HeaderNavibar({required this.establishmentService, required this.establishment, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        establishment.isOpen ? CardOpen(establishment: establishment, establishmentService: establishmentService) : CardClosed(establishmentService: establishmentService),
        const SizedBox(width: 8),
        Tooltip(
          message: establishment.fantasyName,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 100, child: Text(establishment.fantasyName, style: context.textTheme.bodyLarge, overflow: TextOverflow.ellipsis)),
              SizedBox(width: 100, child: Text(context.i18n.bemVindo, style: context.textTheme.bodySmall!.copyWith(fontSize: 10), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ],
    );
  }
}
