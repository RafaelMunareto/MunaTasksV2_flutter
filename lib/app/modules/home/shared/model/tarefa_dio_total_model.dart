class TarefaDioTotalModel {
  String? id;
  dynamic name;
  dynamic qtd;
  List<dynamic>? tarefa;

  TarefaDioTotalModel({
    this.id,
    this.name,
    this.qtd,
    this.tarefa,
  });

  factory TarefaDioTotalModel.fromDocument(doc) {
    return TarefaDioTotalModel(
        id: doc['id'],
        name: doc['name'],
        qtd: doc['qtd'],
        tarefa: doc['tarefa']);
  }

  factory TarefaDioTotalModel.fromJson(Map<String, dynamic> json) {
    return TarefaDioTotalModel(
        id: json['id'],
        name: json['name'],
        qtd: json['qtd'],
        tarefa: json['tarefa']);
  }

  Map<String, dynamic> toJson() => {};
}
