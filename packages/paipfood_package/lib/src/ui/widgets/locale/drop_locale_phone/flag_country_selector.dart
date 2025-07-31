import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class FlagCountrySelector extends StatefulWidget {
  final List<Countries>? countries;
  final String? initialPhoneCountryCode;
  final String? initialLocale;
  final String searchText;
  final double maxheight;
  final ValueChanged<Countries>? onCountryChanged;
  final bool enabled;
  final CrossAxisAlignment crossAxisAlignment;
  final TextEditingController? phoneCountryCodeController;

  FlagCountrySelector({
    super.key,
    this.countries,
    this.initialPhoneCountryCode,
    this.initialLocale,
    this.searchText = '',
    this.onCountryChanged,
    this.enabled = true,
    this.maxheight = 250,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.phoneCountryCodeController,
  }) {
    if (initialPhoneCountryCode != null && initialLocale != null) {
      throw FormatException('initialPhoneCountryCode and initialLocale cannot be null at the same time');
    }
  }

  @override
  State<FlagCountrySelector> createState() => _FlagCountrySelectorState();
}

class _FlagCountrySelectorState extends State<FlagCountrySelector> {
  late List<Countries> _countryList;
  late Countries _selectedCountry;
  late List<Countries> _filteredCountries;
  final MenuController _menuController = MenuController();
  late final String _localizedName = widget.initialLocale ?? 'en';

  @override
  void initState() {
    super.initState();
    _initializeCountries();
    if (widget.initialPhoneCountryCode != null) _setInitialCountryByPhoneCountryCode(widget.initialPhoneCountryCode!);
    if (widget.initialLocale != null) _setInitialCountryByLocale(widget.initialLocale!);
    _sortCountries();
  }

  Future<void> _initializeCountries() async {
    if (widget.initialPhoneCountryCode != null && widget.initialPhoneCountryCode!.isNotEmpty) {
      _countryList = Countries.countriesAllowOnboarding;
      await Future.delayed(500.milliseconds);
    }
    _countryList = widget.countries ?? Countries.countries;
    _filteredCountries = _countryList;
  }

  void _setInitialCountryByLocale(String locale) {
    _selectedCountry = _countryList.firstWhere(
      (country) => country.locale.toLowerCase() == locale.toLowerCase(),
      orElse: () => _countryList.first,
    );
    widget.phoneCountryCodeController?.text = _selectedCountry.dialCode;
    _filteredCountries = _countryList;
  }

  void _setInitialCountryByPhoneCountryCode(String phoneCountryCode) {
    String initialCode = phoneCountryCode;
    if (initialCode.startsWith('+')) {
      initialCode = initialCode.substring(1);
      _selectedCountry = _countryList.firstWhere(
        (country) => initialCode.startsWith(country.fullCountryCode),
        orElse: () => _countryList.first,
      );
    } else {
      _selectedCountry = _countryList.firstWhere(
        (country) => country.dialCode == initialCode,
        orElse: () => _countryList.first,
      );
    }
    widget.phoneCountryCodeController?.text = _selectedCountry.dialCode;
    _filteredCountries = _countryList;
  }

  void _sortCountries() {
    _filteredCountries.sort((a, b) => a.localizedName(_localizedName).compareTo(b.localizedName(_localizedName)));
  }

  List<Countries> _searchCountries(String query) {
    query = query.toLowerCase().trim();

    // Se a query está vazia, retorna todos os países
    if (query.isEmpty) {
      return _countryList;
    }

    // Verifica se a query contém apenas números (dial code)
    final bool isOnlyNumbers = RegExp(r'^[0-9]+$').hasMatch(query);

    // Verifica se a query contém números (pode ser dial code parcial)
    final bool containsNumbers = query.contains(RegExp(r'[0-9]'));

    final List<Countries> result = _countryList.where(
      (country) {
        final String countryName = country.localizedName(_localizedName).toLowerCase();
        final String dialCode = country.dialCode.toLowerCase();
        final String locale = country.locale.toLowerCase();

        // Se é apenas números, busca prioritariamente por dial code
        if (isOnlyNumbers) {
          return dialCode.contains(query);
        }

        // Se contém números, busca por dial code E nome/locale
        if (containsNumbers) {
          return dialCode.contains(query) || countryName.contains(query) || locale.contains(query);
        }

        // Se é apenas texto, busca por nome do país e locale
        return countryName.contains(query) || locale.contains(query);
      },
    ).toList()
      ..sort((a, b) {
        final String countryNameA = a.localizedName(_localizedName).toLowerCase();
        final String countryNameB = b.localizedName(_localizedName).toLowerCase();
        final String dialCodeA = a.dialCode.toLowerCase();
        final String dialCodeB = b.dialCode.toLowerCase();
        final String localeA = a.locale.toLowerCase();
        final String localeB = b.locale.toLowerCase();

        // Se é apenas números, prioriza match exato no dial code
        if (isOnlyNumbers) {
          final bool exactMatchA = dialCodeA == query;
          final bool exactMatchB = dialCodeB == query;

          if (exactMatchA && !exactMatchB) return -1;
          if (!exactMatchA && exactMatchB) return 1;

          // Se ambos são match exato ou ambos não são, ordena por distância
          final int distanceA = levenshteinDistance(dialCodeA, query);
          final int distanceB = levenshteinDistance(dialCodeB, query);
          return distanceA.compareTo(distanceB);
        }

        // Se contém números, prioriza match no dial code
        if (containsNumbers) {
          final bool dialMatchA = dialCodeA.contains(query);
          final bool dialMatchB = dialCodeB.contains(query);

          if (dialMatchA && !dialMatchB) return -1;
          if (!dialMatchA && dialMatchB) return 1;
        }

        // Calcula a menor distância entre nome, locale e dial code
        final int distanceA = min(
          levenshteinDistance(countryNameA, query),
          min(
            levenshteinDistance(localeA, query),
            levenshteinDistance(dialCodeA, query),
          ),
        );

        final int distanceB = min(
          levenshteinDistance(countryNameB, query),
          min(
            levenshteinDistance(localeB, query),
            levenshteinDistance(dialCodeB, query),
          ),
        );

        return distanceA.compareTo(distanceB);
      });

    return result;
  }

  Future<void> _changeCountry() async {
    _menuController.open();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _menuController,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(context.color.primaryBG),
        surfaceTintColor: WidgetStatePropertyAll<Color>(context.color.primaryBG),
      ),
      menuChildren: [
        _buildCountryList(),
      ],
      child: _buildSelectedCountry(),
    );
  }

  Widget _buildCountryList() {
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.color.primaryBG,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SizedBox(
          height: max(min(_filteredCountries.length * 70 + 50, widget.maxheight), 100),
          width: 125,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSearchField(),
              ),
              Expanded(child: _buildCountryListView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return CwTextFormFild(
      autofocus: true,
      suffixIcon: const Icon(PIcons.strokeRoundedSearch01),
      onChanged: (value) async {
        final List<Countries> searchedCountries = _searchCountries(value);
        setState(() {
          _filteredCountries = searchedCountries;
        });
      },
    );
  }

  Widget _buildCountryListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        final isSelected = country.locale == _selectedCountry.locale;

        return Material(
          color: Colors.transparent,
          child: ListTile(
            dense: true,
            selected: isSelected,
            selectedTileColor: context.color.primaryColor.withOpacity(0.1),
            leading: Image.asset(
              'assets/flags/${country.locale.toUpperCase()}.png',
              package: 'paipfood_package',
              width: 32,
              height: 24,
              fit: BoxFit.cover,
            ),
            title: Text(
              country.localizedName(_localizedName),
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? context.color.primaryColor : null,
              ),
            ),
            trailing: Text(
              '+${country.dialCode}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? context.color.primaryColor : Colors.grey[600],
              ),
            ),
            onTap: () {
              setState(() {
                _selectedCountry = country;
                widget.onCountryChanged?.call(_selectedCountry);
              });
              _menuController.close();
            },
          ),
        );
      },
    );
  }

  Widget _buildSelectedCountry() {
    return SizedBox(
      child: InkWell(
        onTap: widget.enabled ? _changeCountry : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Image.asset(
              'assets/flags/${_selectedCountry.locale.toUpperCase()}.png',
              package: 'paipfood_package',
              width: 32,
            ),
            PSize.i.sizedBoxW,
            FittedBox(
              child: Text('+${_selectedCountry.dialCode}'),
            ),
          ],
        ),
      ),
    );
  }
}
