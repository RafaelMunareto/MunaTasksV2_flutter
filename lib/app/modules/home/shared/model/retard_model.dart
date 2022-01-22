import 'package:cloud_firestore/cloud_firestore.dart';

class RetardModel {
  String tempoName;
  int tempoValue;
  DocumentReference? reference;
  RetardModel({this.tempoName = '', this.tempoValue = 0, this.reference});

  factory RetardModel.fromDocument(DocumentSnapshot doc) {
    return RetardModel(
        tempoName: doc['tempoName'],
        tempoValue: doc['tempoValue'],
        reference: doc.reference);
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
