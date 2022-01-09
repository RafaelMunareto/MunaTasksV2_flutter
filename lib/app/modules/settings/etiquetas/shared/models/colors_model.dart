import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ColorsModel {
  DocumentReference? reference;
  String color;

  ColorsModel({
    this.color = '',
    this.reference,
  });

  factory ColorsModel.fromDocument(DocumentSnapshot doc) {
    return ColorsModel(color: doc['color'], reference: doc.reference);
  }

  factory ColorsModel.fromJson(Map<String, dynamic> json) {
    return ColorsModel(color: json['color']);
  }

  Map<String, dynamic> toJson() => {};
}
