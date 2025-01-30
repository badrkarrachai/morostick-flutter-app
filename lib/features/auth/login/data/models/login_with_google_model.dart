class GoogleSignInRequestBody {
  final String accessToken;

  GoogleSignInRequestBody({
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
    };
  }
}
