import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class ApiService {
  static const String baseUrl = "http://201.23.71.165:8080/api";

  // LOGIN
static Future<User> login(String email, String password) async {
  final url = Uri.parse("$baseUrl/users/");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List users = jsonDecode(response.body);
    final match = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => null,
    );

    if (match != null) {
      return User.fromJson(match);
    } else {
      throw Exception("Email ou senha inválidos");
    }
  } else {
    throw Exception("Erro ao buscar usuários: ${response.body}");
  }
}


// REGISTRO
static Future<User> register(String email, String password, String username) async {
  final url = Uri.parse("$baseUrl/users/");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
      "name": username,
    }),
  );

  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body)); // retorna User direto
  } else {
    throw Exception("Erro ao registrar: ${response.body}");
  }
}

  // PEGAR USUÁRIO LOGADO
  static Future<User> getProfile(String token) async {
    final url = Uri.parse("$baseUrl/profile/");
    final response = await http.get(url, headers: {"Authorization": "Token $token"});
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao buscar perfil: ${response.body}");
    }
  }

  // OUTROS ENDPOINTS
  static Future<List<dynamic>> getDragoes() async {
    final url = Uri.parse("$baseUrl/dragoes/");
    final response = await http.get(url);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Erro ao buscar dragões");
  }
}
