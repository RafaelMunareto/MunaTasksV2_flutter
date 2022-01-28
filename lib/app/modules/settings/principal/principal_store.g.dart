// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrincipalStore on _PrincipalStoreBase, Store {
  final _$finalizeAtom = Atom(name: '_PrincipalStoreBase.finalize');

  @override
  bool get finalize {
    _$finalizeAtom.reportRead();
    return super.finalize;
  }

  @override
  set finalize(bool value) {
    _$finalizeAtom.reportWrite(value, super.finalize, () {
      super.finalize = value;
    });
  }

  final _$isSwitchedAtom = Atom(name: '_PrincipalStoreBase.isSwitched');

  @override
  bool get isSwitched {
    _$isSwitchedAtom.reportRead();
    return super.isSwitched;
  }

  @override
  set isSwitched(bool value) {
    _$isSwitchedAtom.reportWrite(value, super.isSwitched, () {
      super.isSwitched = value;
    });
  }

  final _$buscaThemeAsyncAction = AsyncAction('_PrincipalStoreBase.buscaTheme');

  @override
  Future buscaTheme() {
    return _$buscaThemeAsyncAction.run(() => super.buscaTheme());
  }

  final _$_PrincipalStoreBaseActionController =
      ActionController(name: '_PrincipalStoreBase');

  @override
  dynamic setfinalize(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setfinalize');
    try {
      return super.setfinalize(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsSwitched(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setIsSwitched');
    try {
      return super.setIsSwitched(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSwitch(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.changeSwitch');
    try {
      return super.changeSwitch(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
finalize: ${finalize},
isSwitched: ${isSwitched}
    ''';
  }
}
