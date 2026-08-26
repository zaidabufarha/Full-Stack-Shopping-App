import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddProfilePicture {
  final AccountRepository accountRepository;
  AddProfilePicture({required this.accountRepository});

  Future<Either<Failure, Unit>> call({required String path}) async {
    return await accountRepository.addProfilePicture(path: path);
  }
}
