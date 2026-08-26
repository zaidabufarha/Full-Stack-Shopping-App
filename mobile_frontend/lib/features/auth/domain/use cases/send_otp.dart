import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendOtp {
  final AuthRepository repository;
  SendOtp({required this.repository});
  Future<Either<Failure, Unit>> call({required String number}) async {
    return await repository.sendOtp(number: number);
  }
}
