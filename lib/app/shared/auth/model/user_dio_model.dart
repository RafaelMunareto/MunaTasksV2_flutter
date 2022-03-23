import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';

class UserDioModel {
  dynamic user;
  dynamic token;

  UserDioModel({
    this.user,
    this.token,
  });

  factory UserDioModel.fromDocument(doc) {
    return UserDioModel(
      user: doc['user'],
      token: doc['token'],
    );
  }

  factory UserDioModel.fromJson(Map<String, dynamic> json) {
    return UserDioModel(
      user: UserDioClientModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {'user': user, 'token': token};
}
