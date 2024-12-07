// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewPasswordRequestBody _$NewPasswordRequestBodyFromJson(
        Map<String, dynamic> json) =>
    NewPasswordRequestBody(
      newPassword: json['newPassword'] as String,
      confirmNewPassword: json['confirmNewPassword'] as String,
      otp: json['otp'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$NewPasswordRequestBodyToJson(
        NewPasswordRequestBody instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
      'otp': instance.otp,
      'email': instance.email,
    };
