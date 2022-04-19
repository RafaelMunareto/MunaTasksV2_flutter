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
    buscaTheme();
  }

  @observable
  bool loading = false;

  @observable
  bool checkError = false;

  @observable
  String msg = '';

  @action
  setMsg(value) => msg = value;

  @action
  setLoading(value) => loading = value;

  @observable
  bool msgErrOrGoal = false;

  @action
  setMsgErrOrGoal(value) => msgErrOrGoal = value;

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

  @action
  submit() {
    setLoading(true);
    auth.sendEmailChangePassword(client.email).then((value) async {
      setLoading(false);
      setMsgErrOrGoal(true);
      setMsg('Senha enviada com sucesso!');
    }).catchError((erro) {
      setLoading(false);
      setMsgErrOrGoal(false);
      setMsg(erro.response.data['error']);
    });
  }
}
