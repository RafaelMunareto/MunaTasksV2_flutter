import 'package:cloud_firestore/cloud_firestore.dart';

class EtiquetaDioModel {
  String etiqueta;
  String? id;
  String color;
  int? icon;

  EtiquetaDioModel({this.color = '', this.id, this.icon, this.etiqueta = ''});

  factory EtiquetaDioModel.fromDocument(DocumentSnapshot doc) {
    return EtiquetaDioModel(
        etiqueta: doc['etiqueta'],
        color: doc['color'],
        id: doc['_id'],
        icon: doc['icon']);
  }

  factory EtiquetaDioModel.fromJson(Map<String, dynamic> json) {
    return EtiquetaDioModel(
        etiqueta: json['etiqueta'],
        id: json['_id'],
        color: json['color'],
        icon: json['icon']);
  }

  Map<String, dynamic> toMap() {
    return {'etiqueta': etiqueta, '_id': id, 'color': color, 'icon': icon};
  }

  Map<String, dynamic> toJson() =>
      {'etiqueta': etiqueta, '_id': id, 'color': color, 'icon': icon};
}
