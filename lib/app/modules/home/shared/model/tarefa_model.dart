import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class TarefafaModel {
  String etiqueta;
  DocumentReference? reference;
  String texto;
  String data;
  String tarefa;
  List<User?>? users;
  List<SubtarefaModel>? subTarefa;

  TarefafaModel(
      {this.etiqueta = '',
      this.texto = '',
      this.reference,
      this.data = '',
      this.tarefa = '',
      this.subTarefa,
      this.users});

  factory TarefafaModel.fromDocument(DocumentSnapshot doc) {
    return TarefafaModel(
      etiqueta: doc['etiqueta'],
      texto: doc['texto'],
      reference: doc.reference,
      data: doc['data'],
      tarefa: doc['tarefa'],
      subTarefa: doc['subTarefa'],
      users: doc['user'],
    );
  }

  factory TarefafaModel.fromJson(Map<String, dynamic> json) {
    return TarefafaModel(
        etiqueta: json['etiqueta'],
        texto: json['texto'],
        data: json['data'],
        tarefa: json['tarefa'],
        subTarefa: json['subTarefa'],
        users: json['user']);
  }

  Map<String, dynamic> toJson() => {};
}
