// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewPasswordData _$NewPasswordDataFromJson(Map<String, dynamic> json) =>
    NewPasswordData(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewPasswordDataToJson(NewPasswordData instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };
