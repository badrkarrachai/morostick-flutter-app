class GoogleSignUpRequestBody {
  final String accessToken;

  GoogleSignUpRequestBody({
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
    };
  }
}
