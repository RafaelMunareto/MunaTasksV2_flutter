// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientStore on _ClientStoreBase, Store {
  Computed<bool>? _$isValideNameComputed;

  @override
  bool get isValideName =>
      (_$isValideNameComputed ??= Computed<bool>(() => super.isValideName,
              name: '_ClientStoreBase.isValideName'))
          .value;
  Computed<bool>? _$isValideNameTimeComputed;

  @override
  bool get isValideNameTime => (_$isValideNameTimeComputed ??= Computed<bool>(
          () => super.isValideNameTime,
          name: '_ClientStoreBase.isValideNameTime'))
      .value;

  late final _$urlImagemRecuperadaAtom =
      Atom(name: '_ClientStoreBase.urlImagemRecuperada', context: context);

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

  late final _$themeAtom =
      Atom(name: '_ClientStoreBase.theme', context: context);

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

  late final _$showTeamsAtom =
      Atom(name: '_ClientStoreBase.showTeams', context: context);

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

  late final _$loadingAtom =
      Atom(name: '_ClientStoreBase.loading', context: context);

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

  late final _$loadingImagemAtom =
      Atom(name: '_ClientStoreBase.loadingImagem', context: context);

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

  late final _$userModelAtom =
      Atom(name: '_ClientStoreBase.userModel', context: context);

  @override
  List<PerfilDioModel> get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(List<PerfilDioModel> value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  late final _$perfisAtom =
      Atom(name: '_ClientStoreBase.perfis', context: context);

  @override
  List<PerfilDioModel> get perfis {
    _$perfisAtom.reportRead();
    return super.perfis;
  }

  @override
  set perfis(List<PerfilDioModel> value) {
    _$perfisAtom.reportWrite(value, super.perfis, () {
      super.perfis = value;
    });
  }

  late final _$inputChipAtom =
      Atom(name: '_ClientStoreBase.inputChip', context: context);

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

  late final _$individualChipAtom =
      Atom(name: '_ClientStoreBase.individualChip', context: context);

  @override
  List<dynamic> get individualChip {
    _$individualChipAtom.reportRead();
    return super.individualChip;
  }

  @override
  set individualChip(List<dynamic> value) {
    _$individualChipAtom.reportWrite(value, super.individualChip, () {
      super.individualChip = value;
    });
  }

  late final _$textFieldNameBoolAtom =
      Atom(name: '_ClientStoreBase.textFieldNameBool', context: context);

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

  late final _$nameTimeAtom =
      Atom(name: '_ClientStoreBase.nameTime', context: context);

  @override
  String get nameTime {
    _$nameTimeAtom.reportRead();
    return super.nameTime;
  }

  @override
  set nameTime(String value) {
    _$nameTimeAtom.reportWrite(value, super.nameTime, () {
      super.nameTime = value;
    });
  }

  late final _$userSelectionAtom =
      Atom(name: '_ClientStoreBase.userSelection', context: context);

  @override
  UserDioClientModel get userSelection {
    _$userSelectionAtom.reportRead();
    return super.userSelection;
  }

  @override
  set userSelection(UserDioClientModel value) {
    _$userSelectionAtom.reportWrite(value, super.userSelection, () {
      super.userSelection = value;
    });
  }

  late final _$perfilDioAtom =
      Atom(name: '_ClientStoreBase.perfilDio', context: context);

  @override
  PerfilDioModel get perfilDio {
    _$perfilDioAtom.reportRead();
    return super.perfilDio;
  }

  @override
  set perfilDio(PerfilDioModel value) {
    _$perfilDioAtom.reportWrite(value, super.perfilDio, () {
      super.perfilDio = value;
    });
  }

  late final _$usersAtom =
      Atom(name: '_ClientStoreBase.users', context: context);

  @override
  List<dynamic> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<dynamic> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$urlImageAtom =
      Atom(name: '_ClientStoreBase.urlImage', context: context);

  @override
  String get urlImage {
    _$urlImageAtom.reportRead();
    return super.urlImage;
  }

  @override
  set urlImage(String value) {
    _$urlImageAtom.reportWrite(value, super.urlImage, () {
      super.urlImage = value;
    });
  }

  late final _$setIdStaffAsyncAction =
      AsyncAction('_ClientStoreBase.setIdStaff', context: context);

  @override
  Future setIdStaff(dynamic value) {
    return _$setIdStaffAsyncAction.run(() => super.setIdStaff(value));
  }

  late final _$_ClientStoreBaseActionController =
      ActionController(name: '_ClientStoreBase', context: context);

  @override
  dynamic setTheme(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setTheme');
    try {
      return super.setTheme(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPerfis(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setPerfis');
    try {
      return super.setPerfis(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showTextFieldName(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.showTextFieldName');
    try {
      return super.showTextFieldName(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setInputChip(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setInputChip');
    try {
      return super.setInputChip(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowTeams(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setShowTeams');
    try {
      return super.setShowTeams(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingImagem(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setLoadingImagem');
    try {
      return super.setLoadingImagem(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeName(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.changeName');
    try {
      return super.changeName(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeManager(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.changeManager');
    try {
      return super.changeManager(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeTime(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.changeTime');
    try {
      return super.changeTime(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNameTime(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setNameTime');
    try {
      return super.setNameTime(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPerfilImage(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setPerfilImage');
    try {
      return super.setPerfilImage(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic inputChipChecked(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.inputChipChecked');
    try {
      return super.inputChipChecked(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserSelection(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setUserSelection');
    try {
      return super.setUserSelection(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPerfildio(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setPerfildio');
    try {
      return super.setPerfildio(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUsersDio(dynamic value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setUsersDio');
    try {
      return super.setUsersDio(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
urlImagemRecuperada: ${urlImagemRecuperada},
theme: ${theme},
showTeams: ${showTeams},
loading: ${loading},
loadingImagem: ${loadingImagem},
userModel: ${userModel},
perfis: ${perfis},
inputChip: ${inputChip},
individualChip: ${individualChip},
textFieldNameBool: ${textFieldNameBool},
nameTime: ${nameTime},
userSelection: ${userSelection},
perfilDio: ${perfilDio},
users: ${users},
urlImage: ${urlImage},
isValideName: ${isValideName},
isValideNameTime: ${isValideNameTime}
    ''';
  }
}
