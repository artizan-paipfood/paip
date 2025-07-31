// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:book/src/buttons/buttons_usecase.dart' as _i2;
import 'package:book/src/empty_state/exmpty_state_usecase.dart' as _i3;
import 'package:book/src/form/form_usecase.dart' as _i4;
import 'package:book/src/search/search_field_usecase%20copy.dart' as _i5;
import 'package:book/src/selects/select_form_usecase.dart' as _i7;
import 'package:book/src/selects/select_multiple_usecase.dart' as _i8;
import 'package:book/src/selects/select_scrollable_usecase.dart' as _i9;
import 'package:book/src/selects/select_usecase.dart' as _i6;
import 'package:book/src/selects/select_with_search_usecase.dart' as _i10;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookComponent(
        name: 'UiButton',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Destructive',
            builder: _i2.destructiveButton,
          ),
          _i1.WidgetbookUseCase(
            name: 'Ghost',
            builder: _i2.ghostButton,
          ),
          _i1.WidgetbookUseCase(
            name: 'Icon',
            builder: _i2.iconButton,
          ),
          _i1.WidgetbookUseCase(
            name: 'Link',
            builder: _i2.linkButton,
          ),
          _i1.WidgetbookUseCase(
            name: 'Outline',
            builder: _i2.outlineButton,
          ),
          _i1.WidgetbookUseCase(
            name: 'Primary',
            builder: _i2.primaryButton,
          ),
          _i1.WidgetbookUseCase(
            name: 'Raw',
            builder: _i2.rawButton,
          ),
          _i1.WidgetbookUseCase(
            name: 'Secondary',
            builder: _i2.secondaryButton,
          ),
        ],
      ),
      _i1.WidgetbookComponent(
        name: 'UiEmptyState',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'InTable',
            builder: _i3.emptyStateInTable,
          ),
          _i1.WidgetbookUseCase(
            name: 'Minimal',
            builder: _i3.emptyStateMinimal,
          ),
          _i1.WidgetbookUseCase(
            name: 'Non Table',
            builder: _i3.emptyStateInList,
          ),
          _i1.WidgetbookUseCase(
            name: 'Small',
            builder: _i3.emptyStateInCard,
          ),
        ],
      ),
      _i1.WidgetbookComponent(
        name: 'UiSelect',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Form',
            builder: _i4.buildFormUseCase,
          ),
          _i1.WidgetbookUseCase(
            name: 'Search field',
            builder: _i5.buildSearchAddressUseCase,
          ),
          _i1.WidgetbookUseCase(
            name: 'Select',
            builder: _i6.buildSelectUseCase,
          ),
          _i1.WidgetbookUseCase(
            name: 'Select form',
            builder: _i7.buildSelectFormFormUseCase,
          ),
          _i1.WidgetbookUseCase(
            name: 'Select multiple',
            builder: _i8.buildSelectMultipleUseCase,
          ),
          _i1.WidgetbookUseCase(
            name: 'Select scrollable',
            builder: _i9.buildSelectScrollableUseCase,
          ),
          _i1.WidgetbookUseCase(
            name: 'Select with search',
            builder: _i10.buildSelectWithSearchUseCase,
          ),
        ],
      ),
    ],
  )
];
