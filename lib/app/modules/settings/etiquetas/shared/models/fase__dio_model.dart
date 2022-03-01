import 'package:cloud_firestore/cloud_firestore.dart';

class FaseDioModel {
  String? id;
  String color;
  String name;
  int? icon;
  String status;

  FaseDioModel(
      {this.id = '',
      this.color = '',
      this.name = '',
      this.icon,
      this.status = ''});

  factory FaseDioModel.fromDocument(DocumentSnapshot doc) {
    return FaseDioModel(
      id: doc['_id'],
      color: doc['color'],
      name: doc['name'],
      icon: doc['icon'],
      status: doc['status'],
    );
  }

  factory FaseDioModel.fromJson(Map<String, dynamic> json) {
    return FaseDioModel(
      id: json['_id'],
      color: json['color'],
      name: json['name'],
      icon: json['icon'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
