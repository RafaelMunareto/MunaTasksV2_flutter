// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilStore on _PerfilStoreBase, Store {
  final _$perfilAtom = Atom(name: '_PerfilStoreBase.perfil');

  @override
  PerfilModel get perfil {
    _$perfilAtom.reportRead();
    return super.perfil;
  }

  @override
  set perfil(PerfilModel value) {
    _$perfilAtom.reportWrite(value, super.perfil, () {
      super.perfil = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PerfilStoreBase.loading');

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

  final _$userModelAtom = Atom(name: '_PerfilStoreBase.userModel');

  @override
  List<dynamic> get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(List<dynamic> value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$_PerfilStoreBaseActionController =
      ActionController(name: '_PerfilStoreBase');

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getById() {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.getById');
    try {
      return super.getById();
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
perfil: ${perfil},
loading: ${loading},
userModel: ${userModel}
    ''';
  }
}
