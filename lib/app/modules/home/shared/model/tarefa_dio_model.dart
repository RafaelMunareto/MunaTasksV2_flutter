// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';

class TarefaDioModel {
  dynamic etiqueta;
  String? id;
  String texto;
  int fase;
  int prioridade;
  dynamic data;
  List<dynamic>? users;
  List<dynamic>? subTarefa;

  TarefaDioModel(
      {this.etiqueta,
      this.texto = '',
      this.fase = 0,
      this.id,
      this.prioridade = 0,
      this.data,
      this.subTarefa,
      this.users});

  factory TarefaDioModel.fromDocument(DocumentSnapshot doc) {
    return TarefaDioModel(
      etiqueta: doc['etiqueta'],
      texto: doc['texto'],
      fase: doc['fase'],
      prioridade: doc['prioridade'],
      id: doc['_id'],
      data: doc['data'],
      subTarefa: doc['subtarefa'],
      users: doc['users'],
    );
  }

  factory TarefaDioModel.fromJson(Map<String, dynamic> json) {
    return TarefaDioModel(
      etiqueta: EtiquetaDioModel.fromJson(json['etiqueta']),
      texto: json['texto'],
      prioridade: json['prioridade'],
      fase: json['fase'],
      data: json['data'],
      subTarefa: json['subtarefa'],
      users: json['users'],
    );
  }

  @override
  String toString() {
    return '{ ${etiqueta}, ${texto}, ${data}, ${subTarefa}, ${users}}';
  }

  Map<String, dynamic> toMap() {
    return {
      'etiqueta': etiqueta,
      'texto': texto,
      'id': id,
      'fase': fase,
      'prioridade': prioridade,
      'data': data,
      'subTarefa': subTarefa?.map((e) => e.toMap()).toList(),
      'users': users,
    };
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'etiqueta': etiqueta.reference,
      'texto': texto,
      'prioridade': prioridade,
      'fase': fase,
      'id': id,
      'data': data,
      'subTarefa': subTarefa?.map((e) => e.toReverseMap()).toList(),
      'users': users?.map((e) => e.reference).toList(),
    };
  }

  Map<String, dynamic> toJson() => {};
}
