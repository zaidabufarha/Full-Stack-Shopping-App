import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUp {
  final AuthRepository repository;
  SignUp({required this.repository});
  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String number,
  }) async {
    return await repository.signUp(
      email: email,
      password: password,
      number: number,
    );
  }
}
