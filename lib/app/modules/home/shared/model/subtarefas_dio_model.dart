import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';

class SubtarefasDioModel {
  dynamic id;
  String title;
  String status;
  String texto;
  dynamic user;

  SubtarefasDioModel({
    this.id = '',
    this.title = '',
    this.status = '',
    this.user,
    this.texto = '',
  });

  factory SubtarefasDioModel.fromDocument(doc) {
    return SubtarefasDioModel(
      id: doc['id'],
      title: doc['title'],
      status: doc['status'],
      texto: doc['texto'],
      user: doc['texto'],
    );
  }

  factory SubtarefasDioModel.fromJson(Map<String, dynamic> json) {
    return SubtarefasDioModel(
        id: json['id'],
        title: json['title'],
        status: json['status'],
        texto: json['texto'],
        user: PerfilDioModel.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() => {};
}
