// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  user: const UserConverter().fromJson(json['user'] as Map<String, dynamic>),
  content: json['content'] as String,
  rating: (json['rating'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'user': const UserConverter().toJson(instance.user),
      'timestamp': instance.timestamp.toIso8601String(),
      'rating': instance.rating,
      'content': instance.content,
    };
