// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferencesModel _$NotificationPreferencesModelFromJson(
  Map<String, dynamic> json,
) => NotificationPreferencesModel(
  allowEmail: json['allowEmail'] as bool,
  allowGeneral: json['allowGeneral'] as bool,
  allowOrder: json['allowOrder'] as bool,
);

Map<String, dynamic> _$NotificationPreferencesModelToJson(
  NotificationPreferencesModel instance,
) => <String, dynamic>{
  'allowGeneral': instance.allowGeneral,
  'allowOrder': instance.allowOrder,
  'allowEmail': instance.allowEmail,
};
