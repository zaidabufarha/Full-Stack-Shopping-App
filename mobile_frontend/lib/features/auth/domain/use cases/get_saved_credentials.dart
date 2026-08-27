import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSavedCredentials {
  final AuthRepository authRepository;
  GetSavedCredentials(this.authRepository);

  Future<String?> call() async {
    return await authRepository.getSavedEmail();
  }
}
