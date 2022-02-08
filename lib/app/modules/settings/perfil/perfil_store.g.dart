// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilStore on _PerfilStoreBase, Store {
  final _$uidAtom = Atom(name: '_PerfilStoreBase.uid');

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  final _$getByIdAsyncAction = AsyncAction('_PerfilStoreBase.getById');

  @override
  Future getById() {
    return _$getByIdAsyncAction.run(() => super.getById());
  }

  final _$_PerfilStoreBaseActionController =
      ActionController(name: '_PerfilStoreBase');

  @override
  dynamic getUid() {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.getUid');
    try {
      return super.getUid();
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getUsers() {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.getUsers');
    try {
      return super.getUsers();
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic save() {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.save');
    try {
      return super.save();
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uid: ${uid}
    ''';
  }
}
