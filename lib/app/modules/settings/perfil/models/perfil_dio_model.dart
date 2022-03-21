import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_model.dart';

class PerfilDioModel {
  List<dynamic>? idStaff;
  dynamic manager;
  String? id;
  dynamic name;
  String urlImage;
  String perfilUrlImage;
  String nameTime;

  PerfilDioModel(
      {this.idStaff,
      this.manager = false,
      this.id,
      this.name = '',
      this.urlImage = '',
      this.perfilUrlImage = '',
      this.nameTime = ''});

  factory PerfilDioModel.fromDocument(DocumentSnapshot doc) {
    return PerfilDioModel(
      idStaff: doc['idStaff'],
      manager: doc['manager'],
      id: doc['_id'],
      name: UserDioClientModel.fromJson(doc['name']),
      perfilUrlImage: doc['perfilUrlImage'],
      urlImage: doc['urlImage'],
      nameTime: doc['nameTime'],
    );
  }

  factory PerfilDioModel.fromJson(Map<String, dynamic> json) {
    return PerfilDioModel(
      id: json['_id'],
      idStaff: json['idStaff'],
      manager: json['manager'],
      name: UserDioClientModel.fromJson(json['name']),
      perfilUrlImage: json['perfilUrlImage'],
      urlImage: json['urlImage'],
      nameTime: json['nameTime'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
