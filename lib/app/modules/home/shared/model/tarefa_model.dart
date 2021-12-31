import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class TarefaModel {
  String etiqueta;
  DocumentReference? reference;
  String texto;
  String data;
  List<UserModel?>? users;
  List<SubtarefaModel>? subTarefa;

  TarefaModel(
      {this.etiqueta = '',
      this.texto = '',
      this.reference,
      this.data = '',
      this.subTarefa,
      this.users});

  factory TarefaModel.fromDocument(DocumentSnapshot doc) {
    return TarefaModel(
      etiqueta: doc['etiqueta'],
      texto: doc['texto'],
      reference: doc.reference,
      data: doc['data'],
      subTarefa: doc['subTarefa'],
      users: doc['user'],
    );
  }

  factory TarefaModel.fromJson(Map<String, dynamic> json) {
    return TarefaModel(
        etiqueta: json['etiqueta'],
        texto: json['texto'],
        data: json['data'],
        subTarefa: json['subTarefa'],
        users: json['user']);
  }

  Map<String, dynamic> toJson() => {};
}
