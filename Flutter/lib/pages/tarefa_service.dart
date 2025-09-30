import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tarefa.dart';

class TarefaService {
  static const String baseUrl = 'http://201.23.71.165:8080/api/tarefas/';

  static Future<List<Tarefa>> getTarefas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Tarefa.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar tarefas');
    }
  }

  static Future<Tarefa> createTarefa(Tarefa tarefa) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tarefa.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Tarefa.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao criar tarefa: ${response.body}');
    }
  }

  static Future<Tarefa> updateTarefa(int id, Tarefa tarefa) async {
    final response = await http.put(
      Uri.parse('$baseUrl$id/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tarefa.toJson()),
    );
    if (response.statusCode == 200) {
      return Tarefa.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao atualizar tarefa: ${response.body}');
    }
  }

  static Future<void> deleteTarefa(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id/'));
    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar tarefa: ${response.body}');
    }
  }
}
