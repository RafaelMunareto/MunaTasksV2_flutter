// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class TarefaModel {
  String etiqueta;
  DocumentReference? reference;
  String texto;
  int fase;
  String data;
  List<dynamic>? users;
  List<dynamic>? subTarefa;

  TarefaModel(
      {this.etiqueta = '',
      this.texto = '',
      this.fase = 0,
      this.reference,
      this.data = '',
      this.subTarefa,
      this.users});

  factory TarefaModel.fromDocument(DocumentSnapshot doc) {
    return TarefaModel(
      etiqueta: doc['etiqueta'],
      texto: doc['texto'],
      fase: doc['fase'],
      reference: doc.reference,
      data: doc['data'],
      subTarefa:
          doc['subTarefa']?.map((doc) => SubtarefaModel.fromJson(doc)).toList(),
      users: doc['users']?.map((doc) => UserModel.fromJson(doc)).toList(),
    );
  }

  factory TarefaModel.fromJson(Map<String, dynamic> json) {
    return TarefaModel(
        etiqueta: json['etiqueta'],
        texto: json['texto'],
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
      'data': data,
      'subTarefa': subTarefa?.map((e) => e.toMap()).toList(),
      'users': users?.map((e) => e.toMap()).toList(),
    };
  }

  Map<String, dynamic> toReverseMap() {
    return {
      'etiqueta': etiqueta,
      'texto': texto,
      'fase': fase,
      'data': data,
      'subTarefa': subTarefa?.map((e) => e.toReverseMap()).toList(),
      'users': users?.map((e) => e.toReverseMap()).toList(),
    };
  }

  Map<String, dynamic> toJson() => {};
}
