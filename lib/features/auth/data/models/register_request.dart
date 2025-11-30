class RegisterRequest {
  final String name;
  final String email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  String toJsonString() {
    return "{  \"name\": \"${name}\",\n  \"email\": \"${email}\",\n  \"password\": \"${password}\"\n}";
  }
}
