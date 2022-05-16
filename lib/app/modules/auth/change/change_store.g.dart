// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChangeStore on _ChangeStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: '_ChangeStoreBase.loading', context: context);

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

  late final _$codeAtom = Atom(name: '_ChangeStoreBase.code', context: context);

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$msgAtom = Atom(name: '_ChangeStoreBase.msg', context: context);

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
      Atom(name: '_ChangeStoreBase.msgErrOrGoal', context: context);

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
      Atom(name: '_ChangeStoreBase.theme', context: context);

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

  late final _$_ChangeStoreBaseActionController =
      ActionController(name: '_ChangeStoreBase', context: context);

  @override
  dynamic setCode(dynamic value) {
    final _$actionInfo = _$_ChangeStoreBaseActionController.startAction(
        name: '_ChangeStoreBase.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_ChangeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsg(dynamic value) {
    final _$actionInfo = _$_ChangeStoreBaseActionController.startAction(
        name: '_ChangeStoreBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_ChangeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_ChangeStoreBaseActionController.startAction(
        name: '_ChangeStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ChangeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsgErrOrGoal(dynamic value) {
    final _$actionInfo = _$_ChangeStoreBaseActionController.startAction(
        name: '_ChangeStoreBase.setMsgErrOrGoal');
    try {
      return super.setMsgErrOrGoal(value);
    } finally {
      _$_ChangeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTheme(dynamic value) {
    final _$actionInfo = _$_ChangeStoreBaseActionController.startAction(
        name: '_ChangeStoreBase.setTheme');
    try {
      return super.setTheme(value);
    } finally {
      _$_ChangeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
code: ${code},
msg: ${msg},
msgErrOrGoal: ${msgErrOrGoal},
theme: ${theme}
    ''';
  }
}
