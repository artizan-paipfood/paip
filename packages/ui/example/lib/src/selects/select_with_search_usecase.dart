import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:example/src/widget_base.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Select with search', type: UiSelect)
Widget buildSelectWithSearchUseCase(BuildContext context) {
  return const BaseWidget(
    title: 'SelectWith Search',
    child: _SelectWithSearchWidget(),
  );
}

const frameworks = {
  'nextjs': 'Next.js',
  'svelte': 'SvelteKit',
  'nuxtjs': 'Nuxt.js',
  'remix': 'Remix',
  'astro': 'Astro',
};

class _SelectWithSearchWidget extends StatefulWidget {
  const _SelectWithSearchWidget();

  @override
  State<_SelectWithSearchWidget> createState() => _SelectWithSearchWidgetState();
}

class _SelectWithSearchWidgetState extends State<_SelectWithSearchWidget> {
  var searchValue = '';

  Map<String, String> get filteredFrameworks => {
        for (final framework in frameworks.entries)
          if (framework.value.toLowerCase().contains(searchValue.toLowerCase())) framework.key: framework.value
      };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: UiSelect<String>.withSearch(
            placeholder: const Text('Select framework...'),
            onSearchChanged: (value) => setState(() => searchValue = value),
            searchPlaceholder: const Text('Search framework'),
            header: const Text('Select a framework'),
            options: [
              if (filteredFrameworks.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text('No framework found'),
                ),
              ...frameworks.entries.map(
                (framework) {
                  return Offstage(
                    offstage: !filteredFrameworks.containsKey(framework.key),
                    child: UiOption(
                      value: framework.key,
                      child: Text(framework.value),
                    ),
                  );
                },
              )
            ],
            selectedOptionBuilder: (context, value) => Text(frameworks[value]!),
          ),
        ),
      ],
    );
  }
}
