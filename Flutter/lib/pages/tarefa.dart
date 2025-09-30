class Tarefa {
  final int id;
  final bool concluida;
  final int tempo;
  final int idGrupo;

  Tarefa({
    required this.id,
    required this.concluida,
    required this.tempo,
    required this.idGrupo,
  });

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['ID_Tarefa'] ?? 0,
      concluida: json['Concluida'] ?? false,
      tempo: json['Tempo'] ?? 0,
      idGrupo: json['ID_grupo'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Concluida': concluida,
      'Tempo': tempo,
      'ID_grupo': idGrupo,
    };
  }
}
