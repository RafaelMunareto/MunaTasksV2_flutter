import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();
  ILocalStorage storage = Modular.get();

  _LoginStoreBase() {
    client.buscaTheme();
  }

  String textToMd5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  submit() async {
    await client.setLoading(true);
    await auth
        .getLoginDio(client.email.trim(), client.password)
        .then((value) async {
      client.setLoading(false);
      client.setMsgErrOrGoal(false);
      UserDioModel user = UserDioModel.fromJson(value.data);
      SessionManager().set("token", user.token);
      await storage.put('token', [user.token]);
      await storage.put('userDio', [jsonEncode(user.user)]);
      await storage.put('biometric', [
        textToMd5(client.email.toLowerCase().trim()),
        textToMd5(client.password)
      ]);
      await storage.put('login-normal', [
        textToMd5(client.email.toLowerCase().trim()),
        textToMd5(client.password)
      ]);
      await getPerfil(user.user.id);
    }).catchError((error) {
      client.setLoading(false);
      client.setMsgErrOrGoal(false);
      client.setMsg(error.response?.data['error'] ?? error?.message);
    });
  }

  getPerfil(id) async {
    Response response;
    if (id != '') {
      var dio = await DioStruture().dioAction();
      response = await dio.get('perfil/user/$id');
      if (response.data != null) {
        var perfil = PerfilDioModel.fromJson(response.data[0]);
        getSettings(perfil);
      }
    }
  }

  getSettings(PerfilDioModel perfil) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/settingsUser/${perfil.id}');
    if (response.data.isEmpty) {
      var settings = SettingsUserModel(user: perfil.id);
      saveSettings(settings);
    } else {
      var settings = SettingsUserModel.fromJson(response.data[0]);
      client.setTheme(settings.theme);
      storage.put('theme', settings.theme ? ['dark'] : ['light']);
      Modular.to.navigate('/home/');
    }
  }

  Future saveSettings(SettingsUserModel model) async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.post('perfil/settingsUser', data: model.toJson(model));
    var settings = SettingsUserModel.fromJson(response.data);
    storage.put('theme', settings.theme ? ['dark'] : ['light']);
    client.setTheme(settings.theme);
    Modular.to.navigate('/home/');
  }

  //gooole
  loginWithGoogle() async {
    client.setLoading(true);
    try {
      await auth.loginWithGoogle().then((value) {
        auth.getLoginDio(value.email, value.password).then((e) async {
          UserDioModel user = UserDioModel.fromJson(e.data);
          await SessionManager().set("token", user.token);
          await storage.put('token', [user.token]);
          await storage.put('userDio', [jsonEncode(user)]);
          await storage.put('login-normal',
              [textToMd5(value.email), textToMd5(value.password)]);
          await storage.put(
              'biometric', [textToMd5(value.email), textToMd5(value.password)]);
          client.setLoading(false);
          Modular.to.navigate('/home/');
        });
      }).onError((error, stackTrace) {
        client.setLoading(false);
        client.setMsgErrOrGoal(false);
        client.setMsg(error.toString());
      });
    } catch (erro) {
      client.setLoading(false);
      client.setMsgErrOrGoal(false);
      client.setMsg(erro.toString());
    }
  }

  //biometric
  @action
  checkBiometrics() {
    auth.biometricRepository
        .checkBiometrics()
        .then((value) => client.canCheckBiometrics = value);
  }

  @action
  getAvailableBiometrics() async {
    await auth.biometricRepository
        .getAvailableBiometrics()
        .then((value) => client.availableBiometrics = value);
    if (client.availableBiometrics.contains(BiometricType.face)) {
      client.faceOrFinger = true;
    } else if (client.availableBiometrics.contains(BiometricType.fingerprint)) {
      client.faceOrFinger = false;
    }
  }

  @action
  authenticateBiometric() {
    auth.authenticateWithBiometrics(client.faceOrFinger).then((value) {
      if (value == 'Authorized') {
        if (client.loginStorage![0] != '') {
          client.setLoading(true);
          auth
              .getLoginDio(client.loginStorage![0], client.loginStorage![1])
              .then((value) async {
            client.setLoading(false);
            client.setMsgErrOrGoal(false);
            UserDioModel user = UserDioModel.fromJson(value.data);
            SessionManager().set("token", user.token);
            await storage.put('token', [user.token]);
            await storage.put('userDio', [jsonEncode(user)]);
            await storage.put('login-normal',
                [textToMd5(client.email), textToMd5(client.password)]);
            Modular.to.navigate('/home/');
          }).catchError((error) {
            client.setLoading(false);
            client.setMsgErrOrGoal(false);
            client.setMsg(error.response?.data['error'] ?? error?.message);
          });
        }
      }
    });
  }

  @action
  getStorageLogin() async {
    await storage.get('biometric').then((value) {
      if (value != null) {
        client.loginStorage = value;
      }
    });
  }

  //check support device
  @action
  checkSupportDevice() async {
    await getStorageLogin();
    if (!kIsWeb && defaultTargetPlatform != TargetPlatform.windows) {
      await client.bio.isDeviceSupported().then((isSupported) =>
          client.supportState = isSupported && client.loginStorage != null
              ? SupportState.supported
              : SupportState.unsupported);
      await checkBiometrics();
      await getAvailableBiometrics();
    }
  }

  @action
  submitStorage() {
    storage.get('login-normal').then((value) {
      if (value != null) {
        if (value.isNotEmpty) {
          auth.getLoginDio(value[0], value[1]).then((value) {
            client.setLoading(false);
            client.setMsgErrOrGoal(false);
            Modular.to.navigate('/home/');
          }).catchError((error) {
            client.setLoading(false);
            client.setMsgErrOrGoal(false);
            client.setMsg(error.response?.data['error'] ?? error?.message);
          });
        }
      }
    });
  }
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}
