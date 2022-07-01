import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStoreBase with _$SignupStore;

abstract class _SignupStoreBase with Store {
  ClientStore client = Modular.get();
  AuthController auth = Modular.get();
  ILocalStorage storage = Modular.get();

  _SignupStoreBase() {
    client.buscaTheme();
  }

  @computed
  bool get isValidRegisterEmailGrupo {
    return client.validateName() == null &&
        client.validatePassword() == null &&
        client.validateConfirmPassword() == null;
  }

  @action
  void submit() {
    UserDioClientModel model = UserDioClientModel(
        email: client.email, name: client.name, password: client.password);
    client.setLoading(true);
    auth.saveUser(model).then((value) {
      client.setMsgErrOrGoal(true);
      client.setMsg('Usuário criado com sucesso');
      client.setLoading(false);
      UserDioClientModel user = UserDioClientModel.fromJson(value.data);
      auth.perfilUser(user);
      auth.getLoginDio(client.email, client.password).then((value) async {
        UserDioModel user = UserDioModel.fromJson(value.data);
        await SessionManager().set("token", user.token);
        await storage.put('token', [user.token]);
        await storage.put('userDio', [jsonEncode(user)]);
        await storage.put('biometric', [client.email, client.password]);
        Modular.to.navigate('/auth/');
      });
    }).catchError((error) {
      client.setMsgErrOrGoal(false);
      client.setMsg(error.response?.data['error'] ?? error?.message);
      client.setLoading(false);
    });
  }
}
