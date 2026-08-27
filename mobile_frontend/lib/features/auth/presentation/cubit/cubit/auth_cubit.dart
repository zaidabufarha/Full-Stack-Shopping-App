import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/use%20cases/cache_user.dart';
import 'package:big_cart/features/auth/domain/use%20cases/forgot_password.dart';
import 'package:big_cart/features/auth/domain/use%20cases/get_cached_user.dart';
import 'package:big_cart/features/auth/domain/use%20cases/log_in.dart';
import 'package:big_cart/features/auth/domain/use%20cases/send_otp.dart';
import 'package:big_cart/features/auth/domain/use%20cases/sign_up.dart';
import 'package:big_cart/features/auth/domain/use%20cases/verify_otp.dart';
import 'package:big_cart/features/auth/domain/use%20cases/sign_out.dart';
import 'package:big_cart/features/auth/domain/use%20cases/save_credentials.dart';
import 'package:big_cart/features/auth/domain/use%20cases/get_saved_credentials.dart';
import 'package:big_cart/features/auth/domain/use%20cases/clear_credentials.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.getCachedUser,
    this.logIn,
    this.signUp,
    this.sendOtp,
    this.cacheUser,
    this.verifyOtp,
    this.forgotPassword,
    this.signOut,
    this.saveCredentials,
    this.getSavedCredentials,
    this.clearCredentials,
  ) : super(AuthState.initial());
  GetCachedUser getCachedUser;
  LogIn logIn;
  SignUp signUp;
  SendOtp sendOtp;
  CacheUser cacheUser;
  VerifyOtp verifyOtp;
  ForgotPassword forgotPassword;
  SignOut signOut;
  SaveCredentials saveCredentials;
  GetSavedCredentials getSavedCredentials;
  ClearCredentials clearCredentials;

  void checkIfLoggedIn() async {
    final user = await getCachedUser();
    if (user == null) {
      emit(AuthState.initial());
    } else {
      emit(AuthState.success(user));
    }
  }

  void attemptLogIn(String email, String password, bool remember) async {
    emit(AuthState.loading());
    final result = await logIn.call(
      email: email,
      password: password,
      remember: remember,
    );
    result.fold((failure) => emit(AuthState.error(failure.message)), (
      user,
    ) async {
      if (remember) {
        await saveCredentials.call(email);
      } else {
        await clearCredentials.call();
      }
      await cacheUser.call(user);
      emit(AuthState.success(user));
    });
  }

  void attemptSignUp(String email, String password, String number) async {
    emit(AuthState.loading());
    final result = await signUp.call(
      email: email,
      password: password,
      number: number,
    );
    result.fold((failure) => emit(AuthState.error(failure.message)), (
      user,
    ) async {
      await cacheUser.call(user);
      emit(AuthState.success(user));
    });
  }

  void sendOtpToUser(String number) async {
    emit(AuthState.loading());
    final result = await sendOtp.call(number: number);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (unit) => emit(AuthState.initial()),
    );
  }

  void verifyUserOtp({
    required String email,
    required String otp,
    required String password,
    required String number,
  }) async {
    emit(AuthState.loading());
    final result = await verifyOtp.call(
      email: email,
      otp: otp,
      number: number,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) async {
        final loginRes = await logIn.call(
          email: email,
          password: password,
          remember: true,
        );
        loginRes.fold(
          (failure) => emit(AuthState.error(failure.message)),
          (loggedInUser) async {
            await cacheUser.call(loggedInUser);
            emit(AuthState.success(loggedInUser));
          },
        );
      },
    );
  }

  void userForgotPassword(String email) async {
    emit(AuthState.loading());
    final result = await forgotPassword.call(email: email);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (unit) => emit(AuthState.initial()),
    );
  }

  Future<void> attemptSignOut() async {
    emit(AuthState.loading());
    await signOut.call();
    emit(AuthState.initial());
  }

  Future<void> attemptGetSavedCredentials() async {
    emit(AuthState.loading());
    final email = await getSavedCredentials.call();
    if (email == null) {
      emit(AuthState.initial());
    } else {
      emit(AuthState.loadedEmail(email));
    }
  }
}
