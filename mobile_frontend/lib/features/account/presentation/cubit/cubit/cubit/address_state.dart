part of 'address_cubit.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState.initial() = _Initial;
  const factory AddressState.loading() = _Loading;
  const factory AddressState.loaded(List<Address> addresses) = _Loaded;
  const factory AddressState.success(String message) = _Success;
  const factory AddressState.error(String message) = _Error;
}
