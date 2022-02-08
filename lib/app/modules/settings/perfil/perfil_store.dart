import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/image/image_repository.dart';

part 'perfil_store.g.dart';

class PerfilStore = _PerfilStoreBase with _$PerfilStore;

abstract class _PerfilStoreBase with Store {
  final IPerfilService perfilService;
  final ImageRepository imageRepository;
  final AuthController auth = Modular.get();
  final FirebaseFirestore bd = Modular.get();
  final FirebaseAuth firebaseAuth = Modular.get();
  final ClientStore client = Modular.get();
  final ILocalStorage storage = Modular.get();

  _PerfilStoreBase(
      {required this.perfilService, required this.imageRepository}) {
    getById();
    client.showTextFieldName(true);
    getUsers();
  }

  @observable
  String uid = '';

  @action
  getUid() {
    storage.get('user').then((value) {
      uid = value[0];
    });
  }

  @action
  getById() async {
    await getUid();
    perfilService.getByDocumentId(uid).then((value) {
      client.userModel = [];
      client.perfil = value;
    }).then((value) {
      if (client.perfil.idStaff!.isNotEmpty) {
        for (var element in client.perfil.idStaff!) {
          bd.collection('usuarios').doc(element.id).get().then(
            (doc) {
              dynamic user = UserModel(
                  name: doc['name'],
                  email: doc['email'],
                  reference: doc.reference,
                  urlImage: doc['urlImage']);
              client.userModel.add(user);
            },
          ).whenComplete(() {
            if (client.perfil.idStaff!.length == client.userModel.length) {
              if (client.userModel.isNotEmpty) {
                List<UserModel> list = client.userModel;
                client.individualChip!.clear();
                for (var i = 0; i < list.length; i++) {
                  if (client.inputChipChecked(list[i].reference)) {
                    client.individualChip!.add(list[i].reference);
                  }
                }
              }
              client.setLoading(true);
            }
          });
        }
      } else {
        client.setLoading(true);
      }
    });
  }

  @action
  getUsers() {
    client.usuarios = auth.getUsers().asObservable();
  }

  @action
  save() {
    perfilService.save(client.perfil);
  }
}
