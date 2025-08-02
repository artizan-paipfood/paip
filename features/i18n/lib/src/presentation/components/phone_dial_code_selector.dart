import 'package:flutter/material.dart';
import 'package:i18n/src/domain/models/countries.dart';
import 'package:ui/ui.dart';

class PhoneDialCodeSelector extends StatefulWidget {
  final List<Countries>? countries;
  final String? initialPhoneCountryCode;
  final String? initialLocale;
  final double maxHeight;
  final bool enabled;
  final CrossAxisAlignment crossAxisAlignment;
  final TextEditingController? phoneCountryCodeController;
  final ValueChanged<Countries>? onCountryChanged;
  final double? heightButton;

  const PhoneDialCodeSelector({
    super.key,
    this.countries,
    this.initialPhoneCountryCode,
    this.initialLocale,
    this.maxHeight = 250,
    this.enabled = true,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.phoneCountryCodeController,
    this.onCountryChanged,
    this.heightButton,
  });

  @override
  State<PhoneDialCodeSelector> createState() => _PhoneDialCodeSelectorState();
}

class _PhoneDialCodeSelectorState extends State<PhoneDialCodeSelector> {
  List<Countries> _countries = [];
  Countries? _selectedCountry;
  List<Countries> _filteredCountries = [];
  bool _isInitialized = false;
  final MenuController _menuController = MenuController();
  final ScrollController _scrollController = ScrollController();
  late final String _localizedName;

  @override
  void initState() {
    super.initState();
    _localizedName = widget.initialLocale ?? 'en';
    _initializeSelector();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeSelector() async {
    List<Countries> countries;

    if (widget.initialPhoneCountryCode != null && widget.initialPhoneCountryCode!.isNotEmpty) {
      countries = Countries.countriesAllowOnboarding;
    } else {
      countries = widget.countries ?? Countries.countries;
    }

    // Ordena países
    countries.sort((a, b) => a.localizedName(_localizedName).compareTo(b.localizedName(_localizedName)));

    // Define país inicial
    Countries selectedCountry;
    if (widget.initialLocale != null) {
      selectedCountry = countries.firstWhere(
        (country) => country.locale.toLowerCase() == widget.initialLocale!.toLowerCase(),
        orElse: () => countries.first,
      );
    } else if (widget.initialPhoneCountryCode != null) {
      String code = widget.initialPhoneCountryCode!;
      if (code.startsWith('+')) code = code.substring(1);
      selectedCountry = countries.firstWhere(
        (country) => code.startsWith(country.dialCode),
        orElse: () => countries.first,
      );
    } else {
      selectedCountry = countries.first;
    }

    widget.phoneCountryCodeController?.text = selectedCountry.dialCode;

    setState(() {
      _countries = countries;
      _selectedCountry = selectedCountry;
      _filteredCountries = countries;
      _isInitialized = true;
    });
  }

  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _filteredCountries = _countries;
      });
      return;
    }

    value = value.toLowerCase();
    final filtered = _countries.where((country) {
      final countryName = country.localizedName(_localizedName).toLowerCase();
      final dialCode = country.dialCode.toLowerCase();
      return countryName.contains(value) || dialCode.contains(value);
    }).toList();

    setState(() {
      _filteredCountries = filtered;
    });
  }

  Future<void> _changeCountry() async {
    _menuController.open();
    setState(() {});
  }

  void _selectCountry(Countries country) {
    setState(() {
      _selectedCountry = country;
    });
    widget.phoneCountryCodeController?.text = country.dialCode;
    widget.onCountryChanged?.call(country);
    _menuController.close();
  }

  Color get _selectedColor => context.artColorScheme.primary;

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _selectedCountry == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MenuAnchor(
      controller: _menuController,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.surface),
        surfaceTintColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.surface),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignmentOffset: const Offset(0, 10),
      menuChildren: [
        _buildCountryList(context),
      ],
      child: _buildSelectedCountry(),
    );
  }

  Widget _buildCountryList(BuildContext context) {
    // Calcula altura dinâmica baseada no número de países
    final int itemHeight = 45; // altura de cada item
    final int searchFieldHeight = 45; // altura do campo de busca
    final int padding = 0; // padding total
    final int maxHeight = widget.maxHeight.toInt();

    final int calculatedHeight = (_filteredCountries.length * itemHeight) + searchFieldHeight + padding;
    final int dynamicHeight = calculatedHeight > maxHeight ? maxHeight : calculatedHeight;
    final double height = dynamicHeight < 85 ? 65 : dynamicHeight.toDouble();
    final Size size = MediaQuery.of(context).size;
    final double finalHeight = size.height * 0.6 < height ? size.height * 0.6 : height;
    return Material(
      child: SizedBox(
        height: finalHeight,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget _buildSearchField() {
    return ArtTextFormField(
      autofocus: true,
      onChanged: _onSearchChanged,
      trailing: PaipIcon(PaipIcons.searchLinear, size: 18, color: context.artColorScheme.primary),
    );
  }

  Widget _buildCountryListView() {
    return ListView.builder(
      controller: _scrollController,
      primary: false,
      padding: EdgeInsets.zero,
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        final isSelected = _selectedCountry?.locale == country.locale;

        return ListTile(
          dense: true,
          selected: isSelected,
          selectedTileColor: _selectedColor.withValues(alpha: .1),
          leading: Image.asset(
            'assets/flags/${country.locale.toUpperCase()}.png',
            package: 'paipfood_package',
            width: 32,
            height: 24,
            fit: BoxFit.cover,
          ),
          title: Text(
            '+${country.dialCode}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? _selectedColor : null,
            ),
          ),
          onTap: () => _selectCountry(country),
        );
      },
    );
  }

  Widget _buildSelectedCountry() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.enabled ? _changeCountry : null,
        borderRadius: BorderRadius.circular(2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: widget.heightButton ?? 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: widget.crossAxisAlignment,
              children: [
                Image.asset(
                  'assets/flags/${_selectedCountry!.locale.toUpperCase()}.png',
                  package: 'i18n',
                  width: 32,
                ),
                const SizedBox(width: 8),
                FittedBox(
                  child: Text('+${_selectedCountry!.dialCode}'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
