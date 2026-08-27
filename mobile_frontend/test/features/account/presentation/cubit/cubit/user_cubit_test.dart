import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/account/domain/use_cases/add_profile_picture.dart';
import 'package:big_cart/features/account/domain/use_cases/get_notification_preferences.dart';
import 'package:big_cart/features/account/domain/use_cases/get_user_data.dart';
import 'package:big_cart/features/account/domain/use_cases/set_notification_preferences.dart';
import 'package:big_cart/features/account/domain/use_cases/update_profile.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/user_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockAddProfilePicture extends Mock implements AddProfilePicture {}
class MockGetNotificationPreferences extends Mock
    implements GetNotificationPreferences {}
class MockGetUserData extends Mock implements GetUserData {}
class MockSetNotificationPreferences extends Mock
    implements SetNotificationPreferences {}
class MockUpdateProfile extends Mock implements UpdateProfile {}

void main() {
  late MockAddProfilePicture mockAddProfilePicture;
  late MockGetNotificationPreferences mockGetNotificationPreferences;
  late MockGetUserData mockGetUserData;
  late MockSetNotificationPreferences mockSetNotificationPreferences;
  late MockUpdateProfile mockUpdateProfile;
  late UserCubit userCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockAddProfilePicture = MockAddProfilePicture();
    mockGetNotificationPreferences = MockGetNotificationPreferences();
    mockGetUserData = MockGetUserData();
    mockSetNotificationPreferences = MockSetNotificationPreferences();
    mockUpdateProfile = MockUpdateProfile();

    userCubit = UserCubit(
      mockAddProfilePicture,
      mockGetNotificationPreferences,
      mockGetUserData,
      mockSetNotificationPreferences,
      mockUpdateProfile,
    );
  });

  tearDown(() {
    userCubit.close();
  });

  test('initial state is UserState.initial()', () {
    expect(userCubit.state, const UserState.initial());
  });

  group('attemptAddProfilePicture', () {
    blocTest<UserCubit, UserState>(
      'emits [UserState.success("Image changed successfully")] on success without loading',
      build: () {
        when(() => mockAddProfilePicture.call(path: any(named: 'path')))
            .thenAnswer((_) async => const Right(unit));
        return userCubit;
      },
      act: (cubit) => cubit.attemptAddProfilePicture('path/to/img.png'),
      expect: () => [const UserState.success('Image changed successfully')],
      verify: (_) {
        verify(() => mockAddProfilePicture.call(path: 'path/to/img.png'))
            .called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.error(message)] on failure without loading',
      build: () {
        when(() => mockAddProfilePicture.call(path: any(named: 'path')))
            .thenAnswer((_) async => Left(DummyFailure('Upload failed')));
        return userCubit;
      },
      act: (cubit) => cubit.attemptAddProfilePicture('path/to/img.png'),
      expect: () => [const UserState.error('Upload failed')],
    );
  });

  group('attemptGetNotificationPreferences', () {
    blocTest<UserCubit, UserState>(
      'emits [UserState.loadedPreferences(prefs)] on success without loading',
      build: () {
        when(() => mockGetNotificationPreferences.call())
            .thenAnswer((_) async => Right(testNotificationPreferences));
        return userCubit;
      },
      act: (cubit) => cubit.attemptGetNotificationPreferences(),
      expect: () => [UserState.loadedPreferences(testNotificationPreferences)],
      verify: (_) {
        verify(() => mockGetNotificationPreferences.call()).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.error(message)] on failure without loading',
      build: () {
        when(() => mockGetNotificationPreferences.call())
            .thenAnswer((_) async => Left(DummyFailure('Preferences failed')));
        return userCubit;
      },
      act: (cubit) => cubit.attemptGetNotificationPreferences(),
      expect: () => [const UserState.error('Preferences failed')],
    );
  });

  group('attemptGetUserData', () {
    blocTest<UserCubit, UserState>(
      'emits [UserState.loadedUser(user)] on success without loading',
      build: () {
        when(() => mockGetUserData.call())
            .thenAnswer((_) async => Right(testUser));
        return userCubit;
      },
      act: (cubit) => cubit.attemptGetUserData(),
      expect: () => [UserState.loadedUser(testUser)],
      verify: (_) {
        verify(() => mockGetUserData.call()).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.error(message)] on failure without loading',
      build: () {
        when(() => mockGetUserData.call())
            .thenAnswer((_) async => Left(DummyFailure('User data failed')));
        return userCubit;
      },
      act: (cubit) => cubit.attemptGetUserData(),
      expect: () => [const UserState.error('User data failed')],
    );
  });

  group('attemptSetNotificationPreferences', () {
    blocTest<UserCubit, UserState>(
      'emits [UserState.success("Preferences updated successfully")] on success without loading',
      build: () {
        when(
          () => mockSetNotificationPreferences.call(
            allowNotifications: any(named: 'allowNotifications'),
            allowEmailNotifications: any(named: 'allowEmailNotifications'),
            allowOrderNotifications: any(named: 'allowOrderNotifications'),
            allowGeneralNotifications: any(named: 'allowGeneralNotifications'),
          ),
        ).thenAnswer((_) async => const Right(unit));
        return userCubit;
      },
      act: (cubit) => cubit.attemptSetNotificationPreferences(
        allowNotifications: true,
        allowEmailNotifications: true,
        allowOrderNotifications: true,
        allowGeneralNotifications: true,
      ),
      expect: () => [const UserState.success('Preferences updated successfully')],
      verify: (_) {
        verify(
          () => mockSetNotificationPreferences.call(
            allowNotifications: true,
            allowEmailNotifications: true,
            allowOrderNotifications: true,
            allowGeneralNotifications: true,
          ),
        ).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.error(message)] on failure without loading',
      build: () {
        when(
          () => mockSetNotificationPreferences.call(
            allowNotifications: any(named: 'allowNotifications'),
            allowEmailNotifications: any(named: 'allowEmailNotifications'),
            allowOrderNotifications: any(named: 'allowOrderNotifications'),
            allowGeneralNotifications: any(named: 'allowGeneralNotifications'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Update prefs failed')));
        return userCubit;
      },
      act: (cubit) => cubit.attemptSetNotificationPreferences(
        allowNotifications: false,
        allowEmailNotifications: false,
        allowOrderNotifications: false,
        allowGeneralNotifications: false,
      ),
      expect: () => [const UserState.error('Update prefs failed')],
    );
  });

  group('attemptUpdateProfile', () {
    blocTest<UserCubit, UserState>(
      'emits [UserState.success("Profile updated successfully")] on success without loading',
      build: () {
        when(
          () => mockUpdateProfile.call(
            name: any(named: 'name'),
            email: any(named: 'email'),
            phoneNumber: any(named: 'phoneNumber'),
            currentPassword: any(named: 'currentPassword'),
            newPassword1: any(named: 'newPassword1'),
            newPassword2: any(named: 'newPassword2'),
          ),
        ).thenAnswer((_) async => const Right(unit));
        return userCubit;
      },
      act: (cubit) => cubit.attemptUpdateProfile(
        name: 'John Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        currentPassword: 'oldpassword',
        newPassword1: 'newpassword',
        newPassword2: 'newpassword',
      ),
      expect: () => [const UserState.success('Profile updated successfully')],
      verify: (_) {
        verify(
          () => mockUpdateProfile.call(
            name: 'John Doe',
            email: 'john@example.com',
            phoneNumber: '+1234567890',
            currentPassword: 'oldpassword',
            newPassword1: 'newpassword',
            newPassword2: 'newpassword',
          ),
        ).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emits [UserState.error(message)] on failure without loading',
      build: () {
        when(
          () => mockUpdateProfile.call(
            name: any(named: 'name'),
            email: any(named: 'email'),
            phoneNumber: any(named: 'phoneNumber'),
            currentPassword: any(named: 'currentPassword'),
            newPassword1: any(named: 'newPassword1'),
            newPassword2: any(named: 'newPassword2'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Update profile failed')));
        return userCubit;
      },
      act: (cubit) => cubit.attemptUpdateProfile(
        name: 'John Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        currentPassword: 'wrong',
        newPassword1: 'new',
        newPassword2: 'new',
      ),
      expect: () => [const UserState.error('Update profile failed')],
    );
  });
}
