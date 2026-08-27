import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/use%20cases/cache_user.dart';
import 'package:big_cart/features/auth/domain/use%20cases/clear_credentials.dart';
import 'package:big_cart/features/auth/domain/use%20cases/forgot_password.dart';
import 'package:big_cart/features/auth/domain/use%20cases/get_cached_user.dart';
import 'package:big_cart/features/auth/domain/use%20cases/get_saved_credentials.dart';
import 'package:big_cart/features/auth/domain/use%20cases/log_in.dart';
import 'package:big_cart/features/auth/domain/use%20cases/save_credentials.dart';
import 'package:big_cart/features/auth/domain/use%20cases/send_otp.dart';
import 'package:big_cart/features/auth/domain/use%20cases/sign_out.dart';
import 'package:big_cart/features/auth/domain/use%20cases/sign_up.dart';
import 'package:big_cart/features/auth/domain/use%20cases/verify_otp.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetCachedUser extends Mock implements GetCachedUser {}
class MockLogIn extends Mock implements LogIn {}
class MockSignUp extends Mock implements SignUp {}
class MockSendOtp extends Mock implements SendOtp {}
class MockCacheUser extends Mock implements CacheUser {}
class MockVerifyOtp extends Mock implements VerifyOtp {}
class MockForgotPassword extends Mock implements ForgotPassword {}
class MockSignOut extends Mock implements SignOut {}
class MockSaveCredentials extends Mock implements SaveCredentials {}
class MockGetSavedCredentials extends Mock implements GetSavedCredentials {}
class MockClearCredentials extends Mock implements ClearCredentials {}

void main() {
  late MockGetCachedUser mockGetCachedUser;
  late MockLogIn mockLogIn;
  late MockSignUp mockSignUp;
  late MockSendOtp mockSendOtp;
  late MockCacheUser mockCacheUser;
  late MockVerifyOtp mockVerifyOtp;
  late MockForgotPassword mockForgotPassword;
  late MockSignOut mockSignOut;
  late MockSaveCredentials mockSaveCredentials;
  late MockGetSavedCredentials mockGetSavedCredentials;
  late MockClearCredentials mockClearCredentials;
  late AuthCubit authCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetCachedUser = MockGetCachedUser();
    mockLogIn = MockLogIn();
    mockSignUp = MockSignUp();
    mockSendOtp = MockSendOtp();
    mockCacheUser = MockCacheUser();
    mockVerifyOtp = MockVerifyOtp();
    mockForgotPassword = MockForgotPassword();
    mockSignOut = MockSignOut();
    mockSaveCredentials = MockSaveCredentials();
    mockGetSavedCredentials = MockGetSavedCredentials();
    mockClearCredentials = MockClearCredentials();

    authCubit = AuthCubit(
      mockGetCachedUser,
      mockLogIn,
      mockSignUp,
      mockSendOtp,
      mockCacheUser,
      mockVerifyOtp,
      mockForgotPassword,
      mockSignOut,
      mockSaveCredentials,
      mockGetSavedCredentials,
      mockClearCredentials,
    );
  });

  tearDown(() {
    authCubit.close();
  });

  test('initial state is AuthState.initial()', () {
    expect(authCubit.state, const AuthState.initial());
  });

  group('checkIfLoggedIn', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.success(user)] when cached user exists',
      build: () {
        when(() => mockGetCachedUser.call()).thenAnswer((_) async => testUser);
        return authCubit;
      },
      act: (cubit) => cubit.checkIfLoggedIn(),
      expect: () => [AuthState.success(testUser)],
      verify: (_) {
        verify(() => mockGetCachedUser.call()).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.initial()] when cached user is null (from non-initial seed)',
      seed: () => const AuthState.loading(),
      build: () {
        when(() => mockGetCachedUser.call()).thenAnswer((_) async => null);
        return authCubit;
      },
      act: (cubit) => cubit.checkIfLoggedIn(),
      expect: () => [const AuthState.initial()],
      verify: (_) {
        verify(() => mockGetCachedUser.call()).called(1);
      },
    );
  });

  group('attemptLogIn', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] and saves credentials when remember is true',
      build: () {
        when(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: true,
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(() => mockSaveCredentials.call(any())).thenAnswer((_) async {});
        when(() => mockCacheUser.call(any())).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.attemptLogIn('john@example.com', 'password123', true),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
      verify: (_) {
        verify(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: true,
          ),
        ).called(1);
        verify(() => mockSaveCredentials.call('john@example.com')).called(1);
        verify(() => mockCacheUser.call(testUser)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] and clears credentials when remember is false',
      build: () {
        when(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: false,
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(() => mockClearCredentials.call()).thenAnswer((_) async {});
        when(() => mockCacheUser.call(any())).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.attemptLogIn('john@example.com', 'password123', false),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
      verify: (_) {
        verify(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: false,
          ),
        ).called(1);
        verify(() => mockClearCredentials.call()).called(1);
        verify(() => mockCacheUser.call(testUser)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when logIn returns Failure',
      build: () {
        when(
          () => mockLogIn.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            remember: any(named: 'remember'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Invalid credentials')));
        return authCubit;
      },
      act: (cubit) => cubit.attemptLogIn('john@example.com', 'wrongpass', false),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Invalid credentials'),
      ],
    );
  });

  group('attemptSignUp', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when signUp succeeds',
      build: () {
        when(
          () => mockSignUp.call(
            email: 'john@example.com',
            password: 'password123',
            number: '+1234567890',
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(() => mockCacheUser.call(any())).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.attemptSignUp('john@example.com', 'password123', '+1234567890'),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
      verify: (_) {
        verify(() => mockCacheUser.call(testUser)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when signUp returns Failure',
      build: () {
        when(
          () => mockSignUp.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            number: any(named: 'number'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Email in use')));
        return authCubit;
      },
      act: (cubit) => cubit.attemptSignUp('john@example.com', 'password123', '+1234567890'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Email in use'),
      ],
    );
  });

  group('sendOtpToUser', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when sendOtp succeeds',
      build: () {
        when(() => mockSendOtp.call(number: '+1234567890'))
            .thenAnswer((_) async => const Right(unit));
        return authCubit;
      },
      act: (cubit) => cubit.sendOtpToUser('+1234567890'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when sendOtp returns Failure',
      build: () {
        when(() => mockSendOtp.call(number: any(named: 'number')))
            .thenAnswer((_) async => Left(DummyFailure('OTP failed')));
        return authCubit;
      },
      act: (cubit) => cubit.sendOtpToUser('+1234567890'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('OTP failed'),
      ],
    );
  });

  group('verifyUserOtp', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when verifyOtp succeeds and subsequent login succeeds',
      build: () {
        when(
          () => mockVerifyOtp.call(
            email: 'john@example.com',
            otp: '123456',
            number: '+1234567890',
            password: 'password123',
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: true,
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(() => mockCacheUser.call(any())).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '123456',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
      verify: (_) {
        verify(() => mockCacheUser.call(testUser)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when verifyOtp fails',
      build: () {
        when(
          () => mockVerifyOtp.call(
            email: any(named: 'email'),
            otp: any(named: 'otp'),
            number: any(named: 'number'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Incorrect OTP')));
        return authCubit;
      },
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '000000',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Incorrect OTP'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when verifyOtp succeeds but login fails',
      build: () {
        when(
          () => mockVerifyOtp.call(
            email: any(named: 'email'),
            otp: any(named: 'otp'),
            number: any(named: 'number'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(
          () => mockLogIn.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            remember: any(named: 'remember'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Auto login failed')));
        return authCubit;
      },
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '123456',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Auto login failed'),
      ],
    );
  });

  group('userForgotPassword', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when forgotPassword succeeds',
      build: () {
        when(() => mockForgotPassword.call(email: 'john@example.com'))
            .thenAnswer((_) async => const Right(unit));
        return authCubit;
      },
      act: (cubit) => cubit.userForgotPassword('john@example.com'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when forgotPassword fails',
      build: () {
        when(() => mockForgotPassword.call(email: any(named: 'email')))
            .thenAnswer((_) async => Left(DummyFailure('Email not found')));
        return authCubit;
      },
      act: (cubit) => cubit.userForgotPassword('unknown@example.com'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Email not found'),
      ],
    );
  });

  group('attemptSignOut', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when signOut called',
      build: () {
        when(() => mockSignOut.call()).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.attemptSignOut(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
      verify: (_) {
        verify(() => mockSignOut.call()).called(1);
      },
    );
  });

  group('attemptGetSavedCredentials', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, loadedEmail] when credentials exist',
      build: () {
        when(() => mockGetSavedCredentials.call())
            .thenAnswer((_) async => 'saved@example.com');
        return authCubit;
      },
      act: (cubit) => cubit.attemptGetSavedCredentials(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.loadedEmail('saved@example.com'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when credentials return null',
      build: () {
        when(() => mockGetSavedCredentials.call()).thenAnswer((_) async => null);
        return authCubit;
      },
      act: (cubit) => cubit.attemptGetSavedCredentials(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
    );
  });
}
