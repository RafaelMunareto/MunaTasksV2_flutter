import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();
  ILocalStorage storage = Modular.get();
  final LocalAuthentication bio = Modular.get();

  _LoginStoreBase() {
    buscaTheme();
  }

  @observable
  SupportState supportState = SupportState.unknown;

  @observable
  bool loading = false;

  @observable
  String msg = '';

  @observable
  bool faceOrFinger = true;

  @observable
  bool errOrGoal = false;

  @observable
  List<String>? loginStorage;

  @action
  setErrOrGoal(value) => errOrGoal = value;

  @action
  setMsg(value) => msg = value;

  @action
  setLoading(value) => loading = value;

  @observable
  bool theme = false;

  @action
  setTheme(value) => value = theme;

  buscaTheme() {
    storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        setTheme(true);
      } else {
        setTheme(false);
      }
    });
  }

  //biometric
  @observable
  bool canCheckBiometrics = false;

  @observable
  List<BiometricType> availableBiometrics = [];

  @observable
  String authorized = 'Não autorizado!';

  @observable
  bool isAuthenticating = false;

  @observable
  dynamic user;

  @action
  setUser(value) => user = value;

  submit() {
    setLoading(true);
    auth.getLoginDio(client.email, client.password).then((value) async {
      setLoading(false);
      setErrOrGoal(false);
      UserDioModel user = UserDioModel.fromJson(value.data);
      SessionManager().set("token", user.token);
      await storage.put('token', [user.token]);
      await storage.put('userDio', [jsonEncode(user)]);
      await storage.put('biometric', [client.email, client.password]);
      await storage.put('login-normal', [client.email, client.password]);
      Modular.to.navigate('/home/');
    }).catchError((error) {
      setLoading(false);
      setErrOrGoal(false);
      setMsg(error.response?.data['error'] ?? error?.message);
    });
  }

  //gooole
  loginWithGoogle() async {
    setLoading(true);
    try {
      await auth.loginWithGoogle();
      setLoading(false);
    } catch (erro) {
      setLoading(false);
      setErrOrGoal(false);
      setMsg(erro.toString());
    }
  }

  //biometric
  @action
  checkBiometrics() {
    auth.biometricRepository
        .checkBiometrics()
        .then((value) => canCheckBiometrics = value);
  }

  @action
  getAvailableBiometrics() async {
    await auth.biometricRepository
        .getAvailableBiometrics()
        .then((value) => availableBiometrics = value);
    if (availableBiometrics.contains(BiometricType.face)) {
      faceOrFinger = true;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      faceOrFinger = false;
    }
  }

  @action
  authenticateBiometric() {
    auth.authenticateWithBiometrics(faceOrFinger).then((value) {
      if (value == 'Authorized') {
        if (loginStorage![0] != '') {
          setLoading(true);
          auth
              .getLoginDio(loginStorage![0], loginStorage![1])
              .then((value) async {
            setLoading(false);
            setErrOrGoal(false);
            UserDioModel user = UserDioModel.fromJson(value.data);
            SessionManager().set("token", user.token);
            await storage.put('token', [user.token]);
            await storage.put('userDio', [jsonEncode(user)]);
            await storage.put('login-normal', [client.email, client.password]);
            Modular.to.navigate('/home/');
          }).catchError((error) {
            setLoading(false);
            setErrOrGoal(false);
            setMsg(error.response?.data['error'] ?? error?.message);
          });
        }
      }
    });
  }

  @action
  getStorageLogin() async {
    await storage.get('biometric').then((value) {
      if (value != null) {
        loginStorage = value;
      }
    });
  }

  //check support device
  @action
  checkSupportDevice() async {
    await getStorageLogin();
    if (!kIsWeb && defaultTargetPlatform != TargetPlatform.windows) {
      await bio.isDeviceSupported().then((isSupported) => supportState =
          isSupported && loginStorage != null
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
            setLoading(false);
            setErrOrGoal(false);
            Modular.to.navigate('/home/');
          }).catchError((error) {
            setLoading(false);
            setErrOrGoal(false);
            setMsg(error.response?.data['error'] ?? error?.message);
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
