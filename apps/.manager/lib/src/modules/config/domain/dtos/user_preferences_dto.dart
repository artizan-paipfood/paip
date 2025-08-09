import 'package:core/core.dart';

// coverage:ignore-file
enum HandMode {
  leftHanded,
  rightHanded;
}

class UserPreferencesDto {
  final HandMode handMode;
  final bool isPhoneRequiredForGuestClient;
  final bool isPrimaryTerminal;

  UserPreferencesDto({
    required this.handMode,
    required this.isPhoneRequiredForGuestClient,
    required this.isPrimaryTerminal,
  });
  static const String box = 'paip_user_preferences';

  UserPreferencesDto copyWith({
    HandMode? handMode,
    bool? isPhoneRequiredForGuestClient,
    bool? isPrimaryTerminal,
    int? initialOrderCount,
    DateTime? resetOrderAt,
    ResetOrderNumberPeriod? resetOrderNumber,
  }) {
    return UserPreferencesDto(
      handMode: handMode ?? this.handMode,
      isPhoneRequiredForGuestClient: isPhoneRequiredForGuestClient ?? this.isPhoneRequiredForGuestClient,
      isPrimaryTerminal: isPrimaryTerminal ?? this.isPrimaryTerminal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hand_mode': handMode.name,
      'is_phone_required_for_guest_client': isPhoneRequiredForGuestClient,
      'is_primary_terminal': isPrimaryTerminal,
    };
  }

  factory UserPreferencesDto.fromMap(Map json) {
    return UserPreferencesDto(
      handMode: HandMode.values.byName(json['hand_mode']),
      isPhoneRequiredForGuestClient: json['is_phone_required_for_guest_client'] ?? true,
      isPrimaryTerminal: json['is_primary_terminal'] ?? true,
    );
  }
  bool get isNotPrimaryTerminal => !isPrimaryTerminal;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserPreferencesDto && other.handMode == handMode && other.isPhoneRequiredForGuestClient == isPhoneRequiredForGuestClient && other.isPrimaryTerminal == isPrimaryTerminal;
  }

  @override
  int get hashCode => handMode.hashCode ^ isPhoneRequiredForGuestClient.hashCode ^ isPrimaryTerminal.hashCode;
}
