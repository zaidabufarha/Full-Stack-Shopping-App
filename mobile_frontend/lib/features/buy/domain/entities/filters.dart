import 'package:freezed_annotation/freezed_annotation.dart';

part 'filters.freezed.dart';

@freezed
abstract class Filters with _$Filters {
  const factory Filters({
    required double minRating,
    double? minPrice,
    double? maxPrice,
    @Default(false) bool discountOnly,
    @Default(false) bool freeShippingOnly,
    @Default(false) bool sameDayDeliveryOnly,
  }) = _Filters;
}
