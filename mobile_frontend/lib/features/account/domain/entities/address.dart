import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String? id;
  final String name;
  final String street;
  final String city;
  final String country;
  final String phone;
  final String zipCode;
  final bool isDefault;

  const Address({
    this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.country,
    required this.phone,
    required this.zipCode,
    this.isDefault = false,
  });

  Address copyWith({
    String? id,
    String? name,
    String? street,
    String? city,
    String? country,
    String? phone,
    String? zipCode,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      name: name ?? this.name,
      street: street ?? this.street,
      city: city ?? this.city,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      zipCode: zipCode ?? this.zipCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        street,
        city,
        country,
        phone,
        zipCode,
        isDefault,
      ];
}

