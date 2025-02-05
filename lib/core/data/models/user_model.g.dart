// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      isActivated: json['isActivated'] as bool,
      preferences:
          Preferences.fromJson(json['preferences'] as Map<String, dynamic>),
      notificationSettings: NotificationSettings.fromJson(
          json['notificationSettings'] as Map<String, dynamic>),
      socialMedia: json['socialMedia'] as Map<String, dynamic>,
      isDeleted: json['isDeleted'] as bool,
      twoFactorEnabled: json['twoFactorEnabled'] as bool,
      authProvider: json['authProvider'] as String?,
      messages: json['messages'] as List<dynamic>,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'avatar': instance.avatar?.toJson(),
      'isActivated': instance.isActivated,
      'preferences': instance.preferences.toJson(),
      'notificationSettings': instance.notificationSettings.toJson(),
      'socialMedia': instance.socialMedia,
      'isDeleted': instance.isDeleted,
      'twoFactorEnabled': instance.twoFactorEnabled,
      'authProvider': instance.authProvider,
      'messages': instance.messages,
    };

Avatar _$AvatarFromJson(Map<String, dynamic> json) => Avatar(
      id: json['id'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      isDeleted: json['isDeleted'] as bool,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      currency: json['currency'] as String?,
      language: json['language'] as String?,
      theme: json['theme'] as String?,
      isFacebookAuthEnabled: json['isFacebookAuthEnabled'] as bool?,
      isGoogleAuthEnabled: json['isGoogleAuthEnabled'] as bool?,
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'language': instance.language,
      'theme': instance.theme,
      'isFacebookAuthEnabled': instance.isFacebookAuthEnabled,
      'isGoogleAuthEnabled': instance.isGoogleAuthEnabled,
    };

NotificationSettings _$NotificationSettingsFromJson(
        Map<String, dynamic> json) =>
    NotificationSettings(
      email: json['email'] as bool,
      push: json['push'] as bool,
    );

Map<String, dynamic> _$NotificationSettingsToJson(
        NotificationSettings instance) =>
    <String, dynamic>{
      'email': instance.email,
      'push': instance.push,
    };
