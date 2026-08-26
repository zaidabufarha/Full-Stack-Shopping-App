part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loadedUser(User user) = _LoadedUser;
  const factory UserState.loadedPreferences(
    NotificationPreferences preferences,
  ) = _LoadedPreferences;
  const factory UserState.success(String message) = _Success;
  const factory UserState.error(String message) = _Error;
}
