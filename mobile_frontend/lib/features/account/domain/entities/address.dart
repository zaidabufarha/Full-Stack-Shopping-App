import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';

@freezed
abstract class Address with _$Address {
  const factory Address({
    String? id,
    required String name,
    required String street,
    required String city,
    required String country,
    required String phone,
    required String zipCode,
    @Default(false) bool isDefault,
  }) = _Address;
}
