class FacebookSignUpRequestBody {
  final String accessToken;

  FacebookSignUpRequestBody({
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
    };
  }
}
