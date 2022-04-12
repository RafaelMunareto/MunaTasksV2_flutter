import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class PerfilDioModel {
  List<dynamic>? idStaff;
  dynamic manager;
  String id;
  dynamic name;
  dynamic urlImage;
  dynamic nameTime;

  PerfilDioModel({
    this.idStaff,
    this.manager = false,
    this.id = '',
    this.name = '',
    this.urlImage = '',
    this.nameTime = '',
  });

  factory PerfilDioModel.fromDocument(doc) {
    return PerfilDioModel(
      idStaff: doc['idStaff'],
      manager: doc['manager'],
      id: doc['_id'],
      name: UserDioClientModel.fromJson(doc['name']),
      urlImage: doc['urlImage'] == null
          ? ''
          : DioStruture().baseUrlMunatasks + 'files/' + doc['urlImage'],
      nameTime: doc['nameTime'],
    );
  }

  factory PerfilDioModel.fromJson(Map<String, dynamic> json) {
    return PerfilDioModel(
      id: json['_id'],
      idStaff: json['idStaff'],
      manager: json['manager'],
      name: UserDioClientModel.fromJson(json['name']),
      urlImage: json['urlImage'] == null
          ? ''
          : DioStruture().baseUrlMunatasks + 'files/' + json['urlImage'],
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

  toJsonTime(PerfilDioModel doc) {
    return {
      "idStaff": doc.idStaff!.map((e) => e.id).toList(),
      "manager": doc.manager,
      "name": doc.name.id,
      "nameTime": doc.nameTime,
    };
  }
}
