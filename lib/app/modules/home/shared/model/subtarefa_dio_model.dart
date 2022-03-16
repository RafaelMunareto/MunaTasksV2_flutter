import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';

class SubtareDiofaModel {
  String title;
  String status;
  String texto;
  dynamic user;

  SubtareDiofaModel({
    this.title = '',
    this.status = '',
    this.user,
    this.texto = '',
  });

  factory SubtareDiofaModel.fromDocument(DocumentSnapshot doc) {
    return SubtareDiofaModel(
      title: doc['title'],
      status: doc['status'],
      texto: doc['texto'],
      user: doc['texto'],
    );
  }

  factory SubtareDiofaModel.fromJson(Map<String, dynamic> json) {
    return SubtareDiofaModel(
        title: json['title'],
        status: json['status'],
        texto: json['texto'],
        user: UserDioClientModel.fromJson(json['user']));
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'status': status, 'texto': texto, 'user': user};
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'title': title,
      'status': status,
      'texto': texto,
      'user': user,
    };
  }

  Map<String, dynamic> toJson() => {};
}
