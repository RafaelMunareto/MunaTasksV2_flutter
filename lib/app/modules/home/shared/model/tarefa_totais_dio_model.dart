// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';

class TarefaTotaisModel {
  List<dynamic>? etiqueta;
  UserDioClientModel? users;
  int total;

  TarefaTotaisModel({
    this.etiqueta,
    this.users,
    this.total = 0,
  });

  factory TarefaTotaisModel.fromDocument(doc) {
    return TarefaTotaisModel(
      etiqueta: doc['etiqueta'],
      users: doc['users'],
      total: doc['total'],
    );
  }

  factory TarefaTotaisModel.fromJson(Map<String, dynamic> json) {
    return TarefaTotaisModel(
      etiqueta: json['etiqueta'],
      users: json['users'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
