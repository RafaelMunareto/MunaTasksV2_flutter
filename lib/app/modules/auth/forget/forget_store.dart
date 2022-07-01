//import 'dart:html';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'forget_store.g.dart';

class ForgetStore = _ForgetStoreBase with _$ForgetStore;

abstract class _ForgetStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();
  ILocalStorage storage = Modular.get();

  _ForgetStoreBase() {
    client.buscaTheme();
  }

  @action
  submit() {
    client.setLoading(true);
    auth.sendEmailChangePassword(client.email).then((value) async {
      client.setLoading(false);
      value?.data == 'Email enviado com sucesso!'
          ? client.setMsgErrOrGoal(true)
          : client.setMsgErrOrGoal(false);
      client.setMsg(value?.data);
    }).catchError((error) {
      client.setLoading(false);
      client.setMsgErrOrGoal(false);
      client.setMsg(error.response?.data['error'] ?? error?.message);
    });
  }
}
