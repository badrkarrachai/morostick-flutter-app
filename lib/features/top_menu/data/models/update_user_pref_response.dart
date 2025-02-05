// search_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'update_user_pref_response.g.dart';

@JsonSerializable()
class UpdateUserPrefResponse extends GeneralResponse {
  PreferencesData? get preferencesData {
    if (data == null) return null;
    return PreferencesData.fromJson(
        data['preferences'] as Map<String, dynamic>);
  }

  const UpdateUserPrefResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory UpdateUserPrefResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPrefResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateUserPrefResponseToJson(this);
}

@JsonSerializable()
class PreferencesData {
  final String? currency;
  final String? language;
  final String? theme;
  final bool? isFacebookAuthEnabled;
  final bool? isGoogleAuthEnabled;

  const PreferencesData({
    this.currency,
    this.language,
    this.theme,
    this.isFacebookAuthEnabled,
    this.isGoogleAuthEnabled,
  });

  factory PreferencesData.fromJson(Map<String, dynamic> json) =>
      _$PreferencesDataFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesDataToJson(this);
}
