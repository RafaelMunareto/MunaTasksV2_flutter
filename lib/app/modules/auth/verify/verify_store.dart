import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'verify_store.g.dart';

class VerifyStore = _VerifyStoreBase with _$VerifyStore;

abstract class _VerifyStoreBase with Store {
  AuthController auth = Modular.get();

  @observable
  String code = '';

  @observable
  String msg = '';

  @observable
  String mode = '';

  @observable
  bool msgErrOrGoal = false;

  @action
  setMode(value) => mode = value;

  @action
  setCode(value) => code = value;

  @action
  setMsgErrOrGoal(value) => msgErrOrGoal = value;

  @action
  setMsg(value) => msg = value;

  @action
  emailVerify() {
    if (mode == 'resetPassword') {
      Timer(const Duration(seconds: 1),
          () => Modular.to.navigate('/auth/change/$code'));
    } else {
      // auth.authRepository.emailVerify(code).then((value) {
      //   if (value != null) {
      //     setMsgErrOrGoal(true);
      //     setMsg('Código validado!');
      //     Timer(
      //         const Duration(seconds: 2), () => Modular.to.navigate('/auth/'));
      //   }
      // }).catchError((e) {
      //   setMsgErrOrGoal(false);
      //   setMsg(ErrorPtBr().verificaCodeErro(e.code));
      //   Timer(const Duration(seconds: 3), () => Modular.to.navigate('/auth/'));
      // });
    }
  }
}
