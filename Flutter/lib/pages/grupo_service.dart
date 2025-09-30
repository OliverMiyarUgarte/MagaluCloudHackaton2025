import 'dart:convert';
import 'package:http/http.dart' as http;
import 'grupo.dart';

class GrupoService {
  static const String baseUrl = 'http://201.23.71.165:8080/api/grupos/';
  static const String joinBaseUrl = 'http://201.23.71.165:8080/api/tug/'; // endpoint de associação usuário-grupo

  // Listar todos os grupos
  static Future<List<Grupo>> getGrupos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Grupo.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar grupos: ${response.statusCode}');
    }
  }

  // Criar um grupo
  static Future<Grupo> createGrupo(Grupo grupo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(grupo.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Grupo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao criar grupo: ${response.body}');
    }
  }

  // Atualizar grupo
  static Future<Grupo> updateGrupo(int id, Grupo grupo) async {
    final response = await http.put(
      Uri.parse('$baseUrl$id/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(grupo.toJson()),
    );
    if (response.statusCode == 200) {
      return Grupo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao atualizar grupo: ${response.body}');
    }
  }

  // Deletar grupo
  static Future<void> deleteGrupo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id/'));
    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar grupo: ${response.body}');
    }
  }

  // Entrar em um grupo (associar usuário ao grupo)
  static Future<void> joinGrupo(int userId, int grupoId) async {
    final response = await http.post(
      Uri.parse(joinBaseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ID_user': userId, 'ID_grupo': grupoId}),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao entrar no grupo: ${response.body}');
    }
  }
}
