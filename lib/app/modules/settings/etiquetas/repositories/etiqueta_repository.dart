import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/repositories/interfaces/etiqueta_interfaces.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/repositories/interfaces/perfil_interfaces.dart';

class EtiquetaRepository implements IEtiquetaRepository {
  final FirebaseFirestore firestore;

  EtiquetaRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<PerfilModel>> get() {
    return firestore.collection('perfil').snapshots().map((query) =>
        query.docs.map((doc) => PerfilModel.fromDocument(doc)).toList());
  }

  @override
  Stream<List<ColorsModel>> getColor() {
    return firestore.collection('color').snapshots().map((query) =>
        query.docs.map((doc) => ColorsModel.fromDocument(doc)).toList());
  }

  @override
  Future<PerfilModel> getByDocumentId(String documentId) async {
    return firestore
        .collection('perfil')
        .doc(documentId)
        .get()
        .then((doc) => PerfilModel.fromDocument(doc));
  }

  @override
  Future delete(PerfilModel model) {
    return model.reference!.delete();
  }

  @override
  Future save(PerfilModel model) async {
    if (model.reference == null) {
      model.reference = await firestore.collection('perfil').add({
        'idStaff': model.idStaff,
        'manager': model.manager,
        'name': model.name,
        'nameTime': model.nameTime,
      });
    } else {
      model.reference!.update({
        'idStaff': model.idStaff,
        'manager': model.manager,
        'name': model.name,
        'nameTime': model.nameTime,
      });
    }
  }
}
