import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import '../components/my_adress_card.dart';

class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({super.key});

  @override
  State<MyAddressesPage> createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {
  void _onPressedSearch() {
    // TODO: Implementar a busca de endereços
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.artColorScheme.muted,
      appBar: AppBar(
        title: Text(
          'ENDEREÇOS DE ENTREGA',
          style: context.artTextTheme.h4.copyWith(fontSize: 16, color: context.artColorScheme.foreground),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0) + EdgeInsets.only(bottom: 12.0),
            child: ArtTextFormField(
              placeholder: Text('Endereço e número'),
              readOnly: true,
              onPressed: () => _onPressedSearch(),
              decoration: ArtDecoration(
                color: context.artColorScheme.muted,
              ),
              trailing: PaipIcon(
                PaipIcons.searchLinear,
                color: context.artColorScheme.ring,
                size: 18,
              ),
              // prefixIcon: Icon(PaipIcons.searchLinear)
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColoredBox(
              color: context.artColorScheme.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12) + EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    Icon(
                      Icons.radar,
                      size: 24,
                      color: context.artColorScheme.mutedForeground,
                    ),
                    SizedBox(width: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Usar localização atual', style: context.artTextTheme.h2.copyWith(fontSize: 16)),
                        SizedBox(height: 4),
                        Text('R. Maria José Tramonte Borguetti, 540'),
                        Text('Res. Torre, Poços de Caldas - MG', style: context.artTextTheme.muted),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: PSize.i.paddingAll + EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  MyAdressCard(isSelected: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
