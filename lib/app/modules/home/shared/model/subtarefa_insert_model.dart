import 'package:cloud_firestore/cloud_firestore.dart';

class SubtarefaInsertModel {
  String subtarefa;
  DocumentReference? reference;
  SubtarefaInsertModel({
    this.subtarefa = '',
    this.reference,
  });

  factory SubtarefaInsertModel.fromDocument(DocumentSnapshot doc) {
    return SubtarefaInsertModel(
        subtarefa: doc['subtarefa'], reference: doc.reference);
  }

  factory SubtarefaInsertModel.fromJson(Map<String, dynamic> json) {
    return SubtarefaInsertModel(subtarefa: json['subtarefa']);
  }

  Map<String, dynamic> toMap() {
    return {'subtarefa': subtarefa};
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'subtarefa': subtarefa,
    };
  }

  Map<String, dynamic> toJson() => {};
}
