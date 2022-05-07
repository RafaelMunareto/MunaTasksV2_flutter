import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';

class NotificationsDioModel {
  dynamic id;
  String texto;
  dynamic user;

  NotificationsDioModel({
    this.id,
    this.user,
    this.texto = '',
  });

  factory NotificationsDioModel.fromDocument(doc) {
    return NotificationsDioModel(
      id: doc['id'],
      texto: doc['texto'],
      user: PerfilDioModel.fromJson(doc['user']),
    );
  }

  factory NotificationsDioModel.fromJson(Map<String, dynamic> json) {
    return NotificationsDioModel(
        id: json['title'], texto: json['texto'], user: json['user']);
  }

  Map<String, dynamic> toJson() => {};
}
