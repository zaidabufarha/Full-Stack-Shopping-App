class Filters {
  final double minRating;
  final double? minPrice;
  final double? maxPrice;
  final bool discountOnly;
  final bool freeShippingOnly;
  final bool sameDayDeliveryOnly;

  Filters({
    required this.minRating,
    this.minPrice,
    this.maxPrice,
    this.discountOnly = false,
    this.freeShippingOnly = false,
    this.sameDayDeliveryOnly = false,
  });
}
