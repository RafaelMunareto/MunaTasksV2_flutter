import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  String? id;
  List? color;
  List? fase;
  List? order;
  List? prioridade;
  List? retard;
  List? subtarefaInsert;
  int? version;

  SettingsModel({
    this.id,
    this.color,
    this.fase,
    this.order,
    this.prioridade,
    this.retard,
    this.subtarefaInsert,
    this.version,
  });

  factory SettingsModel.fromDocument(DocumentSnapshot doc) {
    return SettingsModel(
      id: doc['_id'],
      color: doc['color'],
      fase: doc['fase'],
      order: doc['order'],
      prioridade: doc['prioridade'],
      retard: doc['retard'],
      subtarefaInsert: doc['subtarefaInsert'],
      version: doc['version'],
    );
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['_id'],
      color: json['color'],
      fase: json['fase'],
      order: json['order'],
      prioridade: json['prioridade'],
      retard: json['retard'],
      subtarefaInsert: json['subtarefaInsert'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
