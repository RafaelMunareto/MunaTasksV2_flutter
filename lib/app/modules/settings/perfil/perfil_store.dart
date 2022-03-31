import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/image/image_repository.dart';

part 'perfil_store.g.dart';

class PerfilStore = _PerfilStoreBase with _$PerfilStore;

abstract class _PerfilStoreBase with Store {
  final IPerfilService perfilService;
  final ImageRepository imageRepository;
  final ClientStore client = Modular.get();
  final ILocalStorage storage = Modular.get();

  _PerfilStoreBase(
      {required this.perfilService, required this.imageRepository}) {
    getList();
  }

  getList() async {
    await getUid();
    getBydDioId();
    getDioUsers();
    client.showTextFieldName(true);
  }

  getUid() {
    storage.get('userDio').then((value) {
      client.setUserSelection(
          UserDioClientModel.fromJson(jsonDecode(value[0])['user']));
    });
  }

  getBydDioId() {
    perfilService.getDio(client.userSelection.id).then((value) {
      client.setPerfildio(value);
      client.setUsersDio(client.perfilDio.idStaff!.map((e) {
        var perfil = PerfilDioModel.fromJson(e);
        if (!client.individualChip!.contains(perfil.id)) {
          client.individualChip!.add(perfil.id);
        }
        return perfil;
      }).toList());
    });
  }

  getDioUsers() {
    perfilService.getDioList().then((value) {
      client.setPerfis(value);
    }).whenComplete(() {
      client.setLoading(false);
      client.setLoadingImagem(false);
    });
  }

  saveDio() async {
    await perfilService.saveDio(client.perfilDio);
    getList();
  }
}
