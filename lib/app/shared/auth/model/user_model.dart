import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String name;
  DocumentReference? reference;
  String urlImage;
  bool verificado;

  UserModel({
    this.email = '',
    this.name = '',
    this.urlImage = '',
    this.reference,
    this.verificado = false,
  });

  factory UserModel.fromDocument(dynamic doc) {
    return UserModel(
      email: doc['email'],
      name: doc['name'],
      reference: doc.reference,
      urlImage: doc['urlImage'],
      verificado: doc['verificado'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'urlImage': urlImage,
      'verificado': verificado,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        name: json['name'],
        urlImage: json['urlImage'],
        verificado: json['verificado']);
  }

  Map<String, dynamic> toJson() => {};
}
