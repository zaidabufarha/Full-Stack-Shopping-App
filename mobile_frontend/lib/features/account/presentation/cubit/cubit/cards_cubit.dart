import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/use_cases/add_credit_card.dart';
import 'package:big_cart/features/account/domain/use_cases/get_credit_cards.dart';
import 'package:big_cart/features/account/domain/use_cases/update_credit_card.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cards_state.dart';
part 'cards_cubit.freezed.dart';

@injectable
class CardsCubit extends Cubit<CardsState> {
  CardsCubit(this.addCreditCard, this.getCreditCards, this.updateCreditCard)
    : super(CardsState.initial());
  AddCreditCard addCreditCard;
  UpdateCreditCard updateCreditCard;
  GetCreditCards getCreditCards;

  void attemptAddCreditCard({
    required String name,
    required String cardNumber,
    required String expiration,
    required String cvv,
    required bool saveCard,
    required PaymentProcessor processor,
  }) async {
    final result = await addCreditCard.call(
      name: name,
      cardNumber: cardNumber,
      expiration: expiration,
      cvv: cvv,
      saveCard: saveCard,
      processor: processor,
    );

    result.fold(
      (failure) {
        emit(CardsState.error(failure.message));
      },
      (unit) {
        emit(CardsState.success('Added successfully'));
      },
    );
  }

  Future<void> attemptUpdateCreditCard({required CreditCard card}) async {
    final result = await updateCreditCard.call(card);

    result.fold(
      (failure) {
        emit(CardsState.error(failure.message));
      },
      (unit) {
        emit(CardsState.success('Updated successfully'));
      },
    );
  }

  void attemptGetCreditCards() async {
    final result = await getCreditCards.call();

    result.fold(
      (failure) {
        emit(CardsState.error(failure.message));
      },
      (list) {
        emit(CardsState.loaded(list));
      },
    );
  }
}
