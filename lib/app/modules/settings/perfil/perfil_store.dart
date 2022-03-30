import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
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
    client.showTextFieldName(true);
    getList();
  }

  getList() async {
    await getUid();
    await getBydDioId();
    getDioUsers();
  }

  @action
  getUid() {
    storage.get('userDio').then((value) {
      client.setUserSelection(
          UserDioClientModel.fromJson(jsonDecode(value[0])['user']));
    });
  }

  @action
  getBydDioId() {
    perfilService.getDio(client.userSelection.id).then((value) {
      client.setPerfildio(value);
      client.setUsersDio(client.perfilDio.idStaff!.map((e) {
        return PerfilDioModel.fromJson(e);
      }).toList());
    }).whenComplete(() => client.setLoadingImagem(false));
  }

  @action
  getDioUsers() {
    perfilService.getDioList().then((value) {
      client.setPerfis(value);
    }).whenComplete(() => client.setLoading(false));
  }

  @action
  saveDio() async {
    await perfilService.saveDio(client.perfilDio);
    getBydDioId();
    getDioUsers();
  }
}
