class Grupo {
  final int id;
  final int nuser;
  final String name;

  Grupo({
    required this.id,
    required this.nuser,
    required this.name,
  });

  // Construtor que cria Grupo a partir de JSON da API
  factory Grupo.fromJson(Map<String, dynamic> json) {
    return Grupo(
      id: json['ID_grupo'] is int ? json['ID_grupo'] : int.tryParse(json['ID_grupo'].toString()) ?? 0,
      nuser: json['Nuser'] is int ? json['Nuser'] : int.tryParse(json['Nuser'].toString()) ?? 0,
      name: json['Name']?.toString() ?? '',
    );
  }

  // Converte Grupo para JSON (para enviar à API)
  Map<String, dynamic> toJson() {
    return {
      'Nuser': nuser,
      'Name': name,
    };
  }

  // Se necessário, cria cópia com modificações
  Grupo copyWith({int? id, int? nuser, String? name}) {
    return Grupo(
      id: id ?? this.id,
      nuser: nuser ?? this.nuser,
      name: name ?? this.name,
    );
  }
}
