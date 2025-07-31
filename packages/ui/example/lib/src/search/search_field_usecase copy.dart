import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:example/src/search/search_field.dart';
import 'package:example/src/widget_base.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Search field', type: UiSelect)
Widget buildSearchAddressUseCase(BuildContext context) {
  return const BaseWidget(
    title: 'SelectWith Search',
    child: SearchFieldWidgetUsecase(),
  );
}

class SearchFieldWidgetUsecase extends StatefulWidget {
  const SearchFieldWidgetUsecase({super.key});

  @override
  State<SearchFieldWidgetUsecase> createState() => _SearchFieldWidgetUsecaseState();
}

class _SearchFieldWidgetUsecaseState extends State<SearchFieldWidgetUsecase> {
  List<String> _fruits = fruits;

  @override
  Widget build(BuildContext context) {
    return UiSearchField<String>(
      selectedTextBuilder: (value) => value,
      options: _fruits,
      onFiltering: (value) {
        if (value.isEmpty) return _fruits = fruits;
        return _fruits = fruits.where((f) => f.toLowerCase().contains(value.toLowerCase())).toList();
      },
      optionBuilder: (context, value) => Row(
        children: [
          const Icon(
            LucideIcons.aArrowDown,
          ),
          const SizedBox(width: 8),
          UiButton(
            onTap: () {},
            child: const Text('clique aqui '),
          ),
          Text(value),
        ],
      ),
    );
  }
}

const fruits = [
  'Banana',
  'Morango',
  'Maçã',
  'Pera',
  'Uva',
  'Laranja',
  'Abacaxi',
  'Manga',
  'Melancia',
  'Melão',
  'Kiwi',
  'Mamão',
  'Caju',
  'Acerola',
  'Amora',
  'Cereja',
  'Framboesa',
  'Goiaba',
  'Jabuticaba',
  'Lichia',
  'Maracujá',
  'Nectarina',
  'Pêssego',
  'Pitanga',
  'Romã',
  'Tangerina',
  'Ameixa',
  'Carambola',
  'Figo',
  'Graviola',
  'Jaca',
  'Laranja Lima',
  'Laranja Pera',
  'Laranja Bahia',
  'Limão',
  'Maçã Verde',
  'Mexerica',
  'Pinha',
  'Pitaia',
  'Tamarindo',
  'Uva Verde',
  'Uva Roxa',
  'Abacate',
  'Açaí',
  'Cabeludinha',
  'Cambuci',
  'Cupuaçu',
  'Jenipapo',
  'Mangaba',
  'Pequi'
];
