class User {
  final int id;
  final String email;
  final String username;
  final String password;


  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  // Construtor que cria um User a partir de um JSON da API
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['name'] ?? '',
      password: json['password'] ?? 1,

    );
  }

  // Converter User para JSON (útil para enviar dados à API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': username,
      'email': email,
    };
  }
}
