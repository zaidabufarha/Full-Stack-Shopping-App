import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ClearCredentials {
  final AuthRepository authRepository;
  ClearCredentials(this.authRepository);

  Future<void> call() async {
    await authRepository.clearSavedEmail();
  }
}
