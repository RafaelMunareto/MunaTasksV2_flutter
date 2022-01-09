import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';

class EtiquetaRepository implements IEtiquetaRepository {
  final FirebaseFirestore firestore;

  EtiquetaRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<EtiquetaModel>> get() {
    return firestore.collection('etiqueta').snapshots().map((query) =>
        query.docs.map((doc) => EtiquetaModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<ColorsModel>> getColor() {
    return firestore.collection('color').snapshots().map((query) =>
        query.docs.map((doc) => ColorsModel.fromDocument(doc)).toList());
  }

  @override
  Future<EtiquetaModel> getByDocumentId(String documentId) async {
    return firestore
        .collection('etiqueta')
        .doc(documentId)
        .get()
        .then((doc) => EtiquetaModel.fromDocument(doc));
  }

  @override
  Future delete(EtiquetaModel model) {
    return model.reference!.delete();
  }

  @override
  Future save(EtiquetaModel model) async {
    if (model.reference == null) {
      model.reference = await firestore.collection('etiqueta').add({
        'etiqueta': model.etiqueta,
        'color': model.color,
        'icon': model.icon,
      });
    } else {
      model.reference!.update({
        'etiqueta': model.etiqueta,
        'color': model.color,
        'icon': model.icon,
      });
    }
  }
}
