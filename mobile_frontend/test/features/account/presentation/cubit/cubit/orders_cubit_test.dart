import 'package:big_cart/features/account/domain/use_cases/get_orders.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/orders_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetOrders extends Mock implements GetOrders {}

void main() {
  late MockGetOrders mockGetOrders;
  late OrdersCubit ordersCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetOrders = MockGetOrders();
    ordersCubit = OrdersCubit(mockGetOrders);
  });

  tearDown(() {
    ordersCubit.close();
  });

  test('initial state is OrdersState.initial()', () {
    expect(ordersCubit.state, const OrdersState.initial());
  });

  group('attemptGetOrders', () {
    blocTest<OrdersCubit, OrdersState>(
      'emits [loading, loadedList] when getOrders succeeds',
      build: () {
        when(
          () => mockGetOrders.call(),
        ).thenAnswer((_) async => Right([testOrder]));
        return ordersCubit;
      },
      act: (cubit) => cubit.attemptGetOrders(),
      expect: () => [
        const OrdersState.loading(),
        OrdersState.loadedList([testOrder]),
      ],
      verify: (_) {
        verify(() => mockGetOrders.call()).called(1);
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [loading, error] when getOrders fails',
      build: () {
        when(
          () => mockGetOrders.call(),
        ).thenAnswer((_) async => Left(DummyFailure('Fetch orders failed')));
        return ordersCubit;
      },
      act: (cubit) => cubit.attemptGetOrders(),
      expect: () => [
        const OrdersState.loading(),
        const OrdersState.error('Fetch orders failed'),
      ],
    );
  });
}
