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
import 'package:big_cart/features/auth/domain/use_cases/clear_credentials.dart'
    as _i226;
import 'package:big_cart/features/auth/domain/use_cases/forgot_password.dart'
    as _i461;
import 'package:big_cart/features/auth/domain/use_cases/get_saved_credentials.dart'
    as _i669;
import 'package:big_cart/features/auth/domain/use_cases/get_token.dart'
    as _i287;
import 'package:big_cart/features/auth/domain/use_cases/log_in.dart' as _i146;
import 'package:big_cart/features/auth/domain/use_cases/save_credentials.dart'
    as _i512;
import 'package:big_cart/features/auth/domain/use_cases/send_otp.dart' as _i877;
import 'package:big_cart/features/auth/domain/use_cases/sign_out.dart' as _i867;
import 'package:big_cart/features/auth/domain/use_cases/sign_up.dart' as _i625;
import 'package:big_cart/features/auth/domain/use_cases/verify_otp.dart'
    as _i98;
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart'
    as _i832;
import 'package:big_cart/features/buy/data/data_sources/buy_remote_data_source.dart'
    as _i325;
import 'package:big_cart/features/buy/data/repositories/buy_repository_impl.dart'
    as _i396;
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart'
    as _i72;
import 'package:big_cart/features/buy/domain/use_cases/add_review.dart'
    as _i971;
import 'package:big_cart/features/buy/domain/use_cases/add_to_cart.dart'
    as _i66;
import 'package:big_cart/features/buy/domain/use_cases/check_out.dart' as _i929;
import 'package:big_cart/features/buy/domain/use_cases/get_cart_items.dart'
    as _i48;
import 'package:big_cart/features/buy/domain/use_cases/get_category_list.dart'
    as _i658;
import 'package:big_cart/features/buy/domain/use_cases/get_product_list.dart'
    as _i311;
import 'package:big_cart/features/buy/domain/use_cases/get_product_reviews.dart'
    as _i465;
import 'package:big_cart/features/buy/domain/use_cases/remove_from_cart.dart'
    as _i670;
import 'package:big_cart/features/buy/domain/use_cases/toggle_favorite.dart'
    as _i584;
import 'package:big_cart/features/buy/domain/use_cases/update_quantity.dart'
    as _i60;
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
    gh.lazySingleton<_i461.ForgotPassword>(
      () => _i461.ForgotPassword(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i287.GetToken>(
      () => _i287.GetToken(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i877.SendOtp>(
      () => _i877.SendOtp(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i625.SignUp>(
      () => _i625.SignUp(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i98.VerifyOtp>(
      () => _i98.VerifyOtp(repository: gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i226.ClearCredentials>(
      () => _i226.ClearCredentials(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i669.GetSavedCredentials>(
      () => _i669.GetSavedCredentials(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i512.SaveCredentials>(
      () => _i512.SaveCredentials(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i867.SignOut>(
      () => _i867.SignOut(gh<_i832.AuthRepository>()),
    );
    gh.lazySingleton<_i971.AddReview>(
      () => _i971.AddReview(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i66.AddToCart>(
      () => _i66.AddToCart(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i929.CheckOut>(
      () => _i929.CheckOut(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i48.GetCartItems>(
      () => _i48.GetCartItems(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i658.GetCategoryList>(
      () => _i658.GetCategoryList(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i311.GetProductList>(
      () => _i311.GetProductList(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i465.GetProductReviews>(
      () => _i465.GetProductReviews(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i670.RemoveFromCart>(
      () => _i670.RemoveFromCart(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i584.ToggleFavorite>(
      () => _i584.ToggleFavorite(gh<_i72.BuyRepository>()),
    );
    gh.lazySingleton<_i60.UpdateQuantity>(
      () => _i60.UpdateQuantity(gh<_i72.BuyRepository>()),
    );
    gh.factory<_i475.TransactionsCubit>(
      () => _i475.TransactionsCubit(gh<_i526.GetTransactions>()),
    );
    gh.factory<_i984.CartCubit>(
      () => _i984.CartCubit(
        gh<_i66.AddToCart>(),
        gh<_i929.CheckOut>(),
        gh<_i48.GetCartItems>(),
        gh<_i670.RemoveFromCart>(),
        gh<_i60.UpdateQuantity>(),
      ),
    );
    gh.factory<_i9.ShopCubit>(
      () => _i9.ShopCubit(
        gh<_i971.AddReview>(),
        gh<_i658.GetCategoryList>(),
        gh<_i311.GetProductList>(),
        gh<_i465.GetProductReviews>(),
        gh<_i584.ToggleFavorite>(),
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
    gh.lazySingleton<_i146.LogIn>(
      () => _i146.LogIn(authRepository: gh<_i832.AuthRepository>()),
    );
    gh.factory<_i194.OrdersCubit>(
      () => _i194.OrdersCubit(gh<_i856.GetOrders>()),
    );
    gh.factory<_i832.AuthCubit>(
      () => _i832.AuthCubit(
        gh<_i287.GetToken>(),
        gh<_i146.LogIn>(),
        gh<_i625.SignUp>(),
        gh<_i877.SendOtp>(),
        gh<_i98.VerifyOtp>(),
        gh<_i461.ForgotPassword>(),
        gh<_i867.SignOut>(),
        gh<_i512.SaveCredentials>(),
        gh<_i669.GetSavedCredentials>(),
        gh<_i226.ClearCredentials>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i967.RegisterModule {}
