import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final String role;
  final Avatar? avatar;
  final Avatar? coverImage;
  final bool isActivated;
  final Preferences preferences;
  final NotificationSettings notificationSettings;
  @JsonKey(name: 'socialMedia')
  final Map<String, dynamic> socialMedia;
  final bool isDeleted;
  final bool twoFactorEnabled;
  final String? authProvider;
  final List<dynamic> messages;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.role,
    this.avatar,
    this.coverImage,
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$UserToJson(this);
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    if (coverImage != null) {
      data['coverImage'] = coverImage!.toJson();
    }
    data['preferences'] = preferences.toJson();
    data['notificationSettings'] = notificationSettings.toJson();
    return data;
  }
}

@JsonSerializable(explicitToJson: true)
class Avatar {
  final String? id;
  final String? name;
  final String? url;
  final bool isDeleted;
  final String? createdAt;
  final String? updatedAt;

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
  final bool? isFacebookAuthEnabled;
  final bool? isGoogleAuthEnabled;

  Preferences({
    required this.currency,
    required this.language,
    required this.theme,
    this.isFacebookAuthEnabled,
    this.isGoogleAuthEnabled,
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
