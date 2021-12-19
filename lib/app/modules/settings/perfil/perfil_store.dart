import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

part 'perfil_store.g.dart';

class PerfilStore = _PerfilStoreBase with _$PerfilStore;

abstract class _PerfilStoreBase with Store {
  final IPerfilService perfilService;
  final AuthController auth = Modular.get();
  final FirebaseFirestore bd = Modular.get();

  _PerfilStoreBase({required this.perfilService}) {
    getById();
  }

  @observable
  PerfilModel perfil = PerfilModel();

  @observable
  bool loading = false;

  @action
  setLoading(value) => loading = true;

  @observable
  List<dynamic> userModel = [];

  @action
  getById() {
    perfilService.getByDocumentId(auth.user!.uid).then((value) {
      perfil = value;
    }).then((value) {
      for (var element in perfil.idStaff!) {
        bd.collection('usuarios').doc(element.id).get().then(
          (doc) {
            dynamic user = UserModel(
                name: doc['name'],
                email: doc['email'],
                urlImage: doc['urlImage']);
            userModel.add(user);
          },
        );
      }
    }).then((value) {
      Timer(const Duration(seconds: 1), () => setLoading(true));
    });
  }
}
