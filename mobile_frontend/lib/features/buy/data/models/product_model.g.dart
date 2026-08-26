// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    ProductModel(
        id: json['id'] as String,
        name: json['name'] as String,
        imagePath: json['imagePath'] as String,
        amount: json['amount'] as String,
        description: json['description'] as String,
        discount: (json['discount'] as num).toDouble(),
        price: (json['price'] as num).toDouble(),
        isNew: json['isNew'] as bool,
        isFavorite: json['isFavorite'] as bool,
        category: const CategoryConverter().fromJson(
          json['category'] as Map<String, dynamic>,
        ),
        color: const ColorConverter().fromJson((json['color'] as num).toInt()),
        reviewList: (json['reviewList'] as List<dynamic>)
            .map(
              (e) =>
                  const ReviewConverter().fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      )
      ..freeShipping = json['freeShipping'] as bool
      ..sameDayDelivery = json['sameDayDelivery'] as bool;

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imagePath': instance.imagePath,
      'amount': instance.amount,
      'description': instance.description,
      'discount': instance.discount,
      'price': instance.price,
      'isNew': instance.isNew,
      'isFavorite': instance.isFavorite,
      'freeShipping': instance.freeShipping,
      'sameDayDelivery': instance.sameDayDelivery,
      'category': const CategoryConverter().toJson(instance.category),
      'color': const ColorConverter().toJson(instance.color),
      'reviewList': instance.reviewList
          .map(const ReviewConverter().toJson)
          .toList(),
    };
