import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/use%20cases/add_to_cart.dart';
import 'package:big_cart/features/buy/domain/use%20cases/check_out.dart';
import 'package:big_cart/features/buy/domain/use%20cases/get_cart_items.dart';
import 'package:big_cart/features/buy/domain/use%20cases/remove_from_cart.dart';
import 'package:big_cart/features/buy/domain/use%20cases/update_quantity.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart' hide Order;

part 'cart_state.dart';
part 'cart_cubit.freezed.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit(
    this.addToCart,
    this.checkOut,
    this.getCartItems,
    this.removeFromCart,
    this.updateQuantity,
  ) : super(CartState.initial());
  GetCartItems getCartItems;
  AddToCart addToCart;
  UpdateQuantity updateQuantity;
  RemoveFromCart removeFromCart;
  CheckOut checkOut;

  void attemptGetCartItems({bool isFavorites = false}) async {
    final result = await getCartItems.call(isFavorites: isFavorites);
    result.fold(
      (failure) {
        emit(CartState.error(failure.message));
      },
      (list) {
        emit(CartState.loaded(list));
      },
    );
  }

  void attemptAddToCart(CartItem item) async {
    final result = await addToCart.call(item);
    result.fold(
      (failure) {
        emit(CartState.error(failure.message));
      },
      (unit) {
        emit(CartState.success('Added to cart'));
      },
    );
  }

  void attemptUpdateQuantity(CartItem item, int quantity) async {
    final result = await updateQuantity.call(item, quantity);
    result.fold(
      (failure) {
        emit(CartState.error(failure.message));
      },
      (unit) {
        emit(
          CartState.success('Changed quantity to $quantity'),
        ); // probably wont show this on a snackbar because it'd be repetitive
      },
    );
  }

  void attemptRemoveFromCart(CartItem item) async {
    emit(CartState.loading());
    final result = await removeFromCart.call(item);
    result.fold(
      (failure) {
        emit(CartState.error(failure.message));
      },
      (unit) {
        emit(CartState.success('Removed from cart'));
      },
    );
  }

  void attemptCheckOut(Order order) async {
    final result = await checkOut.call(order);
    result.fold(
      (failure) {
        emit(CartState.error(failure.message));
      },
      (unit) {
        emit(CartState.success('Checkout successful')); //idk what to write here
      },
    );
  }
}
