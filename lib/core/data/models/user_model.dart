import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final Avatar? avatar;
  final bool isActivated;
  final Preferences preferences;
  final NotificationSettings notificationSettings;
  @JsonKey(name: 'socialMedia')
  final Map<String, dynamic> socialMedia;
  final bool isDeleted;
  final bool twoFactorEnabled;
  final String? authProvider; // Made nullable
  final List<dynamic> messages; // Changed from List<String> to List<dynamic>

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatar,
    required this.isActivated,
    required this.preferences,
    required this.notificationSettings,
    required this.socialMedia,
    required this.isDeleted,
    required this.twoFactorEnabled,
    this.authProvider,
    required this.messages,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Avatar {
  final String? id; // Made nullable
  final String? name; // Made nullable
  final String? url; // Made nullable
  final bool isDeleted;
  final String? createdAt; // Made nullable
  final String? updatedAt; // Made nullable

  Avatar({
    this.id,
    this.name,
    this.url,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}

@JsonSerializable()
class Preferences {
  final String? currency;
  final String? language;
  final String? theme;

  Preferences({
    required this.currency,
    required this.language,
    required this.theme,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}

@JsonSerializable()
class NotificationSettings {
  final bool email;
  final bool push;

  NotificationSettings({
    required this.email,
    required this.push,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSettingsToJson(this);
}
