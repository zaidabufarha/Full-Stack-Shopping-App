part of 'cards_cubit.dart';

@freezed
class CardsState with _$CardsState {
  const factory CardsState.initial() = _Initial;
  const factory CardsState.loading() = _Loading;
  const factory CardsState.loaded(List<CreditCard> cards) = _Loaded;
  const factory CardsState.success(String message) = _Success;
  const factory CardsState.error(String message) = _Error;
}
