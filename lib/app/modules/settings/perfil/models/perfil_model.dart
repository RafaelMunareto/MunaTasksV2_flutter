import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PerfilModel {
  List<Reference>? idStaff;
  bool manager;
  DocumentReference? reference;
  String name;
  String nameTime;

  PerfilModel(
      {this.idStaff,
      this.manager = false,
      this.reference,
      this.name = '',
      this.nameTime = ''});

  factory PerfilModel.fromDocument(DocumentSnapshot doc) {
    return PerfilModel(
      idStaff: doc['idStaff'],
      manager: doc['manager'],
      reference: doc.reference,
      name: doc['name'],
      nameTime: doc['nameTime'],
    );
  }

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
        idStaff: json['idStaff'],
        manager: json['manager'],
        name: json['name'],
        nameTime: json['nameTime']);
  }

  Map<String, dynamic> toJson() => {};
}
