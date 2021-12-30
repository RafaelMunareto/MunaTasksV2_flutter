import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubtarefaModel {
  String title;
  DocumentReference? reference;
  String status;
  String texto;
  User? user;

  SubtarefaModel({
    this.title = '',
    this.status = '',
    this.user,
    this.reference,
    this.texto = '',
  });

  factory SubtarefaModel.fromDocument(DocumentSnapshot doc) {
    return SubtarefaModel(
        title: doc['title'],
        status: doc['status'],
        reference: doc.reference,
        texto: doc['texto']);
  }

  factory SubtarefaModel.fromJson(Map<String, dynamic> json) {
    return SubtarefaModel(
        title: json['title'],
        status: json['status'],
        texto: json['texto'],
        user: json['users']);
  }

  Map<String, dynamic> toJson() => {};
}
