import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'change_store.g.dart';

class ChangeStore = _ChangeStoreBase with _$ChangeStore;

abstract class _ChangeStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();
  ILocalStorage storage = Modular.get();

  _ChangeStoreBase() {
    client.buscaTheme();
  }
  submit() {
    if (client.code != '') {
      client.setLoading(true);
      auth
          .changeUserPassword(client.code, client.confirmPassword)
          .then((value) {
        client.setLoading(false);
        client.setMsgErrOrGoal(true);
        client.setMsg('Senha alterada com sucesso!');
      }).catchError((erro) {
        client.setLoading(false);
        client.setMsgErrOrGoal(false);
        client.setMsg('Erro na alteração de senha!');
      });
    } else {
      client.setMsgErrOrGoal(false);
      client.setMsg('Usuário não encontrado na base');
    }
  }
}
