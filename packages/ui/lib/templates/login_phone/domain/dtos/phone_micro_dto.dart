class PhoneMicroDto {
  final String phone;
  final String countryCode;
  final String verifyCode;
  PhoneMicroDto({
    this.phone = '',
    this.countryCode = '',
    this.verifyCode = '',
  });

  PhoneMicroDto copyWith({
    String? phone,
    String? countryCode,
    String? verifyCode,
  }) {
    return PhoneMicroDto(
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      verifyCode: verifyCode ?? this.verifyCode,
    );
  }
}
