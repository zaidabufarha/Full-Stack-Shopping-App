import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserData {
  final AccountRepository accountRepository;
  GetUserData({required this.accountRepository});

  Future<Either<Failure, User>> call() async {
    return await accountRepository.getUserData();
  }
}
