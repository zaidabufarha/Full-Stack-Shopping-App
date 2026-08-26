import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCachedUser {
  final AuthRepository repository;
  GetCachedUser({required this.repository});
  Future<User?> call() async {
    return await repository.getCachedUser();
  }
}
