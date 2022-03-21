// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class TarefaTotaisModel {
  List<dynamic>? etiqueta;
  UserModel? users;
  int total;

  TarefaTotaisModel({
    this.etiqueta,
    this.users,
    this.total = 0,
  });

  factory TarefaTotaisModel.fromDocument(DocumentSnapshot doc) {
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
