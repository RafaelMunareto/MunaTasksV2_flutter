// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignupStore on _SignupStoreBase, Store {
  Computed<bool>? _$isValidRegisterEmailGrupoComputed;

  @override
  bool get isValidRegisterEmailGrupo => (_$isValidRegisterEmailGrupoComputed ??=
          Computed<bool>(() => super.isValidRegisterEmailGrupo,
              name: '_SignupStoreBase.isValidRegisterEmailGrupo'))
      .value;

  final _$grupoEmailAtom = Atom(name: '_SignupStoreBase.grupoEmail');

  @override
  List<dynamic> get grupoEmail {
    _$grupoEmailAtom.reportRead();
    return super.grupoEmail;
  }

  @override
  set grupoEmail(List<dynamic> value) {
    _$grupoEmailAtom.reportWrite(value, super.grupoEmail, () {
      super.grupoEmail = value;
    });
  }

  final _$loadingAtom = Atom(name: '_SignupStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$checkGrupoEmailAtom = Atom(name: '_SignupStoreBase.checkGrupoEmail');

  @override
  bool? get checkGrupoEmail {
    _$checkGrupoEmailAtom.reportRead();
    return super.checkGrupoEmail;
  }

  @override
  set checkGrupoEmail(bool? value) {
    _$checkGrupoEmailAtom.reportWrite(value, super.checkGrupoEmail, () {
      super.checkGrupoEmail = value;
    });
  }

  final _$msgAtom = Atom(name: '_SignupStoreBase.msg');

  @override
  String get msg {
    _$msgAtom.reportRead();
    return super.msg;
  }

  @override
  set msg(String value) {
    _$msgAtom.reportWrite(value, super.msg, () {
      super.msg = value;
    });
  }

  final _$msgErrOrGoalAtom = Atom(name: '_SignupStoreBase.msgErrOrGoal');

  @override
  bool get msgErrOrGoal {
    _$msgErrOrGoalAtom.reportRead();
    return super.msgErrOrGoal;
  }

  @override
  set msgErrOrGoal(bool value) {
    _$msgErrOrGoalAtom.reportWrite(value, super.msgErrOrGoal, () {
      super.msgErrOrGoal = value;
    });
  }

  final _$_SignupStoreBaseActionController =
      ActionController(name: '_SignupStoreBase');

  @override
  dynamic setMsgErrOrGoal(dynamic value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setMsgErrOrGoal');
    try {
      return super.setMsgErrOrGoal(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsg(dynamic value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCheckGrupoEmail(dynamic value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setCheckGrupoEmail');
    try {
      return super.setCheckGrupoEmail(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmailGrupo(String value) {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.changeEmailGrupo');
    try {
      return super.changeEmailGrupo(value);
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setGrupoEmail() {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.setGrupoEmail');
    try {
      return super.setGrupoEmail();
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void submit() {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.submit');
    try {
      return super.submit();
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
grupoEmail: ${grupoEmail},
loading: ${loading},
checkGrupoEmail: ${checkGrupoEmail},
msg: ${msg},
msgErrOrGoal: ${msgErrOrGoal},
isValidRegisterEmailGrupo: ${isValidRegisterEmailGrupo}
    ''';
  }
}
