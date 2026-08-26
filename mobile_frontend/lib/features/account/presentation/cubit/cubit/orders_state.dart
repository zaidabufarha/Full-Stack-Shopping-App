part of 'orders_cubit.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;
  const factory OrdersState.loading() = _Loading;
  const factory OrdersState.loadedOrder(Order order) = _LoadedOrder;
  const factory OrdersState.loadedList(List<Order> orders) = _LoadedList;
  const factory OrdersState.success(String message) = _Success;
  const factory OrdersState.error(String message) = _Error;
}
