import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/use_cases/get_transactions.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'transactions_state.dart';
part 'transactions_cubit.freezed.dart';

@injectable
class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit(this.getTransactions) : super(TransactionsState.initial());
  GetTransactions getTransactions;

  void attemptGetTransactions() async {
    emit(TransactionsState.loading());
    final result = await getTransactions.call();
    result.fold(
      (failure) {
        emit(TransactionsState.error(failure.message));
      },
      (list) {
        emit(TransactionsState.loaded(list));
      },
    );
  }
}
