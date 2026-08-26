part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.loaded(List<CartItem> products) = _Loaded;
  const factory CartState.success(String message) = _Success;
  const factory CartState.error(String message) = _Error;
}
