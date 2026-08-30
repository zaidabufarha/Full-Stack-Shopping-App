// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:big_cart/core/api/api.dart' as _i1010;
import 'package:big_cart/core/di/injection.dart' as _i967;
import 'package:big_cart/core/network/network_info.dart' as _i1004;
import 'package:big_cart/core/session/user_local_data_source.dart' as _i503;
import 'package:big_cart/features/account/data/data_sources/account_remote_data_source.dart'
    as _i1020;
import 'package:big_cart/features/account/data/repositories/account_repository_impl.dart'
    as _i1055;
import 'package:big_cart/features/account/domain/repositories/account_repository.dart'
    as _i62;
import 'package:big_cart/features/account/domain/use_cases/add_address.dart'
    as _i350;
import 'package:big_cart/features/account/domain/use_cases/add_credit_card.dart'
    as _i886;
import 'package:big_cart/features/account/domain/use_cases/add_profile_picture.dart'
    as _i261;
import 'package:big_cart/features/account/domain/use_cases/get_addresses.dart'
    as _i392;
import 'package:big_cart/features/account/domain/use_cases/get_credit_cards.dart'
    as _i600;
import 'package:big_cart/features/account/domain/use_cases/get_notification_preferences.dart'
    as _i151;
import 'package:big_cart/features/account/domain/use_cases/get_orders.dart'
    as _i856;
import 'package:big_cart/features/account/domain/use_cases/get_transactions.dart'
    as _i526;
import 'package:big_cart/features/account/domain/use_cases/get_user_data.dart'
    as _i605;
import 'package:big_cart/features/account/domain/use_cases/set_default_credit_card.dart'
    as _i604;
import 'package:big_cart/features/account/domain/use_cases/set_notification_preferences.dart'
    as _i783;
import 'package:big_cart/features/account/domain/use_cases/update_address.dart'
    as _i141;
import 'package:big_cart/features/account/domain/use_cases/update_credit_card.dart'
    as _i1051;
import 'package:big_cart/features/account/domain/use_cases/update_profile.dart'
    as _i134;
import 'package:big_cart/features/account/presentation/cubit/cubit/cards_cubit.dart'
    as _i435;
import 'package:big_cart/features/account/presentation/cubit/cubit/cubit/address_cubit.dart'
    as _i862;
import 'package:big_cart/features/account/presentation/cubit/cubit/orders_cubit.dart'
    as _i194;
import 'package:big_cart/features/account/presentation/cubit/cubit/transactions_cubit.dart'
    as _i475;
import 'package:big_cart/features/account/presentation/cubit/cubit/user_cubit.dart'
    as _i662;
import 'package:big_cart/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i793;
import 'package:big_cart/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i135;
import 'package:big_cart/features/auth/data/repositories/auth_repository_impl.dart'
    as _i731;
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart'
    as _i832;
import 'package:big_cart/features/auth/domain/use%20cases/clear_credentials.dart'
    as _i515;
import 'package:big_cart/features/auth/domain/use%20cases/forgot_password.dart'
    as _i211;
import 'package:big_cart/features/auth/domain/use%20cases/get_saved_credentials.dart'
    as _i372;
import 'package:big_cart/features/auth/domain/use%20cases/get_token.dart'
    as _i557;
import 'package:big_cart/features/auth/domain/use%20cases/log_in.dart' as _i270;
import 'package:big_cart/features/auth/domain/use%20cases/save_credentials.dart'
    as _i77;
import 'package:big_cart/features/auth/domain/use%20cases/send_otp.dart'
    as _i491;
import 'package:big_cart/features/auth/domain/use%20cases/sign_out.dart'
    as _i937;
import 'package:big_cart/features/auth/domain/use%20cases/sign_up.dart'
    as _i357;
import 'package:big_cart/features/auth/domain/use%20cases/verify_otp.dart'
    as _i210;
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart'
    as _i832;
import 'package:big_cart/features/buy/data/data_sources/buy_remote_data_source.dart'
    as _i325;
import 'package:big_cart/features/buy/data/repositories/buy_repository_impl.dart'
    as _i396;
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart'
    as _i72;
import 'package:big_cart/features/buy/domain/use%20cases/add_review.dart'
    as _i564;
import 'package:big_cart/features/buy/domain/use%20cases/add_to_cart.dart'
    as _i384;
import 'package:big_cart/features/buy/domain/use%20cases/check_out.dart'
    as _i316;
import 'package:big_cart/features/buy/domain/use%20cases/get_cart_items.dart'
    as _i738;
import 'package:big_cart/features/buy/domain/use%20cases/get_category_list.dart'
    as _i410;
import 'package:big_cart/features/buy/domain/use%20cases/get_product_list.dart'
    as _i1020;
import 'package:big_cart/features/buy/domain/use%20cases/get_product_reviews.dart'
    as _i950;
import 'package:big_cart/features/buy/domain/use%20cases/remove_from_cart.dart'
    as _i954;
import 'package:big_cart/features/buy/domain/use%20cases/toggle_favorite.dart'
    as _i826;
import 'package:big_cart/features/buy/domain/use%20cases/update_quantity.dart'
    as _i513;
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart'
    as _i984;
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart'
    as _i9;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker,
    );
    gh.lazySingleton<_i503.UserLocalDataSource>(
      () => _i503.UserLocalDataSourceImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i1004.NetworkInfo>(
      () => _i1004.NetworkInfoImpl(
        internetConnectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.lazySingleton<_i793.AuthLocalDataSource>(
      () => _i793.AuthLocalDataSourceImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1010.ApiConsumer>(
      () => _i1010.DioConsumer(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i325.BuyRemoteDataSource>(
      () => _i325.BuyRemoteDataSourceImpl(
        apiConsumer: gh<_i1010.ApiConsumer>(),
        userLocalDataSource: gh<_i503.UserLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i1020.AccountRemoteDataSource>(
      () => _i1020.AccountRemoteDataSourceImpl(
        apiConsumer: gh<_i1010.ApiConsumer>(),
        userLocalDataSource: gh<_i503.UserLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i135.AuthRemoteDataSource>(
      () => _i135.AuthRemoteDataSourceImpl(
        apiConsumer: gh<_i1010.ApiConsumer>(),
        userLocalDataSource: gh<_i503.UserLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i72.BuyRepository>(
      () => _i396.BuyRepositoryImpl(
        gh<_i325.BuyRemoteDataSource>(),
        gh<_i1004.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i62.AccountRepository>(
      () => _i1055.AccountRepositoryImpl(
        accountRemoteDataSource: gh<_i1020.AccountRemoteDataSource>(),
        networkInfo: gh<_i1004.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i350.AddAddress>(
      () => _i350.AddAddress(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.lazySingleton<_i886.AddCreditCard>(
      () =>
          _i886.AddCreditCard(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.lazySingleton<_i261.AddProfilePicture>(
      () => _i261.AddProfilePicture(
        accountRepository: gh<_i62.AccountRepository>(),
      ),
    );
    gh.lazySingleton<_i392.GetAddresses>(
      () => _i392.GetAddresses(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.lazySingleton<_i600.GetCreditCards>(
      () =>
          _i600.GetCreditCards(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.lazySingleton<_i151.GetNotificationPreferences>(
      () => _i151.GetNotificationPreferences(
        accountRepository: gh<_i62.AccountRepository>(),
      ),
    );
    gh.lazySingleton<_i856.GetOrders>(
      () => _i856.GetOrders(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.lazySingleton<_i526.GetTransactions>(
      () => _i526.GetTransactions(
        accountRepository: gh<_i62.AccountRepository>(),
      ),
    );
    gh.lazySingleton<_i605.GetUserData>(
      () => _i605.GetUserData(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.lazySingleton<_i604.SetDefaultCreditCard>(
      () => _i604.SetDefaultCreditCard(
        accountRepository: gh<_i62.AccountRepository>(),
      ),
    );
    gh.lazySingleton<_i783.SetNotificationPreferences>(
      () => _i783.SetNotificationPreferences(
        accountRepository: gh<_i62.AccountRepository>(),
      ),
    );
    gh.lazySingleton<_i141.UpdateAddress>(
      () =>
          _i141.UpdateAddress(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.lazySingleton<_i1051.UpdateCreditCard>(
      () => _i1051.UpdateCreditCard(
        accountRepository: gh<_i62.AccountRepository>(),
      ),
    );
    gh.lazySingleton<_i134.UpdateProfile>(
      () =>
          _i134.UpdateProfile(accountRepository: gh<_i62.AccountRepository>()),
    );
    gh.factory<_i862.AddressCubit>(
      () => _i862.AddressCubit(
        gh<_i350.AddAddress>(),
        gh<_i392.GetAddresses>(),
        gh<_i141.UpdateAddress>(),
      ),
    );
    gh.lazySingleton<_i832.AuthRepository>(
      () => _i731.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i135.AuthRemoteDataSource>(),
        authLocalDataSource: gh<_i793.AuthLocalDataSource>(),
        networkInfo: gh<_i1004.NetworkInfo>(),
      ),
    );
    gh.factory<_i662.UserCubit>(
      () => _i662.UserCubit(
        gh<_i261.AddProfilePicture>(),
        gh<_i151.GetNotificationPreferences>(),
        gh<_i605.GetUserData>(),
        gh<_i783.SetNotificationPreferences>(),
        gh<_i134.UpdateProfile>(),
      ),
    );
    gh.lazySingleton<_i211.ForgotPassword>(
      () => _i211.ForgotPassword(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i557.GetToken>(
      () => _i557.GetToken(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i491.SendOtp>(
      () => _i491.SendOtp(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i357.SignUp>(
      () => _i357.SignUp(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i210.VerifyOtp>(
      () => _i210.VerifyOtp(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i515.ClearCredentials>(
      () => _i515.ClearCredentials(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i372.GetSavedCredentials>(
      () => _i372.GetSavedCredentials(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i77.SaveCredentials>(
      () => _i77.SaveCredentials(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i937.SignOut>(
      () => _i937.SignOut(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i564.AddReview>(
      () => _i564.AddReview(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i384.AddToCart>(
      () => _i384.AddToCart(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i316.CheckOut>(
      () => _i316.CheckOut(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i738.GetCartItems>(
      () => _i738.GetCartItems(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i410.GetCategoryList>(
      () => _i410.GetCategoryList(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i1020.GetProductList>(
      () => _i1020.GetProductList(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i950.GetProductReviews>(
      () => _i950.GetProductReviews(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i954.RemoveFromCart>(
      () => _i954.RemoveFromCart(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i826.ToggleFavorite>(
      () => _i826.ToggleFavorite(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i513.UpdateQuantity>(
      () => _i513.UpdateQuantity(gh<_i72.BuyRepository>()),
    );
    gh.factory<_i475.TransactionsCubit>(
      () => _i475.TransactionsCubit(gh<_i526.GetTransactions>()),
    );
    gh.factory<_i984.CartCubit>(
      () => _i984.CartCubit(
        gh<_i384.AddToCart>(),
        gh<_i316.CheckOut>(),
        gh<_i738.GetCartItems>(),
        gh<_i954.RemoveFromCart>(),
        gh<_i513.UpdateQuantity>(),
      ),
    );
    gh.factory<_i435.CardsCubit>(
      () => _i435.CardsCubit(
        gh<_i886.AddCreditCard>(),
        gh<_i600.GetCreditCards>(),
        gh<_i1051.UpdateCreditCard>(),
        gh<_i604.SetDefaultCreditCard>(),
      ),
    );
    gh.lazySingleton<_i270.LogIn>(
      () => _i270.LogIn(authRepository: gh<_i832.AuthRepository>()),
    );
    gh.factory<_i194.OrdersCubit>(
      () => _i194.OrdersCubit(gh<_i856.GetOrders>()),
    );
    gh.factory<_i9.ShopCubit>(
      () => _i9.ShopCubit(
        gh<_i564.AddReview>(),
        gh<_i410.GetCategoryList>(),
        gh<_i1020.GetProductList>(),
        gh<_i950.GetProductReviews>(),
        gh<_i826.ToggleFavorite>(),
      ),
    );
    gh.factory<_i832.AuthCubit>(
      () => _i832.AuthCubit(
        gh<_i557.GetToken>(),
        gh<_i270.LogIn>(),
        gh<_i357.SignUp>(),
        gh<_i491.SendOtp>(),
        gh<_i210.VerifyOtp>(),
        gh<_i211.ForgotPassword>(),
        gh<_i937.SignOut>(),
        gh<_i77.SaveCredentials>(),
        gh<_i372.GetSavedCredentials>(),
        gh<_i515.ClearCredentials>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i967.RegisterModule {}
