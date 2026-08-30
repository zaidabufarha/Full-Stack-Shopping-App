import 'package:big_cart/features/buy/domain/use%20cases/add_to_cart.dart';
import 'package:big_cart/features/buy/domain/use%20cases/check_out.dart';
import 'package:big_cart/features/buy/domain/use%20cases/get_cart_items.dart';
import 'package:big_cart/features/buy/domain/use%20cases/remove_from_cart.dart';
import 'package:big_cart/features/buy/domain/use%20cases/update_quantity.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetCartItems extends Mock implements GetCartItems {}

class MockAddToCart extends Mock implements AddToCart {}

class MockUpdateQuantity extends Mock implements UpdateQuantity {}

class MockRemoveFromCart extends Mock implements RemoveFromCart {}

class MockCheckOut extends Mock implements CheckOut {}

void main() {
  late MockGetCartItems mockGetCartItems;
  late MockAddToCart mockAddToCart;
  late MockUpdateQuantity mockUpdateQuantity;
  late MockRemoveFromCart mockRemoveFromCart;
  late MockCheckOut mockCheckOut;
  late CartCubit cartCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetCartItems = MockGetCartItems();
    mockAddToCart = MockAddToCart();
    mockUpdateQuantity = MockUpdateQuantity();
    mockRemoveFromCart = MockRemoveFromCart();
    mockCheckOut = MockCheckOut();

    cartCubit = CartCubit(
      mockAddToCart,
      mockCheckOut,
      mockGetCartItems,
      mockRemoveFromCart,
      mockUpdateQuantity,
    );
  });

  tearDown(() {
    cartCubit.close();
  });

  test('initial state is CartState.initial()', () {
    expect(cartCubit.state, const CartState.initial());
  });

  group('attemptGetCartItems', () {
    blocTest<CartCubit, CartState>(
      'emits [CartState.loaded(list)] on success without emitting loading',
      build: () {
        when(
          () => mockGetCartItems.call(isFavorites: any(named: 'isFavorites')),
        ).thenAnswer((_) async => Right([testCartItem]));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptGetCartItems(isFavorites: false),
      expect: () => [
        CartState.loaded([testCartItem]),
      ],
      verify: (_) {
        verify(() => mockGetCartItems.call(isFavorites: false)).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [CartState.error(message)] on failure without emitting loading',
      build: () {
        when(
          () => mockGetCartItems.call(isFavorites: any(named: 'isFavorites')),
        ).thenAnswer(
          (_) async => Left(DummyFailure('Failed to load cart items')),
        );
        return cartCubit;
      },
      act: (cubit) => cubit.attemptGetCartItems(isFavorites: true),
      expect: () => [const CartState.error('Failed to load cart items')],
    );
  });

  group('attemptAddToCart', () {
    blocTest<CartCubit, CartState>(
      'emits [CartState.success("Added to cart")] on success without emitting loading',
      build: () {
        when(
          () => mockAddToCart.call(any()),
        ).thenAnswer((_) async => const Right(unit));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptAddToCart(testCartItem),
      expect: () => [const CartState.success('Added to cart')],
      verify: (_) {
        verify(() => mockAddToCart.call(testCartItem)).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [CartState.error(message)] on failure without emitting loading',
      build: () {
        when(
          () => mockAddToCart.call(any()),
        ).thenAnswer((_) async => Left(DummyFailure('Could not add to cart')));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptAddToCart(testCartItem),
      expect: () => [const CartState.error('Could not add to cart')],
    );
  });

  group('attemptUpdateQuantity', () {
    blocTest<CartCubit, CartState>(
      'emits [CartState.success("Changed quantity to 5")] on success without emitting loading',
      build: () {
        when(
          () => mockUpdateQuantity.call(any(), any()),
        ).thenAnswer((_) async => const Right(unit));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptUpdateQuantity(testCartItem, 5),
      expect: () => [const CartState.success('Changed quantity to 5')],
      verify: (_) {
        verify(() => mockUpdateQuantity.call(testCartItem, 5)).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [CartState.error(message)] on failure without emitting loading',
      build: () {
        when(() => mockUpdateQuantity.call(any(), any())).thenAnswer(
          (_) async => Left(DummyFailure('Failed to update quantity')),
        );
        return cartCubit;
      },
      act: (cubit) => cubit.attemptUpdateQuantity(testCartItem, 0),
      expect: () => [const CartState.error('Failed to update quantity')],
    );
  });

  group('attemptRemoveFromCart', () {
    blocTest<CartCubit, CartState>(
      'emits [loading, success] on success',
      build: () {
        when(
          () => mockRemoveFromCart.call(any()),
        ).thenAnswer((_) async => const Right(unit));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptRemoveFromCart(testCartItem),
      expect: () => [
        const CartState.loading(),
        const CartState.success('Removed from cart'),
      ],
      verify: (_) {
        verify(() => mockRemoveFromCart.call(testCartItem)).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, error] on failure',
      build: () {
        when(
          () => mockRemoveFromCart.call(any()),
        ).thenAnswer((_) async => Left(DummyFailure('Remove failed')));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptRemoveFromCart(testCartItem),
      expect: () => [
        const CartState.loading(),
        const CartState.error('Remove failed'),
      ],
    );
  });

  group('attemptCheckOut', () {
    blocTest<CartCubit, CartState>(
      'emits [CartState.success("Checkout successful")] on success without emitting loading',
      build: () {
        when(
          () => mockCheckOut.call(any()),
        ).thenAnswer((_) async => const Right(unit));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptCheckOut(testOrder),
      expect: () => [const CartState.success('Checkout successful')],
      verify: (_) {
        verify(() => mockCheckOut.call(testOrder)).called(1);
      },
    );

    blocTest<CartCubit, CartState>(
      'emits [CartState.error(message)] on failure without emitting loading',
      build: () {
        when(
          () => mockCheckOut.call(any()),
        ).thenAnswer((_) async => Left(DummyFailure('Payment declined')));
        return cartCubit;
      },
      act: (cubit) => cubit.attemptCheckOut(testOrder),
      expect: () => [const CartState.error('Payment declined')],
    );
  });
}
