import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveCredentials {
  final AuthRepository authRepository;
  SaveCredentials(this.authRepository);

  Future<void> call(String email) async {
    await authRepository.saveEmail(email);
  }
}
