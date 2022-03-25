import 'package:cloud_firestore/cloud_firestore.dart';

class RetardModel {
  String tempoName;
  int tempoValue;
  String? id;
  RetardModel({this.tempoName = '', this.tempoValue = 0, this.id});

  factory RetardModel.fromDocument(DocumentSnapshot doc) {
    return RetardModel(
      tempoName: doc['tempoName'],
      tempoValue: doc['tempoValue'],
      id: doc['id'],
    );
  }

  factory RetardModel.fromJson(Map<String, dynamic> json) {
    return RetardModel(
        tempoName: json['tempoName'], tempoValue: json['tempoValue']);
  }

  Map<String, dynamic> toMap() {
    return {'tempoName': tempoName, 'tempoValue': tempoValue};
  }

  Map<String, dynamic> toReverseMap() {
    return {'tempoName': tempoName, 'tempoValue': tempoValue};
  }

  Map<String, dynamic> toJson() => {};
}
