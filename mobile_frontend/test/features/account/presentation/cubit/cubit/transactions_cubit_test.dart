import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/use_cases/get_transactions.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/transactions_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetTransactions extends Mock implements GetTransactions {}

void main() {
  late MockGetTransactions mockGetTransactions;
  late TransactionsCubit transactionsCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetTransactions = MockGetTransactions();
    transactionsCubit = TransactionsCubit(mockGetTransactions);
  });

  tearDown(() {
    transactionsCubit.close();
  });

  test('initial state is TransactionsState.initial()', () {
    expect(transactionsCubit.state, const TransactionsState.initial());
  });

  group('attemptGetTransactions', () {
    blocTest<TransactionsCubit, TransactionsState>(
      'emits [loading, loaded] when getTransactions succeeds',
      build: () {
        when(() => mockGetTransactions.call())
            .thenAnswer((_) async => Right([testTransaction]));
        return transactionsCubit;
      },
      act: (cubit) => cubit.attemptGetTransactions(),
      expect: () => [
        const TransactionsState.loading(),
        TransactionsState.loaded([testTransaction]),
      ],
      verify: (_) {
        verify(() => mockGetTransactions.call()).called(1);
      },
    );

    blocTest<TransactionsCubit, TransactionsState>(
      'emits [loading, error] when getTransactions fails',
      build: () {
        when(() => mockGetTransactions.call())
            .thenAnswer((_) async => Left(DummyFailure('Fetch transactions failed')));
        return transactionsCubit;
      },
      act: (cubit) => cubit.attemptGetTransactions(),
      expect: () => [
        const TransactionsState.loading(),
        const TransactionsState.error('Fetch transactions failed'),
      ],
    );
  });
}
