// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:paipfood_package/paipfood_package.dart';
// import 'package:ui/ui.dart';
// import 'package:example/src/search/search_field.dart';
// import 'package:example/src/widget_base.dart';
// import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// @widgetbook.UseCase(name: 'Search field', type: UiSelect)
// Widget buildSearchFieldUseCase(BuildContext context) {
//   return const BaseWidget(
//     title: 'SelectWith Search',
//     child: SearchFieldWidgetUsecase(),
//   );
// }

// class SearchFieldWidgetUsecase extends StatefulWidget {
//   const SearchFieldWidgetUsecase({super.key});

//   @override
//   State<SearchFieldWidgetUsecase> createState() => _SearchFieldWidgetUsecaseState();
// }

// class _SearchFieldWidgetUsecaseState extends State<SearchFieldWidgetUsecase> {
//   List<AddressAutoCompleteResponse> _address = [];
//   AddressAutoCompleteResponse? _selectedAddress;
//   final SearchAddressRepository _repository = SearchAddressRepository(http: ClientDio(baseOptions: HttpUtils.api()));

//   Timer? _debounce;

//   void _onFiltering(String value) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 700), () async {
//       if (value.isEmpty || value.length < 3) {
//         _address = [];
//         setState(() {});
//         return;
//       }
//       _address = await _repository.autoComplete(query: value, country: 'br');
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return UiSearchField<AddressAutoCompleteResponse>(
//       selectedTextBuilder: (value) => _selectedAddress?.description ?? '',
//       options: _address,
//       onSelected: (value) => _selectedAddress = value,
//       label: const Text("Search Address"),
//       onFiltering: (value) {
//         if (value.isEmpty) return _address = _address;
//         _onFiltering(value);
//         return _address;
//       },
//       optionBuilder: (context, value) => Row(
//         children: [
//           const Icon(
//             PIcons.strokeRoundedLocation01,
//           ),
//           const SizedBox(width: 8),
//           Expanded(child: Text(value.description)),
//         ],
//       ),
//     );
//   }
// }
