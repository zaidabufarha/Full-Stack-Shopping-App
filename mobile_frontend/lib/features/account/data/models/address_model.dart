import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressModel extends Address {
  AddressModel({
    super.id,
    required super.name,
    required super.street,
    required super.city,
    required super.country,
    required super.phone,
    required super.zipCode,
    super.isDefault = false,
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

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
