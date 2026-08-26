part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.loadedCredentials(String email, String password) =
      _LoadedCredentials;
  const factory AuthState.error(String errorMessage) = _Error;
  const factory AuthState.success(User user) = _Success;
}
