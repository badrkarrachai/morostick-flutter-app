class UpdateNameRequestBody {
  final String name;
  final String email;

  UpdateNameRequestBody({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
