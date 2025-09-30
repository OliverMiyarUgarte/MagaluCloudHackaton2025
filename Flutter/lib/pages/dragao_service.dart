import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dragao.dart';

class DragaoService {
  static const String baseUrl = 'http://201.23.71.165:8080/api/dragoes/';

  static Future<List<Dragao>> getDragoes() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Dragao.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar dragoes');
    }
  }

  static Future<Dragao> createDragao(Dragao dragao) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dragao.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Dragao.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao criar dragão: ${response.body}');
    }
  }

  static Future<Dragao> updateDragao(int id, Dragao dragao) async {
    final response = await http.put(
      Uri.parse('$baseUrl$id/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dragao.toJson()),
    );
    if (response.statusCode == 200) {
      return Dragao.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao atualizar dragão: ${response.body}');
    }
  }

  static Future<void> deleteDragao(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id/'));
    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar dragão: ${response.body}');
    }
  }
}
