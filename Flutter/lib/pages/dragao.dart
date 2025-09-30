class Dragao {
  final int id;
  final String name;
  final int nivel;
  final String? cor;
  final String? tipo;
  final int poder;

  Dragao({
    required this.id,
    required this.name,
    required this.nivel,
    this.cor,
    this.tipo,
    required this.poder,
  });

  factory Dragao.fromJson(Map<String, dynamic> json) {
    return Dragao(
      id: json['ID_dragao'] ?? 0,
      name: json['Name'] ?? '',
      nivel: json['Nivel'] ?? 0,
      cor: json['Cor'],
      tipo: json['Tipo'],
      poder: json['Poder'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Nivel': nivel,
      'Cor': cor,
      'Tipo': tipo,
      'Poder': poder,
    };
  }
}
