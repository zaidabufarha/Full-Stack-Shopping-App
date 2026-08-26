import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CacheUser {
  final AuthRepository authRepository;
  CacheUser(
    this.authRepository,
  );
  Future<void> call(User user) async {
    return await authRepository.cacheUser(user);
  }
}
