import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences.freezed.dart';

@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    required bool allowEmail,
    required bool allowGeneral,
    required bool allowOrder,
  }) = _NotificationPreferences;
}
