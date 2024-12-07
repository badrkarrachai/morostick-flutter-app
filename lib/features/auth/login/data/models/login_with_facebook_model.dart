class FacebookSignInRequestBody {
  final String accessToken;

  FacebookSignInRequestBody({
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
    };
  }
}
