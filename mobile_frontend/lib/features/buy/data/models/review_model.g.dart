// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  user: const UserConverter().fromJson(json['user']),
  comment: json['comment'] as String,
  rating: (json['rating'] as num).toDouble(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'user': const UserConverter().toJson(instance.user),
      'created_at': instance.createdAt.toIso8601String(),
      'rating': instance.rating,
      'comment': instance.comment,
    };
