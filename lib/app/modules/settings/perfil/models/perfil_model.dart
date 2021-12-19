import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilModel {
  List<dynamic>? idStaff;
  bool manager;
  DocumentReference? reference;
  String name;
  String urlPhoto;
  String nameTime;

  PerfilModel(
      {this.idStaff,
      this.manager = false,
      this.reference,
      this.name = '',
      this.urlPhoto = '',
      this.nameTime = ''});

  factory PerfilModel.fromDocument(DocumentSnapshot doc) {
    return PerfilModel(
      idStaff: doc['idStaff'],
      manager: doc['manager'],
      reference: doc.reference,
      name: doc['name'],
      urlPhoto: doc['urlPhoto'],
      nameTime: doc['nameTime'],
    );
  }

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
        idStaff: json['idStaff'],
        manager: json['manager'],
        name: json['name'],
        urlPhoto: json['urlPhoto'],
        nameTime: json['nameTime']);
  }

  Map<String, dynamic> toJson() => {};
}
