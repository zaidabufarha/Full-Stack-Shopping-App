import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ForgotPassword {
  final AuthRepository repository;
  ForgotPassword({required this.repository});
  Future<Either<Failure, Unit>> call({
    required String email,
  }) async {
    return await repository.forgotPassword(email: email);
  }
}
