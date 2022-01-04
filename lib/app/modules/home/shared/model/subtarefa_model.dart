import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class SubtarefaModel {
  String title;
  DocumentReference? reference;
  String status;
  String texto;
  dynamic user;

  SubtarefaModel({
    this.title = '',
    this.status = '',
    this.user = '',
    this.reference,
    this.texto = '',
  });

  factory SubtarefaModel.fromDocument(DocumentSnapshot doc) {
    return SubtarefaModel(
        title: doc['title'],
        status: doc['status'],
        reference: doc.reference,
        texto: doc['texto'],
        user: doc['user']);
  }

  factory SubtarefaModel.fromJson(Map<String, dynamic> json) {
    return SubtarefaModel(
        title: json['title'],
        status: json['status'],
        texto: json['texto'],
        user: json['user']);
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'status': status, 'texto': texto, 'user': user};
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'title': title,
      'status': status,
      'texto': texto,
      'user': user.reference
    };
  }

  Map<String, dynamic> toJson() => {};
}
