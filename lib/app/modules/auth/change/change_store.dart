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
  String? code;

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

  @action
  submit() {
    // if(code != null) {
    //   setLoading(true);
    //   auth.changeResetPassword(client.password, code).then((value) {
    //     setLoading(false);

    //     if(value != null){
    //       setMsgErrOrGoal(false);
    //       setMsg(value);
    //     }else{
    //       setMsgErrOrGoal(true);
    //       setMsg('Senha alterada com sucesso!');
    //     }
    //   });
    // }
  }
}
