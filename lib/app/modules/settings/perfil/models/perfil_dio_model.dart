import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class PerfilDioModel {
  List<dynamic>? idStaff;
  dynamic manager;
  String id;
  dynamic name;
  String urlImage;
  String nameTime;

  PerfilDioModel({
    this.idStaff,
    this.manager = false,
    this.id = '',
    this.name = '',
    this.urlImage = '',
    this.nameTime = '',
  });

  factory PerfilDioModel.fromDocument(DocumentSnapshot doc) {
    return PerfilDioModel(
      idStaff: doc['idStaff'],
      manager: doc['manager'],
      id: doc['_id'],
      name: UserDioClientModel.fromJson(doc['name']),
      urlImage: DioStruture().baseUrlMunatasks + 'files/' + doc['urlImage'],
      nameTime: doc['nameTime'],
    );
  }

  factory PerfilDioModel.fromJson(Map<String, dynamic> json) {
    return PerfilDioModel(
      id: json['_id'],
      idStaff: json['idStaff'],
      manager: json['manager'],
      name: UserDioClientModel.fromJson(json['name']),
      urlImage: DioStruture().baseUrlMunatasks + 'files/' + json['urlImage'],
      nameTime: json['nameTime'],
    );
  }

  toJson(PerfilDioModel doc) {
    return {
      "idStaff": doc.idStaff!.map((e) => e['_id']).toList(),
      "manager": doc.manager,
      "name": doc.name.id,
      "nameTime": doc.nameTime,
    };
  }
}
