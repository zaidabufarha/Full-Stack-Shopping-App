import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/use_cases/add_credit_card.dart';
import 'package:big_cart/features/account/domain/use_cases/get_credit_cards.dart';
import 'package:big_cart/features/account/domain/use_cases/set_default_credit_card.dart';
import 'package:big_cart/features/account/domain/use_cases/update_credit_card.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cards_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockAddCreditCard extends Mock implements AddCreditCard {}
class MockGetCreditCards extends Mock implements GetCreditCards {}
class MockUpdateCreditCard extends Mock implements UpdateCreditCard {}
class MockSetDefaultCreditCard extends Mock implements SetDefaultCreditCard {}

void main() {
  late MockAddCreditCard mockAddCreditCard;
  late MockGetCreditCards mockGetCreditCards;
  late MockUpdateCreditCard mockUpdateCreditCard;
  late MockSetDefaultCreditCard mockSetDefaultCreditCard;
  late CardsCubit cardsCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockAddCreditCard = MockAddCreditCard();
    mockGetCreditCards = MockGetCreditCards();
    mockUpdateCreditCard = MockUpdateCreditCard();
    mockSetDefaultCreditCard = MockSetDefaultCreditCard();

    cardsCubit = CardsCubit(
      mockAddCreditCard,
      mockGetCreditCards,
      mockUpdateCreditCard,
      mockSetDefaultCreditCard,
    );
  });

  tearDown(() {
    cardsCubit.close();
  });

  test('initial state is CardsState.initial()', () {
    expect(cardsCubit.state, const CardsState.initial());
  });

  group('attemptAddCreditCard', () {
    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.success("Added successfully")] on success without loading',
      build: () {
        when(
          () => mockAddCreditCard.call(
            name: any(named: 'name'),
            cardNumber: any(named: 'cardNumber'),
            expiration: any(named: 'expiration'),
            saveCard: any(named: 'saveCard'),
            processor: any(named: 'processor'),
          ),
        ).thenAnswer((_) async => const Right(unit));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptAddCreditCard(
        name: 'John Doe',
        cardNumber: '4242424242424242',
        expiration: '12/28',
        saveCard: true,
        processor: PaymentProcessor.visa,
      ),
      expect: () => [const CardsState.success('Added successfully')],
      verify: (_) {
        verify(
          () => mockAddCreditCard.call(
            name: 'John Doe',
            cardNumber: '4242424242424242',
            expiration: '12/28',
            saveCard: true,
            processor: PaymentProcessor.visa,
          ),
        ).called(1);
      },
    );

    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.error(message)] on failure without loading',
      build: () {
        when(
          () => mockAddCreditCard.call(
            name: any(named: 'name'),
            cardNumber: any(named: 'cardNumber'),
            expiration: any(named: 'expiration'),
            saveCard: any(named: 'saveCard'),
            processor: any(named: 'processor'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Invalid card')));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptAddCreditCard(
        name: 'John Doe',
        cardNumber: 'invalid',
        expiration: '12/28',
        saveCard: false,
        processor: PaymentProcessor.mastercard,
      ),
      expect: () => [const CardsState.error('Invalid card')],
    );
  });

  group('attemptUpdateCreditCard', () {
    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.success("Updated successfully")] on success without loading',
      build: () {
        when(() => mockUpdateCreditCard.call(any()))
            .thenAnswer((_) async => const Right(unit));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptUpdateCreditCard(card: testCreditCard),
      expect: () => [const CardsState.success('Updated successfully')],
      verify: (_) {
        verify(() => mockUpdateCreditCard.call(testCreditCard)).called(1);
      },
    );

    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.error(message)] on failure without loading',
      build: () {
        when(() => mockUpdateCreditCard.call(any()))
            .thenAnswer((_) async => Left(DummyFailure('Update failed')));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptUpdateCreditCard(card: testCreditCard),
      expect: () => [const CardsState.error('Update failed')],
    );
  });

  group('attemptSetDefaultCreditCard', () {
    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.success("Updated default card successfully")] on success without loading',
      build: () {
        when(() => mockSetDefaultCreditCard.call(any()))
            .thenAnswer((_) async => const Right(unit));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptSetDefaultCreditCard('card_1'),
      expect: () => [const CardsState.success('Updated default card successfully')],
      verify: (_) {
        verify(() => mockSetDefaultCreditCard.call('card_1')).called(1);
      },
    );

    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.error(message)] on failure without loading',
      build: () {
        when(() => mockSetDefaultCreditCard.call(any()))
            .thenAnswer((_) async => Left(DummyFailure('Set default card failed')));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptSetDefaultCreditCard('card_1'),
      expect: () => [const CardsState.error('Set default card failed')],
    );
  });

  group('attemptGetCreditCards', () {
    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.loaded(list)] on success without loading',
      build: () {
        when(() => mockGetCreditCards.call())
            .thenAnswer((_) async => Right([testCreditCard]));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptGetCreditCards(),
      expect: () => [CardsState.loaded([testCreditCard])],
      verify: (_) {
        verify(() => mockGetCreditCards.call()).called(1);
      },
    );

    blocTest<CardsCubit, CardsState>(
      'emits [CardsState.error(message)] on failure without loading',
      build: () {
        when(() => mockGetCreditCards.call())
            .thenAnswer((_) async => Left(DummyFailure('Fetch cards failed')));
        return cardsCubit;
      },
      act: (cubit) => cubit.attemptGetCreditCards(),
      expect: () => [const CardsState.error('Fetch cards failed')],
    );
  });
}
