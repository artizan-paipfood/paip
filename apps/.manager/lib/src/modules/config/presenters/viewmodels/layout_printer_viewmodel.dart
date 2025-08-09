import 'package:flutter/material.dart';
import 'package:manager/src/core/stores/layout_printer_store.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LayoutPrinterViewmodel extends ChangeNotifier {
  final LayoutPrinterUsecase layoutPrinterUsecase;
  LayoutPrinterViewmodel({required this.layoutPrinterUsecase});

  LayoutPrinterDto? _layoutPrinter;

  LayoutPrinterDto get layoutPrinter => _layoutPrinter!;

  List<LayoutPrinter> get layouts => _layoutPrinter?.sections ?? [];

  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void initialize(LayoutPrinterDto dto) {
    _layoutPrinter = dto;
  }

  LayoutPrinter? layoutSelected;

  void selectLayout(LayoutPrinter layout) {
    layoutSelected = layout;
    notifyListeners();
  }

  Future<void> save(LayoutPrinterDto dto) async {
    final result = await layoutPrinterUsecase.upsert(dto: dto);
    LayoutPrinterStore.instance.addLayouts(layouts: [result]);
  }

  Future<void> delete(LayoutPrinterDto dto) async {
    await layoutPrinterUsecase.delete(id: dto.layoutPrinter.id);
    LayoutPrinterStore.instance.removeLayout(name: dto.layoutPrinter.name);
  }

  bool isSelected(int index) {
    if (layoutSelected == null) return false;
    return layoutSelected!.index == index;
  }

  void onEditLayout(LayoutPrinter layout) {
    final index = layouts.indexOf(layoutSelected!);
    layoutSelected = layout;
    layouts[index] = layout;
    _layoutPrinter = _layoutPrinter!.copyWith(sections: layouts);
    notifyListeners();
  }

  void onEditDto(LayoutPrinterDto dto) {
    layoutSelected = null;
    _layoutPrinter = dto;
    notifyListeners();
  }

  void addLayout(LayoutPrinter layout) {
    layoutSelected = null;
    _layoutPrinter = _layoutPrinter!.copyWith(sections: [..._layoutPrinter!.sections, layout.copyWith(index: _layoutPrinter!.sections.length)]);
    layoutSelected = layout;
    Future.delayed(500.milliseconds, () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    notifyListeners();
  }

  void removeLayout(LayoutPrinter layout) {
    layoutSelected = null;

    _layoutPrinter = _layoutPrinter!.copyWith(sections: [..._layoutPrinter!.sections.where((s) => s.index != layout.index)]);
    _organizeLayouts();
    notifyListeners();
  }

  void removeLayoutPrinter(LayoutPrinter layout) {
    _layoutPrinter = _layoutPrinter!.copyWith(sections: _layoutPrinter!.sections.where((element) => element.index != layout.index).toList());
    _organizeLayouts();
    notifyListeners();
  }

  void ordening({required int oldIndex, required int newIndex}) {
    layoutSelected = null;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final layout = layouts[oldIndex];

    _layoutPrinter = _layoutPrinter!.copyWith(
      sections: _layoutPrinter!.sections
        ..removeAt(oldIndex)
        ..insert(newIndex, layout),
    );

    _organizeLayouts();
    notifyListeners();
  }

  void _organizeLayouts() {
    final newList = _layoutPrinter!.sections;
    final List<LayoutPrinter> sectionsIndexed = [];
    for (final layout in newList.indexed) {
      sectionsIndexed.add(layout.$2.copyWith(index: layout.$1));
    }

    _layoutPrinter = _layoutPrinter!.copyWith(sections: sectionsIndexed);
  }
}
