import 'package:flutter/material.dart';
import 'package:core/core.dart';

class EstablishmentPreferencesStore {
  static EstablishmentPreferencesStore? _instance;

  EstablishmentPreferencesStore._();
  static EstablishmentPreferencesStore get instance => _instance ??= EstablishmentPreferencesStore._();

  final ValueNotifier<EstablishmentPreferencesEntity?> _establishmentPreference = ValueNotifier(null);

  ValueNotifier<EstablishmentPreferencesEntity?> get listener => _establishmentPreference;

  EstablishmentPreferencesEntity get establishmentPreference {
    assert(_establishmentPreference.value != null, 'Establishment preference not initialized');
    return _establishmentPreference.value!;
  }

  void set(EstablishmentPreferencesEntity establishmentPreference) {
    _establishmentPreference.value = establishmentPreference;
  }
}
