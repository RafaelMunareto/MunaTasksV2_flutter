class SubtarefasQtdModel {
  String name;
  String urlImage;
  int qtdSubtarefa;

  SubtarefasQtdModel({
    this.name = '',
    this.urlImage = '',
    this.qtdSubtarefa = 0,
  });

  factory SubtarefasQtdModel.fromDocument(doc) {
    return SubtarefasQtdModel(
      name: doc['name'],
      urlImage: doc['urlImage'],
      qtdSubtarefa: doc['qtdSubtarefa'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
