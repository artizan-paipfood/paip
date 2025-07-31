import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/helpers/command.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/components/delivery_areas_distance_card.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_per_mile_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SideBarDeliveryAreaRadiusComponent extends StatelessWidget {
  final DeliveryAreasPerMileViewmodel viewmodel;

  const SideBarDeliveryAreaRadiusComponent({required this.viewmodel, super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewmodel,
      builder: (context, _) {
        return Column(
          children: [
            Expanded(child: _buildPerMileListview()),
            const Divider(),
            _buildActions(context),
          ],
        );
      },
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ArtButton(
            child: Text(context.i18n.salvar),
            onPressed: () {
              Command0.executeWithLoader(
                context,
                () async => await viewmodel.save(),
                onSuccess: (r) => toast.showSucess('Salvo com sucesso'),
                onError: (e, s) => toast.showError('Erro ao salvar'),
              );
            },
          ),
        ),
        PSize.spacer.sizedBoxW,
        ArtIconButton.secondary(
          icon: Icon(PaipIcons.sortByDown),
          onPressed: () {
            viewmodel.sort();
          },
        ),
        PSize.spacer.sizedBoxW,
        ArtIconButton.secondary(
          icon: Icon(PaipIcons.add),
          onPressed: () {
            viewmodel.add();
          },
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
              autoPlay: true,
            )
            .then(delay: 2.seconds)
            .shake(delay: 1.seconds)
            .then()
            .shake()
            .shimmer()
      ],
    );
  }

  Widget _buildPerMileListview() {
    return ListView.builder(
      controller: viewmodel.scrollController,
      itemCount: viewmodel.areas.length,
      itemBuilder: (context, index) {
        final area = viewmodel.areas[index];
        return DeliveryAreasDistanceCard(
          key: viewmodel.key(area.id),
          isLast: index != 0 && index == viewmodel.areas.length - 1,
          onChange: viewmodel.onChange,
          onDelete: viewmodel.delete,
          area: area,
        );
      },
    );
  }
}
