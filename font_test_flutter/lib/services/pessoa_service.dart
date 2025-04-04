import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pessoa.dart';

class PessoaService {
  final String baseUrl = "http://localhost:8080/pessoas"; // Backend

  // Listar todas as pessoas
  Future<List<Pessoa>> getPessoas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => Pessoa.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao buscar pessoas");
    }
  }

  // Adicionar pessoa
  Future<Pessoa> addPessoa(String nome) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"nome": nome}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Pessoa.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao adicionar pessoa");
    }
  }
}
