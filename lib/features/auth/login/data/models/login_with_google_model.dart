class GoogleSignInRequestBody {
  final String idToken;

  GoogleSignInRequestBody({
    required this.idToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
    };
  }
}
