import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/account/domain/use_cases/add_profile_picture.dart';
import 'package:big_cart/features/account/domain/use_cases/get_notification_preferences.dart';
import 'package:big_cart/features/account/domain/use_cases/get_user_data.dart';
import 'package:big_cart/features/account/domain/use_cases/set_notification_preferences.dart';
import 'package:big_cart/features/account/domain/use_cases/update_profile.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(
    this.addProfilePicture,
    this.getNotificationPreferences,
    this.getUserData,
    this.setNotificationPreferences,
    this.updateProfile,
  ) : super(UserState.initial());
  AddProfilePicture addProfilePicture;
  GetNotificationPreferences getNotificationPreferences;
  GetUserData getUserData;
  SetNotificationPreferences setNotificationPreferences;
  UpdateProfile updateProfile;

  void attemptAddProfilePicture(String path) async {
    final result = await addProfilePicture.call(path: path);
    result.fold(
      (failure) {
        emit(UserState.error(failure.message));
      },
      (unit) {
        emit(UserState.success('Image changed successfully'));
      },
    );
  }

  void attemptGetNotificationPreferences() async {
    final result = await getNotificationPreferences.call();
    result.fold(
      (failure) {
        emit(UserState.error(failure.message));
      },
      (prefs) {
        emit(UserState.loadedPreferences(prefs));
      },
    );
  }

  void attemptGetUserData() async {
    final result = await getUserData.call();
    result.fold(
      (failure) {
        emit(UserState.error(failure.message));
      },
      (user) {
        emit(UserState.loadedUser(user));
      },
    );
  }

  void attemptSetNotificationPreferences({
    required bool allowNotifications,
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  }) async {
    final result = await setNotificationPreferences.call(
      allowNotifications: allowNotifications,
      allowEmailNotifications: allowEmailNotifications,
      allowOrderNotifications: allowOrderNotifications,
      allowGeneralNotifications: allowGeneralNotifications,
    );
    result.fold(
      (failure) {
        emit(UserState.error(failure.message));
      },
      (unit) {
        emit(UserState.success('Preferences updated successfully'));
      },
    );
  }

  void attemptUpdateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    final result = await updateProfile.call(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      currentPassword: currentPassword,
      newPassword1: newPassword1,
      newPassword2: newPassword2,
    );
    result.fold(
      (failure) {
        emit(UserState.error(failure.message));
      },
      (unit) {
        emit(UserState.success('Profile updated successfully'));
      },
    );
  }
}
