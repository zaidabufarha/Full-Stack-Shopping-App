// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String,
  name: json['name'] as String,
  imagePath: json['image_path'] as String,
  amount: json['amount'] as String,
  description: json['description'] as String,
  discount: (json['discount'] as num).toDouble(),
  price: (json['price'] as num).toDouble(),
  isNew: json['is_new'] as bool,
  isFavorite: json['is_favorite'] as bool? ?? false,
  freeShipping: json['free_shipping'] as bool? ?? false,
  sameDayDelivery: json['same_day_delivery'] as bool? ?? false,
  category: const CategoryConverter().fromJson(json['category']),
  color: const ColorConverter().fromJson(json['color']),
  review:
      (json['review'] as List<dynamic>?)
          ?.map(const ReviewConverter().fromJson)
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_path': instance.imagePath,
      'amount': instance.amount,
      'description': instance.description,
      'discount': instance.discount,
      'price': instance.price,
      'is_new': instance.isNew,
      'is_favorite': instance.isFavorite,
      'free_shipping': instance.freeShipping,
      'same_day_delivery': instance.sameDayDelivery,
      'category': const CategoryConverter().toJson(instance.category),
      'color': const ColorConverter().toJson(instance.color),
      'review': instance.review.map(const ReviewConverter().toJson).toList(),
    };
