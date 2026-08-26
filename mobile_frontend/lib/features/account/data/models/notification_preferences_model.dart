import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences_model.g.dart';

@JsonSerializable()
class NotificationPreferencesModel extends NotificationPreferences {
  NotificationPreferencesModel({
    required super.allowEmail,
    required super.allowGeneral,
    required super.allowOrder,
  });
  factory NotificationPreferencesModel.fromEntity(
          NotificationPreferences entity) =>
      NotificationPreferencesModel(
        allowEmail: entity.allowEmail,
        allowGeneral: entity.allowGeneral,
        allowOrder: entity.allowOrder,
      );

  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('allow_email') && !mapped.containsKey('allowEmail')) {
      mapped['allowEmail'] = mapped['allow_email'];
    }
    if (mapped.containsKey('allow_general') &&
        !mapped.containsKey('allowGeneral')) {
      mapped['allowGeneral'] = mapped['allow_general'];
    }
    if (mapped.containsKey('allow_order') && !mapped.containsKey('allowOrder')) {
      mapped['allowOrder'] = mapped['allow_order'];
    }
    return _$NotificationPreferencesModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$NotificationPreferencesModelToJson(this);
}
