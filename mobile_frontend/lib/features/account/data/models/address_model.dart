import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Address {
  AddressModel({
    super.id,
    required super.name,
    required super.address,
    required super.city,
    required super.country,
    required super.number,
    required super.zip,
    super.isDefault = false,
  });

  factory AddressModel.fromEntity(Address entity) => AddressModel(
        id: entity.id,
        name: entity.name,
        address: entity.address,
        city: entity.city,
        country: entity.country,
        number: entity.number,
        zip: entity.zip,
        isDefault: entity.isDefault,
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('street') && !mapped.containsKey('address')) {
      mapped['address'] = mapped['street'];
    }
    if (mapped.containsKey('zip_code') && !mapped.containsKey('zip')) {
      mapped['zip'] = mapped['zip_code'];
    }
    if (mapped.containsKey('phone') && !mapped.containsKey('number')) {
      mapped['number'] = mapped['phone'];
    }
    if (mapped['id'] != null) {
      mapped['id'] = mapped['id'].toString();
    }
    return _$AddressModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
