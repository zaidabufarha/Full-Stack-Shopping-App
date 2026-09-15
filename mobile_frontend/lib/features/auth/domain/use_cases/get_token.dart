import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetToken {
  final AuthRepository repository;
  GetToken({required this.repository});
  Future<String?> call() async {
    return await repository.getToken();
  }
}
