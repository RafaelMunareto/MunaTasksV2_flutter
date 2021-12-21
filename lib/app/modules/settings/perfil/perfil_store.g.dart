// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilStore on _PerfilStoreBase, Store {
  Computed<bool>? _$isValideNameTimeComputed;

  @override
  bool get isValideNameTime => (_$isValideNameTimeComputed ??= Computed<bool>(
          () => super.isValideNameTime,
          name: '_PerfilStoreBase.isValideNameTime'))
      .value;
  Computed<bool>? _$isValideNameComputed;

  @override
  bool get isValideName =>
      (_$isValideNameComputed ??= Computed<bool>(() => super.isValideName,
              name: '_PerfilStoreBase.isValideName'))
          .value;

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

  final _$usuariosAtom = Atom(name: '_PerfilStoreBase.usuarios');

  @override
  ObservableStream<List<UserModel>>? get usuarios {
    _$usuariosAtom.reportRead();
    return super.usuarios;
  }

  @override
  set usuarios(ObservableStream<List<UserModel>>? value) {
    _$usuariosAtom.reportWrite(value, super.usuarios, () {
      super.usuarios = value;
    });
  }

  final _$showTeamsAtom = Atom(name: '_PerfilStoreBase.showTeams');

  @override
  bool get showTeams {
    _$showTeamsAtom.reportRead();
    return super.showTeams;
  }

  @override
  set showTeams(bool value) {
    _$showTeamsAtom.reportWrite(value, super.showTeams, () {
      super.showTeams = value;
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
  List<UserModel> get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(List<UserModel> value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$inputChipAtom = Atom(name: '_PerfilStoreBase.inputChip');

  @override
  bool get inputChip {
    _$inputChipAtom.reportRead();
    return super.inputChip;
  }

  @override
  set inputChip(bool value) {
    _$inputChipAtom.reportWrite(value, super.inputChip, () {
      super.inputChip = value;
    });
  }

  final _$individualChipAtom = Atom(name: '_PerfilStoreBase.individualChip');

  @override
  List<dynamic>? get individualChip {
    _$individualChipAtom.reportRead();
    return super.individualChip;
  }

  @override
  set individualChip(List<dynamic>? value) {
    _$individualChipAtom.reportWrite(value, super.individualChip, () {
      super.individualChip = value;
    });
  }

  final _$textFieldNameBoolAtom =
      Atom(name: '_PerfilStoreBase.textFieldNameBool');

  @override
  bool get textFieldNameBool {
    _$textFieldNameBoolAtom.reportRead();
    return super.textFieldNameBool;
  }

  @override
  set textFieldNameBool(bool value) {
    _$textFieldNameBoolAtom.reportWrite(value, super.textFieldNameBool, () {
      super.textFieldNameBool = value;
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
  dynamic setShowTeams(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.setShowTeams');
    try {
      return super.setShowTeams(value);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic setInputChip(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.setInputChip');
    try {
      return super.setInputChip(value);
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
  dynamic changeName(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.changeName');
    try {
      return super.changeName(value);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeManager(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.changeManager');
    try {
      return super.changeManager(value);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeTime(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.changeTime');
    try {
      return super.changeTime(value);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIdStaff(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.setIdStaff');
    try {
      return super.setIdStaff(value);
    } finally {
      _$_PerfilStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic inputChipChecked(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.inputChipChecked');
    try {
      return super.inputChipChecked(value);
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
  dynamic checkInput(String reference) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.checkInput');
    try {
      return super.checkInput(reference);
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
  dynamic showTextFieldName(dynamic value) {
    final _$actionInfo = _$_PerfilStoreBaseActionController.startAction(
        name: '_PerfilStoreBase.showTextFieldName');
    try {
      return super.showTextFieldName(value);
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
usuarios: ${usuarios},
showTeams: ${showTeams},
perfil: ${perfil},
loading: ${loading},
loadingImagem: ${loadingImagem},
userModel: ${userModel},
inputChip: ${inputChip},
individualChip: ${individualChip},
textFieldNameBool: ${textFieldNameBool},
isValideNameTime: ${isValideNameTime},
isValideName: ${isValideName}
    ''';
  }
}
