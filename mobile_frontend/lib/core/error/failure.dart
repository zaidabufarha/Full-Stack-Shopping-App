abstract class Failure {
  String message;
  Failure(this.message);
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure([super.message = 'Incorrect password']);
}

class NoInternetFailure extends Failure {
  NoInternetFailure([super.message = 'Couldn\'t connect to the server']);
}

class WrongOTPFailure extends Failure {
  WrongOTPFailure([super.message = 'Incorrect OTP']);
}

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure([super.message = 'Invalid email']);
}

class InvalidNumberFailure extends Failure {
  InvalidNumberFailure([super.message = 'Number already in use']);
}

class PasswordMismatchFailure extends Failure {
  PasswordMismatchFailure([super.message = 'Passwords do not match']);
}

class NoDataFailure extends Failure {
  NoDataFailure([super.message = 'Requested resource not found']);
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure([super.message = 'User session not found']);
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Something went wrong, try again later']);
}
