part of 'transactions_cubit.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState.initial() = _Initial;
  const factory TransactionsState.loading() = _Loading;
  const factory TransactionsState.loaded(List<Transaction> transactions) = _Loaded;
  const factory TransactionsState.error(String message) = _Error;
}
