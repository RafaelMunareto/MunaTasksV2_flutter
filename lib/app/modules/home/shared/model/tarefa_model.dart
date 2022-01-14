// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';

class TarefaModel {
  dynamic etiqueta;
  DocumentReference? reference;
  String texto;
  int fase;
  int prioridade;
  dynamic data;
  List<dynamic>? users;
  List<dynamic>? subTarefa;

  TarefaModel(
      {this.etiqueta = '',
      this.texto = '',
      this.fase = 0,
      this.reference,
      this.prioridade = 0,
      this.data,
      this.subTarefa,
      this.users});

  factory TarefaModel.fromDocument(DocumentSnapshot doc) {
    return TarefaModel(
      etiqueta: doc['etiqueta'],
      texto: doc['texto'],
      fase: doc['fase'],
      prioridade: doc['prioridade'],
      reference: doc.reference,
      data: doc['data'],
      subTarefa:
          doc['subTarefa']?.map((doc) => SubtarefaModel.fromJson(doc)).toList(),
      users: doc['users'],
    );
  }

  factory TarefaModel.fromJson(Map<String, dynamic> json) {
    return TarefaModel(
        etiqueta: json['etiqueta'],
        texto: json['texto'],
        prioridade: json['prioridade'],
        fase: json['fase'],
        data: json['data'],
        subTarefa: json['subTarefa'],
        users: json['users']);
  }

  @override
  String toString() {
    return '{ ${etiqueta}, ${texto}, ${data}, ${subTarefa}, ${users}}';
  }

  Map<String, dynamic> toMap() {
    return {
      'etiqueta': etiqueta,
      'texto': texto,
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
      'data': data,
      'subTarefa': subTarefa?.map((e) => e.toReverseMap()).toList(),
      'users': users?.map((e) => e.reference).toList(),
    };
  }

  Map<String, dynamic> toJson() => {};
}
