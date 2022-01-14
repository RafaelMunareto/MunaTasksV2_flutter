import 'package:cloud_firestore/cloud_firestore.dart';

class EtiquetaModel {
  String etiqueta;
  DocumentReference? reference;
  String color;
  int? icon;

  EtiquetaModel(
      {this.color = '', this.reference, this.icon, this.etiqueta = ''});

  factory EtiquetaModel.fromDocument(DocumentSnapshot doc) {
    return EtiquetaModel(
        etiqueta: doc['etiqueta'],
        color: doc['color'],
        reference: doc.reference,
        icon: doc['icon']);
  }

  factory EtiquetaModel.fromJson(Map<String, dynamic> json) {
    return EtiquetaModel(
        etiqueta: json['etiqueta'], color: json['color'], icon: json['icon']);
  }

  Map<String, dynamic> toMap() {
    return {'etiqueta': etiqueta, 'color': color, 'icon': icon};
  }

  Map<String, dynamic> toReverseMap() {
    return {'etiqueta': reference};
  }

  Map<String, dynamic> toJson() => {};
}
