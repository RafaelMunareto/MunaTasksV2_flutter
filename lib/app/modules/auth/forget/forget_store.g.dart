// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgetStore on _ForgetStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: '_ForgetStoreBase.loading', context: context);

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

  late final _$checkErrorAtom =
      Atom(name: '_ForgetStoreBase.checkError', context: context);

  @override
  bool get checkError {
    _$checkErrorAtom.reportRead();
    return super.checkError;
  }

  @override
  set checkError(bool value) {
    _$checkErrorAtom.reportWrite(value, super.checkError, () {
      super.checkError = value;
    });
  }

  late final _$msgAtom = Atom(name: '_ForgetStoreBase.msg', context: context);

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

  late final _$msgErrOrGoalAtom =
      Atom(name: '_ForgetStoreBase.msgErrOrGoal', context: context);

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

  late final _$themeAtom =
      Atom(name: '_ForgetStoreBase.theme', context: context);

  @override
  bool get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(bool value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  late final _$_ForgetStoreBaseActionController =
      ActionController(name: '_ForgetStoreBase', context: context);

  @override
  dynamic setMsg(dynamic value) {
    final _$actionInfo = _$_ForgetStoreBaseActionController.startAction(
        name: '_ForgetStoreBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_ForgetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_ForgetStoreBaseActionController.startAction(
        name: '_ForgetStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ForgetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsgErrOrGoal(dynamic value) {
    final _$actionInfo = _$_ForgetStoreBaseActionController.startAction(
        name: '_ForgetStoreBase.setMsgErrOrGoal');
    try {
      return super.setMsgErrOrGoal(value);
    } finally {
      _$_ForgetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTheme(dynamic value) {
    final _$actionInfo = _$_ForgetStoreBaseActionController.startAction(
        name: '_ForgetStoreBase.setTheme');
    try {
      return super.setTheme(value);
    } finally {
      _$_ForgetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic submit() {
    final _$actionInfo = _$_ForgetStoreBaseActionController.startAction(
        name: '_ForgetStoreBase.submit');
    try {
      return super.submit();
    } finally {
      _$_ForgetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
checkError: ${checkError},
msg: ${msg},
msgErrOrGoal: ${msgErrOrGoal},
theme: ${theme}
    ''';
  }
}
