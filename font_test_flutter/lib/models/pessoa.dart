class Pessoa {
  int id;
  String nome;

  Pessoa({required this.id, required this.nome});

  // Converter JSON para objeto
  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      id: json['id'],
      nome: json['nome'],
    );
  }

  // Converter objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }
}