import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/components/delivery_areas_polygon_card.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_polygon_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SideBarDeliveryAreaPolygonComponent extends StatelessWidget {
  final DeliveryAreasPolygonViewmodel viewmodel;

  const SideBarDeliveryAreaPolygonComponent({required this.viewmodel, super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewmodel,
      builder: (context, _) {
        return Column(
          children: [
            Expanded(child: _buildPolygonListview()),
            const Divider(),
            Row(children: [Expanded(child: PButton(onPressed: () => viewmodel.addArea(), icon: Icons.add, label: context.i18n.adicionarArea))]),
          ],
        );
      },
    );
  }

  Widget _buildPolygonListview() {
    return ListView.builder(
      controller: viewmodel.scrollController,
      itemCount: viewmodel.deliveryAreasSortByLabel.length,
      itemBuilder: (context, index) {
        final area = viewmodel.deliveryAreasSortByLabel[index];
        return DeliveryAreasPolygonCard(
          area: area,
          viewmodel: viewmodel,
          onSave: (area) async {
            try {
              Loader.show(context);
              await viewmodel.save(area);
            } catch (e) {
              toast.showError(e.toString());
            } finally {
              Loader.hide();
            }
          },
        );
      },
    );
  }
}
