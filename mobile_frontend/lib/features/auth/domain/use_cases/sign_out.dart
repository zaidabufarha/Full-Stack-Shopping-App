import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOut {
  final AuthRepository authRepository;
  SignOut(
    this.authRepository,
  );
  Future<void> call() async {
    return await authRepository.clearCache();
  }
}
