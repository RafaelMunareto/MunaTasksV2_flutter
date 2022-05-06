// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrincipalStore on _PrincipalStoreBase, Store {
  Computed<bool>? _$isValidTarefaComputed;

  @override
  bool get isValidTarefa =>
      (_$isValidTarefaComputed ??= Computed<bool>(() => super.isValidTarefa,
              name: '_PrincipalStoreBase.isValidTarefa'))
          .value;

  final _$userAtom = Atom(name: '_PrincipalStoreBase.user');

  @override
  UserDioClientModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserDioClientModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$perfilAtom = Atom(name: '_PrincipalStoreBase.perfil');

  @override
  PerfilDioModel get perfil {
    _$perfilAtom.reportRead();
    return super.perfil;
  }

  @override
  set perfil(PerfilDioModel value) {
    _$perfilAtom.reportWrite(value, super.perfil, () {
      super.perfil = value;
    });
  }

  final _$settingsUserAtom = Atom(name: '_PrincipalStoreBase.settingsUser');

  @override
  SettingsUserModel get settingsUser {
    _$settingsUserAtom.reportRead();
    return super.settingsUser;
  }

  @override
  set settingsUser(SettingsUserModel value) {
    _$settingsUserAtom.reportWrite(value, super.settingsUser, () {
      super.settingsUser = value;
    });
  }

  final _$loadingSettingsUserAtom =
      Atom(name: '_PrincipalStoreBase.loadingSettingsUser');

  @override
  bool get loadingSettingsUser {
    _$loadingSettingsUserAtom.reportRead();
    return super.loadingSettingsUser;
  }

  @override
  set loadingSettingsUser(bool value) {
    _$loadingSettingsUserAtom.reportWrite(value, super.loadingSettingsUser, () {
      super.loadingSettingsUser = value;
    });
  }

  final _$valueEscolhaAtom = Atom(name: '_PrincipalStoreBase.valueEscolha');

  @override
  dynamic get valueEscolha {
    _$valueEscolhaAtom.reportRead();
    return super.valueEscolha;
  }

  @override
  set valueEscolha(dynamic value) {
    _$valueEscolhaAtom.reportWrite(value, super.valueEscolha, () {
      super.valueEscolha = value;
    });
  }

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

  final _$escolhaAtom = Atom(name: '_PrincipalStoreBase.escolha');

  @override
  List<dynamic> get escolha {
    _$escolhaAtom.reportRead();
    return super.escolha;
  }

  @override
  set escolha(List<dynamic> value) {
    _$escolhaAtom.reportWrite(value, super.escolha, () {
      super.escolha = value;
    });
  }

  final _$labelAtom = Atom(name: '_PrincipalStoreBase.label');

  @override
  String get label {
    _$labelAtom.reportRead();
    return super.label;
  }

  @override
  set label(String value) {
    _$labelAtom.reportWrite(value, super.label, () {
      super.label = value;
    });
  }

  final _$settingsAtom = Atom(name: '_PrincipalStoreBase.settings');

  @override
  SettingsModel get settings {
    _$settingsAtom.reportRead();
    return super.settings;
  }

  @override
  set settings(SettingsModel value) {
    _$settingsAtom.reportWrite(value, super.settings, () {
      super.settings = value;
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
  dynamic setUser(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPerfil(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setPerfil');
    try {
      return super.setPerfil(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSettingsUser(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setSettingsUser');
    try {
      return super.setSettingsUser(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingSettingsUser(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setLoadingSettingsUser');
    try {
      return super.setLoadingSettingsUser(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValueEscolha(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setValueEscolha');
    try {
      return super.setValueEscolha(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic setLabel(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setLabel');
    try {
      return super.setLabel(value);
    } finally {
      _$_PrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEscolha(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setEscolha');
    try {
      return super.setEscolha(value);
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
  dynamic setSettings(dynamic value) {
    final _$actionInfo = _$_PrincipalStoreBaseActionController.startAction(
        name: '_PrincipalStoreBase.setSettings');
    try {
      return super.setSettings(value);
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
user: ${user},
perfil: ${perfil},
settingsUser: ${settingsUser},
loadingSettingsUser: ${loadingSettingsUser},
valueEscolha: ${valueEscolha},
finalize: ${finalize},
isSwitched: ${isSwitched},
escolha: ${escolha},
label: ${label},
settings: ${settings},
isValidTarefa: ${isValidTarefa}
    ''';
  }
}
