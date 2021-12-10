// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VerifyStore on _VerifyStoreBase, Store {
  final _$codeAtom = Atom(name: '_VerifyStoreBase.code');

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

  final _$msgAtom = Atom(name: '_VerifyStoreBase.msg');

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

  final _$modeAtom = Atom(name: '_VerifyStoreBase.mode');

  @override
  String get mode {
    _$modeAtom.reportRead();
    return super.mode;
  }

  @override
  set mode(String value) {
    _$modeAtom.reportWrite(value, super.mode, () {
      super.mode = value;
    });
  }

  final _$msgErrOrGoalAtom = Atom(name: '_VerifyStoreBase.msgErrOrGoal');

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

  final _$_VerifyStoreBaseActionController =
      ActionController(name: '_VerifyStoreBase');

  @override
  dynamic setMode(dynamic value) {
    final _$actionInfo = _$_VerifyStoreBaseActionController.startAction(
        name: '_VerifyStoreBase.setMode');
    try {
      return super.setMode(value);
    } finally {
      _$_VerifyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCode(dynamic value) {
    final _$actionInfo = _$_VerifyStoreBaseActionController.startAction(
        name: '_VerifyStoreBase.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_VerifyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsgErrOrGoal(dynamic value) {
    final _$actionInfo = _$_VerifyStoreBaseActionController.startAction(
        name: '_VerifyStoreBase.setMsgErrOrGoal');
    try {
      return super.setMsgErrOrGoal(value);
    } finally {
      _$_VerifyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsg(dynamic value) {
    final _$actionInfo = _$_VerifyStoreBaseActionController.startAction(
        name: '_VerifyStoreBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_VerifyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic emailVerify() {
    final _$actionInfo = _$_VerifyStoreBaseActionController.startAction(
        name: '_VerifyStoreBase.emailVerify');
    try {
      return super.emailVerify();
    } finally {
      _$_VerifyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
code: ${code},
msg: ${msg},
mode: ${mode},
msgErrOrGoal: ${msgErrOrGoal}
    ''';
  }
}
