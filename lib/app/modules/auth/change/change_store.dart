import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'change_store.g.dart';

class ChangeStore = _ChangeStoreBase with _$ChangeStore;

abstract class _ChangeStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();

  @observable
  bool loading = false;

  @observable
  String code = '';

  @action
  setCode(value) => code = value;

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

  submit() {
    if (code != '') {
      setLoading(true);
      auth.changeUserPassword(code, client.confirmPassword).then((value) {
        setLoading(false);
        setMsgErrOrGoal(true);
        setMsg('Senha alterada com sucesso!');
      }).catchError((erro) {
        setLoading(false);
        setMsgErrOrGoal(false);
        setMsg('Erro na alteração de senha!');
      });
    } else {
      setMsgErrOrGoal(false);
      setMsg('Usuário não encontrado na base');
    }
  }
}
