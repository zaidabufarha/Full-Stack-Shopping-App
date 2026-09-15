import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressModel {
  final String? id;
  final String name;
  final String street;
  final String city;
  final String country;
  final String phone;
  final String zipCode;
  final bool isDefault;

  const AddressModel({
    this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.country,
    required this.phone,
    required this.zipCode,
    this.isDefault = false,
  });

  factory AddressModel.fromEntity(Address entity) => AddressModel(
    id: entity.id,
    name: entity.name,
    street: entity.street,
    city: entity.city,
    country: entity.country,
    phone: entity.phone,
    zipCode: entity.zipCode,
    isDefault: entity.isDefault,
  );

  Address toEntity() => Address(
    id: id,
    name: name,
    street: street,
    city: city,
    country: country,
    phone: phone,
    zipCode: zipCode,
    isDefault: isDefault,
  );

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
