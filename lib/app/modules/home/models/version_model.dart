import 'package:cloud_firestore/cloud_firestore.dart';

class VersionModel {
  String title;
  bool check;
  DocumentReference? reference;
  int? position;
  int? id;

  VersionModel(
      {this.title = '',
        this.check = false,
        this.reference,
        this.id,
        this.position});

  factory VersionModel.fromDocument(DocumentSnapshot doc) {
    return VersionModel(
      check: doc['check'],
      title: doc['title'],
      reference: doc.reference,
      position: doc['position'],
    );
  }

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
        check: json['check'], title: json['title'], id: json['id']);
  }

  Map<String, dynamic> toJson() => {};
}