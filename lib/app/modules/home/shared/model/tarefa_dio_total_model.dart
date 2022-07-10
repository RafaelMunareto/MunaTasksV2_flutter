class TarefaDioTotalModel {
  String? id;
  dynamic name;
  int qtd;
  int qtdSubtarefas;

  TarefaDioTotalModel({
    this.id,
    this.name,
    this.qtd = 0,
    this.qtdSubtarefas = 0,
  });

  factory TarefaDioTotalModel.fromDocument(doc) {
    return TarefaDioTotalModel(
        id: doc['id'],
        name: doc['name'],
        qtd: doc['qtd'],
        qtdSubtarefas: doc['qtdSubtarefas']);
  }

  factory TarefaDioTotalModel.fromJson(Map<String, dynamic> json) {
    return TarefaDioTotalModel(
        id: json['id'],
        name: json['name'],
        qtd: json['qtd'],
        qtdSubtarefas: json['qtdSubtarefas']);
  }

  Map<String, dynamic> toJson() => {};
}
