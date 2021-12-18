

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munatasks2/app/modules/home/models/version_model.dart';
import 'package:munatasks2/app/modules/home/repositories/interfaces/version_interfaces.dart';

class VersionRepository implements IVersionRepository{
  final FirebaseFirestore firestore;

  VersionRepository({required this.firestore});

  void dispose() {}

  @override
  Stream<List<VersionModel>> get() {
    return firestore.collection('atualizacao').snapshots().map(
        (query) => query.docs.map((doc) => VersionModel.fromDocument(doc)).toList());

  }

  @override
  Future<Stream<VersionModel>> getByDocumentId(String documentId) async {
    return firestore.collection('atualizacao')
           .doc(documentId)
           .snapshots()
           .map((doc) => VersionModel.fromDocument(doc));
  }

  @override
  Future delete(VersionModel model) {
    return model.reference!.delete();
  }

  @override
  Future save(VersionModel model) async {
    var total = (await firestore.collection('atualizacao').get())
        .docs
        .length;

    if (model.reference == null) {
      model.reference = await firestore.collection('atualizacao').add({
        'title': model.title,
        'check': model.check,
        'position': total,
      });
    } else {
      model.reference!.update({
        'title': model.title,
        'check': model.check,
      });
    }
  }

}