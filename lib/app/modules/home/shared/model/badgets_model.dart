import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';

class BadgetsModel {
  String name;
  Color? colors;
  int qtd;
  List<TarefaDioModel>? dados;

  BadgetsModel({
    this.name = '',
    this.qtd = 0,
    this.colors,
    this.dados,
  });

  factory BadgetsModel.fromDocument(doc) {
    return BadgetsModel(
      name: doc['name'],
      qtd: doc['qtd'],
      colors: doc['colors'],
      dados: doc['dados'],
    );
  }

  factory BadgetsModel.fromJson(Map<String, dynamic> json) {
    return BadgetsModel(
      name: json['name'],
      qtd: json['qtd'],
      colors: json['colors'],
      dados: json['dados'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
