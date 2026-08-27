class Address {
  String? id;
  String name;
  String street;
  String city;
  String country;
  String phone;
  String zipCode;
  bool isDefault;

  Address({
    this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.country,
    required this.phone,
    required this.zipCode,
    this.isDefault = false,
  });
}
