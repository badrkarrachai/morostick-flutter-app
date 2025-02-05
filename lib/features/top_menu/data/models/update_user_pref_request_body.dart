class UpdateUserPrefRequestBody {
  final bool isGoogleAuthEnabled;
  final bool isFacebookAuthEnabled;

  UpdateUserPrefRequestBody({
    required this.isGoogleAuthEnabled,
    required this.isFacebookAuthEnabled,
  });

  Map<String, dynamic> toJson() {
    return {
      'isGoogleAuthEnabled': isGoogleAuthEnabled,
      'isFacebookAuthEnabled': isFacebookAuthEnabled,
    };
  }
}
