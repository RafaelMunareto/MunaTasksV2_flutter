import 'package:cloud_firestore/cloud_firestore.dart';

class FaseModel {
  String status;
  String name;
  String color;
  int icon;
  DocumentReference? reference;
  FaseModel({
    this.status = '',
    this.name = '',
    this.color = 'grey',
    this.icon = 0,
    this.reference,
  });

  factory FaseModel.fromDocument(DocumentSnapshot doc) {
    return FaseModel(
        status: doc['status'],
        name: doc['name'],
        color: doc['color'],
        icon: doc['icon'],
        reference: doc.reference);
  }

  factory FaseModel.fromJson(Map<String, dynamic> json) {
    return FaseModel(
      status: json['status'],
      name: json['name'],
      color: json['color'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'color': color,
      'icon': icon,
    };
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'status': status,
      'name': name,
      'color': color,
      'icon': icon,
    };
  }

  Map<String, dynamic> toJson() => {};
}
