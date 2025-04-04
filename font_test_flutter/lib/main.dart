import 'package:flutter/material.dart';
import 'services/pessoa_service.dart';
import 'models/pessoa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Pessoas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PessoaService _pessoaService = PessoaService();
  final TextEditingController _nomeController = TextEditingController();
  List<Pessoa> _pessoas = [];

  @override
  void initState() {
    super.initState();
    _carregarPessoas();
  }

  void _carregarPessoas() async {
    try {
      List<Pessoa> pessoas = await _pessoaService.getPessoas();
      setState(() {
        _pessoas = pessoas;
      });
    } catch (e) {
      print("Erro ao carregar pessoas: $e");
    }
  }

  void _adicionarPessoa() async {
    String nome = _nomeController.text.trim();
    if (nome.isNotEmpty) {
      try {
        await _pessoaService.addPessoa(nome);
        _nomeController.clear();
        _carregarPessoas();
      } catch (e) {
        print("Erro ao adicionar pessoa: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Pessoas")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _adicionarPessoa,
                  child: Text("Adicionar"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _pessoas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_pessoas[index].nome),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
