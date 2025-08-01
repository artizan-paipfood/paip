enum UserNavigationMode {
  loginPickup,
  loginDelivery,
  editName,
  editPhone,
  editAddress;

  bool get isLoginPickuop => this == UserNavigationMode.loginPickup;
  bool get isLoginDelivery => this == UserNavigationMode.loginDelivery;
  bool get isEditName => this == UserNavigationMode.editName;
  bool get isEditPhone => this == UserNavigationMode.editPhone;
  bool get isEditAddress => this == UserNavigationMode.editAddress;

  static UserNavigationMode fromMap(String value) => UserNavigationMode.values.firstWhere((element) => element.name == value);
}
