part of 'shop_cubit.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.initial() = _Initial;
  const factory ShopState.loading() = _Loading;
  const factory ShopState.loadedProducts(List<Product> products) =
      _LoadedProducts;
  const factory ShopState.loadedCategories(List<Category> categories) =
      _LoadedCategories;
  const factory ShopState.loadedReviews(List<Review> reviews) = _LoadedReviews;
  const factory ShopState.success(String message) = _Success;
  const factory ShopState.error(String message) = _Error;
}
