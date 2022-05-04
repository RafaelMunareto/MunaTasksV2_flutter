import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';

class TarefaDioModel {
  dynamic etiqueta;
  String? id;
  String texto;
  int fase;
  int prioridade;
  dynamic data;
  List<dynamic>? users;
  List<dynamic>? subTarefa;

  TarefaDioModel(
      {this.etiqueta,
      this.texto = '',
      this.fase = 0,
      this.id,
      this.prioridade = 0,
      this.data,
      this.subTarefa,
      this.users});

  factory TarefaDioModel.fromDocument(doc) {
    return TarefaDioModel(
      etiqueta: EtiquetaDioModel.fromJson(doc['etiqueta']),
      texto: doc['texto'],
      fase: doc['fase'],
      prioridade: doc['prioridade'],
      id: doc['id'],
      data: doc['data'],
      subTarefa: doc['subtarefa'],
      users: doc['users'],
    );
  }

  factory TarefaDioModel.fromJson(Map<String, dynamic> json) {
    return TarefaDioModel(
      etiqueta: EtiquetaDioModel.fromJson(json['etiqueta']),
      texto: json['texto'],
      prioridade: json['prioridade'],
      fase: json['fase'],
      id: json['id'],
      data: json['data'],
      subTarefa: json['subtarefa'],
      users: json['users'],
    );
  }
  toJson(TarefaDioModel doc) {
    return {
      "etiqueta": doc.etiqueta.id,
      "texto": doc.texto,
      "prioridade": doc.prioridade,
      "fase": doc.fase,
      "data": doc.data.toString(),
      "subtarefa": doc.subTarefa!.map((element) {
        return {
          "id": element.id,
          "title": element.title,
          "status": element.status,
          "texto": element.texto,
          "user": element.user.id
        };
      }).toList(),
      "users": doc.users!.map((e) => e.id).toList(),
    };
  }
}
