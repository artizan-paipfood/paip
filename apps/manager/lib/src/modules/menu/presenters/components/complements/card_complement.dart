import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/switch_active_inative.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/drag_complement_widget.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/end_drawer_complement.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/list_items.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardComplement extends StatefulWidget {
  final ComplementModel complement;
  final bool isSelected;
  final void Function() onTap;
  final int index;
  const CardComplement({required this.complement, required this.isSelected, required this.onTap, required this.index, super.key});

  @override
  State<CardComplement> createState() => _CardComplementState();
}

class _CardComplementState extends State<CardComplement> {
  bool _isSelected() {
    if (widget.complement.items.isEmpty || widget.isSelected) return true;
    return false;
  }

  // bool _onHover = false;
  @override
  Widget build(BuildContext context) {
    final store = context.read<MenuStore>();

    return Material(
      borderRadius: BorderRadius.circular(3),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Draggable<ComplementModel>(
            data: widget.complement,
            feedback: DragComplementWidget(complement: widget.complement, isDragable: true),
            affinity: Axis.horizontal,
            child: InkWell(
              onTap: widget.onTap,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: _isSelected() ? context.color.primaryColor : context.color.secondaryText.withOpacity(0.5), width: _isSelected() ? 2 : 1),
                  borderRadius: BorderRadius.circular(3),
                  color: context.color.primaryBG,
                  boxShadow: const [BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.25), blurRadius: 8, spreadRadius: -2, offset: Offset(0, 4)), BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.08), spreadRadius: 1)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReorderableDragStartListener(index: widget.index, child: const Icon(PaipIcons.dragDropVertical)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.complement.identifier, style: context.textTheme.titleMedium, overflow: TextOverflow.ellipsis),
                                if (widget.complement.identifier.isNotEmpty) Text("${widget.complement.name} - ${widget.complement.qtyMin} | ${widget.complement.qtyMax}", style: context.textTheme.bodyMedium, overflow: TextOverflow.clip),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                elevation: 5,
                                tooltip: "",
                                color: context.color.surface,
                                surfaceTintColor: context.color.surface,
                                offset: const Offset(80, 0),
                                itemBuilder: (ctx) => [
                                  CwPopMenuItem.icon(
                                    context,
                                    label: context.i18n.editar,
                                    icon: PIcons.strokeRoundedEdit02,
                                    onTap: () {
                                      store.complementSelected = widget.complement;
                                      showDialog(context: context, builder: (context) => EndDrawerComplement(complement: widget.complement, isEdit: true));
                                    },
                                  ),
                                  CwPopMenuItem.icon(
                                    context,
                                    label: context.i18n.duplicar,
                                    icon: PIcons.strokeRoundedCopy02,
                                    onTap: () async {
                                      Loader.show(context);
                                      try {
                                        await store.duplicateComplement(widget.complement);
                                      } finally {
                                        Loader.hide();
                                      }
                                    },
                                  ),
                                  CwPopMenuItem.icon(
                                    context,
                                    label: context.i18n.deletar,
                                    icon: PaipIcons.trash,
                                    iconColor: context.color.errorColor,
                                    onTap: () {
                                      showDialog(context: context, builder: (context) => DialogDelete(onDelete: () => store.deleteComplement(widget.complement)));
                                    },
                                  ),
                                ],
                              ),
                              CwSwitchActiveInative(
                                isActive: widget.complement.visible,
                                onTap: () {
                                  widget.complement.visible = !widget.complement.visible;
                                  store.syncComplement(widget.complement);
                                  return widget.complement.visible;
                                },
                              ),
                              IconButton(onPressed: widget.onTap, icon: Icon(_isSelected() ? PaipIcons.chevronUp : PaipIcons.chevronDown)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isSelected())
            ValueListenableBuilder(
              valueListenable: store.rebuildItems,
              builder: (context, _, __) {
                return Column(
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.complement.items.where((item) => item.isDeleted == false).isEmpty) {
                          return CwEmptyState(size: 100, icon: PaipIcons.dropBox, bgColor: false, label: context.i18n.emptyStateItens);
                        }
                        return ListItems(complement: widget.complement, store: store);
                      },
                    ),
                    PSize.i.sizedBoxH,
                    if (store.itemSelected == null)
                      PButton(
                        label: context.i18n.adicionarItemA(widget.complement.name),
                        onPressed: () {
                          store.insertItem(widget.complement);
                        },
                        icon: PaipIcons.add,
                      ),
                    PSize.i.sizedBoxH,
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
