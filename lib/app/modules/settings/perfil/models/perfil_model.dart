import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilModel {
  List<dynamic>? idStaff;
  bool manager;
  DocumentReference? reference;
  String name;
  String urlImage;
  String nameTime;

  PerfilModel(
      {this.idStaff,
      this.manager = false,
      this.reference,
      this.name = '',
      this.urlImage = '',
      this.nameTime = ''});

  factory PerfilModel.fromDocument(DocumentSnapshot doc) {
    return PerfilModel(
      idStaff: doc['idStaff'],
      manager: doc['manager'],
      reference: doc.reference,
      name: doc['name'],
      urlImage: doc['urlImage'],
      nameTime: doc['nameTime'],
    );
  }

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
        idStaff: json['idStaff'],
        manager: json['manager'],
        name: json['name'],
        urlImage: json['urlImage'],
        nameTime: json['nameTime']);
  }

  Map<String, dynamic> toJson() => {};
}
