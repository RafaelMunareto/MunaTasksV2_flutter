// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChangeStore on _ChangeStoreBase, Store {
  final _$loadingAtom = Atom(name: '_ChangeStoreBase.loading');

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

  final _$codeAtom = Atom(name: '_ChangeStoreBase.code');

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$msgAtom = Atom(name: '_ChangeStoreBase.msg');

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

  final _$msgErrOrGoalAtom = Atom(name: '_ChangeStoreBase.msgErrOrGoal');

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

  final _$_ChangeStoreBaseActionController =
      ActionController(name: '_ChangeStoreBase');

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
  dynamic submit() {
    final _$actionInfo = _$_ChangeStoreBaseActionController.startAction(
        name: '_ChangeStoreBase.submit');
    try {
      return super.submit();
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
msgErrOrGoal: ${msgErrOrGoal}
    ''';
  }
}
