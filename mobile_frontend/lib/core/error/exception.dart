class WrongPasswordException implements Exception {}

class NoInternetException implements Exception {}

class WrongOTPException implements Exception {}

class InvalidEmailException implements Exception {}

class InvalidNumberException implements Exception {}

class PasswordMismatchException implements Exception {}

class EmptyCacheException implements Exception {}

class NoDataException implements Exception {}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Something went wrong']);
  @override
  String toString() => message;
}
