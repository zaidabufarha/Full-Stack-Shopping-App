// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferencesModel _$NotificationPreferencesModelFromJson(
  Map<String, dynamic> json,
) => NotificationPreferencesModel(
  allowEmail: json['allow_email'] as bool,
  allowGeneral: json['allow_general'] as bool,
  allowOrder: json['allow_order'] as bool,
);

Map<String, dynamic> _$NotificationPreferencesModelToJson(
  NotificationPreferencesModel instance,
) => <String, dynamic>{
  'allow_general': instance.allowGeneral,
  'allow_order': instance.allowOrder,
  'allow_email': instance.allowEmail,
};
