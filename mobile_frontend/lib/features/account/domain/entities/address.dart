class Address {
  String? id;
  String name;
  String address;
  String city;
  String country;
  String number;
  String zip;
  bool isDefault;
  Address({
    this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    required this.number,
    required this.zip,
    this.isDefault = false,
  });
}
