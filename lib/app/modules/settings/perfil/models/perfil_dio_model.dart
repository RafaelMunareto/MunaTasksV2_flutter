import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_model.dart';

class PerfilDioModel {
  List<dynamic>? idStaff;
  dynamic manager;
  String? id;
  dynamic name;
  String urlImage;
  String nameTime;

  PerfilDioModel(
      {this.idStaff,
      this.manager = false,
      this.id,
      this.name = '',
      this.urlImage = '',
      this.nameTime = ''});

  factory PerfilDioModel.fromDocument(DocumentSnapshot doc) {
    return PerfilDioModel(
      idStaff: doc['idStaff'],
      manager: doc['manager'],
      id: doc['_id'],
      name: doc['name'],
      urlImage: doc['perfilUrlImage'],
      nameTime: doc['nameTime'],
    );
  }

  factory PerfilDioModel.fromJson(Map<String, dynamic> json) {
    return PerfilDioModel(
      idStaff: json['idStaff'],
      manager: json['manager'],
      name: UserDioModel.fromJson(json['name']),
      urlImage: json['perfilUrlImage'],
      nameTime: json['nameTime'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
