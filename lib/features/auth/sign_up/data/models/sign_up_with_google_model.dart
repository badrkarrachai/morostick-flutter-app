class GoogleSignUpRequestBody {
  final String idToken;

  GoogleSignUpRequestBody({
    required this.idToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
    };
  }
}
