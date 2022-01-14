import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String grupo;
  DocumentReference? reference;
  OrderModel({
    this.grupo = '',
    this.reference,
  });

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    return OrderModel(grupo: doc['grupo'], reference: doc.reference);
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(grupo: json['grupo']);
  }

  Map<String, dynamic> toMap() {
    return {'grupo': grupo};
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'grupo': grupo,
    };
  }

  Map<String, dynamic> toJson() => {};
}
