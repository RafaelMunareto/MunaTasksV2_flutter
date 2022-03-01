import 'package:cloud_firestore/cloud_firestore.dart';

class RetardDioModel {
  String? id;
  String tempoName;
  int? tempoValue;

  RetardDioModel({
    this.id = '',
    this.tempoName = '',
    this.tempoValue,
  });

  factory RetardDioModel.fromDocument(DocumentSnapshot doc) {
    return RetardDioModel(
      id: doc['_id'],
      tempoName: doc['tempoName'],
      tempoValue: doc['tempoValue'],
    );
  }

  factory RetardDioModel.fromJson(Map<String, dynamic> json) {
    return RetardDioModel(
      id: json['_id'],
      tempoName: json['color'],
      tempoValue: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
