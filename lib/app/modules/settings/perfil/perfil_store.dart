import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/image/image_repository.dart';

part 'perfil_store.g.dart';

class PerfilStore = _PerfilStoreBase with _$PerfilStore;

abstract class _PerfilStoreBase with Store {
  final IPerfilService perfilService;
  final ImageRepository imageRepository;
  final ClientStore client = Modular.get();
  final ILocalStorage storage = Modular.get();
  final ImagePicker picker = ImagePicker();

  _PerfilStoreBase(
      {required this.perfilService, required this.imageRepository}) {
    getList();
  }

  getList() async {
    await getUid();
    await buscaTheme();
    getBydDioId();
    getDioUsers();
    client.showTextFieldName(true);
  }

  getUid() {
    storage.get('userDio').then((value) {
      client
          .setUserSelection(UserDioClientModel.fromJson(jsonDecode(value[0])));
    });
  }

  buscaTheme() async {
    await storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        client.setTheme(true);
      } else {
        client.setTheme(false);
      }
    });
  }

  getBydDioId() {
    perfilService.getDio(client.userSelection.id).then((value) async {
      await client.setPerfildio(value);
      await client.setNameTime(value.nameTime);
      var users = await client.perfilDio.idStaff == null
          ? []
          : client.perfilDio.idStaff.map((e) {
              var perfil = PerfilDioModel.fromJson(e);
              if (!client.individualChip.contains(perfil.id)) {
                client.individualChip.add(perfil.id);
              }
              return perfil;
            }).toList();
      client.setUsersDio(users);
      client.setLoadingImagem(false);
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
    getBydDioId();
  }

  @action
  saveName() async {
    await perfilService.saveName(client.perfilDio);
    getBydDioId();
  }

  Future atualizaImagem(String origemImagem) async {
    client.setLoadingImagem(true);
    if (!kIsWeb && defaultTargetPlatform != TargetPlatform.android) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);

        var imagebytes = await file.readAsBytes();
        List<int> listData = imagebytes.cast();
        FormData formData = FormData.fromMap(
          {
            "urlImage": MultipartFile.fromBytes(listData,
                filename: client.perfilDio.urlImage ==
                        'http://api.munatask.com/files/'
                    ? client.perfilDio.id
                    : client.perfilDio.urlImage!),
          },
        );

        Response response;
        var dio = await DioStruture().dioAction();
        response =
            await dio.put('perfil/${client.perfilDio.id}', data: formData);
        DioStruture().statusRequest(response);
        getBydDioId();
      }
    } else {
      XFile? image;
      switch (origemImagem) {
        case "camera":
          image = await picker.pickImage(
            source: ImageSource.camera,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          break;
        case "galeria":
          image = await picker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          break;
      }

      var imagebytes = await image?.readAsBytes();
      List<int>? listData = imagebytes!.cast();

      FormData formData = FormData.fromMap(
        {
          "urlImage": MultipartFile.fromBytes(listData,
              filename:
                  client.perfilDio.urlImage == 'http://api.munatask.com/files/'
                      ? client.perfilDio.id
                      : client.perfilDio.urlImage!),
        },
      );
      try {
        Response response;
        var dio = await DioStruture().dioAction();
        response =
            await dio.put('perfil/${client.perfilDio.id}', data: formData);
        DioStruture().statusRequest(response);
        getBydDioId();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }
}
