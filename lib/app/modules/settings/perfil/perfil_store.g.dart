// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilStore on _PerfilStoreBase, Store {
  final _$urlImagemRecuperadaAtom =
      Atom(name: '_PerfilStoreBase.urlImagemRecuperada');

  @override
  String get urlImagemRecuperada {
    _$urlImagemRecuperadaAtom.reportRead();
    return super.urlImagemRecuperada;
  }

  @override
  set urlImagemRecuperada(String value) {
    _$urlImagemRecuperadaAtom.reportWrite(value, super.urlImagemRecuperada, () {
      super.urlImagemRecuperada = value;
    });
  }

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

  final _$loadingImagemAtom = Atom(name: '_PerfilStoreBase.loadingImagem');

  @override
  bool get loadingImagem {
    _$loadingImagemAtom.reportRead();
    return super.loadingImagem;
  }

  @override
  set loadingImagem(bool value) {
    _$loadingImagemAtom.reportWrite(value, super.loadingImagem, () {
      super.loadingImagem = value;
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

  final _$recuperarImagemAsyncAction =
      AsyncAction('_PerfilStoreBase.recuperarImagem');

  @override
  Future<dynamic> recuperarImagem(String origemImagem) {
    return _$recuperarImagemAsyncAction
        .run(() => super.recuperarImagem(origemImagem));
  }

  final _$uploadImagemAsyncAction =
      AsyncAction('_PerfilStoreBase.uploadImagem');

  @override
  Future<dynamic> uploadImagem(XFile image) {
    return _$uploadImagemAsyncAction.run(() => super.uploadImagem(image));
  }

  final _$recuperarUrlImagemAsyncAction =
      AsyncAction('_PerfilStoreBase.recuperarUrlImagem');

  @override
  Future<dynamic> recuperarUrlImagem(TaskSnapshot snapshot) {
    return _$recuperarUrlImagemAsyncAction
        .run(() => super.recuperarUrlImagem(snapshot));
  }

  final _$_PerfilStoreBaseActionController =
      ActionController(name: '_PerfilStoreBase');

  @override
  dynamic setLoadingImagem(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.setLoadingImagem');
    try {
      return super.setLoadingImagem(value);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic atualizarUrlImagemFirestore(String url) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.atualizarUrlImagemFirestore');
    try {
      return super.atualizarUrlImagemFirestore(url);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
urlImagemRecuperada: ${urlImagemRecuperada},
perfil: ${perfil},
loading: ${loading},
loadingImagem: ${loadingImagem},
userModel: ${userModel}
    ''';
  }
}
