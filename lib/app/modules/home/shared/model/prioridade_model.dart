import 'package:cloud_firestore/cloud_firestore.dart';

class PrioridadeModel {
  int prioridade;
  DocumentReference? reference;
  PrioridadeModel({
    this.prioridade = 0,
    this.reference,
  });

  factory PrioridadeModel.fromDocument(DocumentSnapshot doc) {
    return PrioridadeModel(
        prioridade: doc['prioridade'], reference: doc.reference);
  }

  factory PrioridadeModel.fromJson(Map<String, dynamic> json) {
    return PrioridadeModel(prioridade: json['prioridade']);
  }

  Map<String, dynamic> toMap() {
    return {'prioridade': prioridade};
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'prioridade': prioridade,
    };
  }

  Map<String, dynamic> toJson() => {};
}
