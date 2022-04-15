import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStoreBase with _$SignupStore;

abstract class _SignupStoreBase with Store {
  ClientStore client = Modular.get();
  AuthController auth = Modular.get();

  @observable
  bool loading = false;

  @observable
  String msg = '';

  @observable
  bool msgErrOrGoal = false;

  @action
  setMsgErrOrGoal(value) => msgErrOrGoal = value;

  @action
  setLoading(value) => loading = value;

  @action
  setMsg(value) => msg = value;

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
    setLoading(true);
    auth.saveUser(model).then((value) {
      auth.getLoginDio(client.email, client.password).then((value) {
        UserDioClientModel user =
            UserDioClientModel.fromJson(value.data['user']);
        auth.perfilUser(user).then((a) {}).catchError((e) {
          setMsg(e.response?.data['error'].toString());
        });
      }).then((value) {
        setMsgErrOrGoal(true);
        setMsg('Usuário criado com sucesso');
        setLoading(false);
        Modular.to.navigate('/auth/');
      });
    }).catchError((error) {
      setMsgErrOrGoal(false);
      setMsg(error.response?.data['error'].toString());
      setLoading(false);
    });
  }
}
