import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class MyAdressCard extends StatefulWidget {
  final bool isSelected;
  final AddressEntity address;
  final Function(AddressEntity address) onTap;
  final Function(AddressEntity address)? onDelete;
  final Function(AddressEntity address)? onEdit;
  const MyAdressCard({
    required this.isSelected,
    required this.address,
    required this.onTap,
    this.onDelete,
    this.onEdit,
    super.key,
  });

  @override
  State<MyAdressCard> createState() => _MyAdressCardState();
}

class _MyAdressCardState extends State<MyAdressCard> {
  AddressEntity get _address => widget.address;
  final ArtPopoverController _popoverController = ArtPopoverController();

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      overlayColor: MaterialStateProperty.all(context.artColorScheme.ring.withOpacity(0.1)),
      onTap: () => widget.onTap(_address),
      child: ArtCard(
        padding: EdgeInsets.zero,
        border: widget.isSelected ? Border.all(color: context.artColorScheme.ring, width: widget.isSelected ? 2 : 0) : null,
        child: Stack(
          children: [
            Padding(
              padding: PSize.spacer.paddingHorizontal + PSize.ii.paddingVertical,
              child: Row(
                children: [
                  PaipIcon(PaipIcons.homeBold, color: widget.isSelected ? context.artColorScheme.primary : context.artColorScheme.mutedForeground),
                  SizedBox(width: 22),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_address.nickName, style: context.artTextTheme.h2.copyWith(fontSize: 14)),
                        SizedBox(height: 4),
                        Text(_address.mainText, style: context.artTextTheme.muted.copyWith(fontSize: 14, color: context.artColorScheme.foreground)),
                        Text(_address.secondaryText, style: context.artTextTheme.muted.copyWith(fontSize: 12)),
                        Text(_address.complement, style: context.artTextTheme.h2.copyWith(fontSize: 12, color: context.artColorScheme.primary)),
                      ],
                    ),
                  ),
                  SizedBox(width: 40), // Espaço para o botão
                ],
              ),
            ),
            if (widget.onEdit != null || widget.onDelete != null)
              Positioned(
                top: 6,
                right: 6,
                child: ArtContextMenu(
                  controller: _popoverController,
                  items: [
                    if (widget.onEdit != null)
                      ArtContextMenuItem(
                        leading: PaipIcon(
                          PaipIcons.editBold,
                          size: 18,
                          color: context.artColorScheme.foreground,
                        ),
                        child: Text('Editar'),
                        onPressed: () => widget.onEdit?.call(_address),
                      ),
                    if (widget.onDelete != null)
                      ArtContextMenuItem(
                        leading: PaipIcon(
                          PaipIcons.deleteDuotone,
                          size: 18,
                          color: context.artColorScheme.destructive,
                        ),
                        child: Text('Excluir'),
                        onPressed: () => widget.onDelete?.call(_address),
                      ),
                  ],
                  child: ArtIconButton.ghost(
                    onPressed: () {
                      _popoverController.show();
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: context.artColorScheme.ring,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
