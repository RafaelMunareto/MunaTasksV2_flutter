// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<dynamic>? _$loginComputed;

  @override
  dynamic get login => (_$loginComputed ??=
          Computed<dynamic>(() => super.login, name: '_LoginStoreBase.login'))
      .value;

  final _$supportStateAtom = Atom(name: '_LoginStoreBase.supportState');

  @override
  SupportState get supportState {
    _$supportStateAtom.reportRead();
    return super.supportState;
  }

  @override
  set supportState(SupportState value) {
    _$supportStateAtom.reportWrite(value, super.supportState, () {
      super.supportState = value;
    });
  }

  final _$loadingAtom = Atom(name: '_LoginStoreBase.loading');

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

  final _$msgAtom = Atom(name: '_LoginStoreBase.msg');

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

  final _$faceOrFingerAtom = Atom(name: '_LoginStoreBase.faceOrFinger');

  @override
  bool get faceOrFinger {
    _$faceOrFingerAtom.reportRead();
    return super.faceOrFinger;
  }

  @override
  set faceOrFinger(bool value) {
    _$faceOrFingerAtom.reportWrite(value, super.faceOrFinger, () {
      super.faceOrFinger = value;
    });
  }

  final _$errOrGoalAtom = Atom(name: '_LoginStoreBase.errOrGoal');

  @override
  bool get errOrGoal {
    _$errOrGoalAtom.reportRead();
    return super.errOrGoal;
  }

  @override
  set errOrGoal(bool value) {
    _$errOrGoalAtom.reportWrite(value, super.errOrGoal, () {
      super.errOrGoal = value;
    });
  }

  final _$loginStorageAtom = Atom(name: '_LoginStoreBase.loginStorage');

  @override
  List<String>? get loginStorage {
    _$loginStorageAtom.reportRead();
    return super.loginStorage;
  }

  @override
  set loginStorage(List<String>? value) {
    _$loginStorageAtom.reportWrite(value, super.loginStorage, () {
      super.loginStorage = value;
    });
  }

  final _$canCheckBiometricsAtom =
      Atom(name: '_LoginStoreBase.canCheckBiometrics');

  @override
  bool get canCheckBiometrics {
    _$canCheckBiometricsAtom.reportRead();
    return super.canCheckBiometrics;
  }

  @override
  set canCheckBiometrics(bool value) {
    _$canCheckBiometricsAtom.reportWrite(value, super.canCheckBiometrics, () {
      super.canCheckBiometrics = value;
    });
  }

  final _$availableBiometricsAtom =
      Atom(name: '_LoginStoreBase.availableBiometrics');

  @override
  List<BiometricType> get availableBiometrics {
    _$availableBiometricsAtom.reportRead();
    return super.availableBiometrics;
  }

  @override
  set availableBiometrics(List<BiometricType> value) {
    _$availableBiometricsAtom.reportWrite(value, super.availableBiometrics, () {
      super.availableBiometrics = value;
    });
  }

  final _$authorizedAtom = Atom(name: '_LoginStoreBase.authorized');

  @override
  String get authorized {
    _$authorizedAtom.reportRead();
    return super.authorized;
  }

  @override
  set authorized(String value) {
    _$authorizedAtom.reportWrite(value, super.authorized, () {
      super.authorized = value;
    });
  }

  final _$isAuthenticatingAtom = Atom(name: '_LoginStoreBase.isAuthenticating');

  @override
  bool get isAuthenticating {
    _$isAuthenticatingAtom.reportRead();
    return super.isAuthenticating;
  }

  @override
  set isAuthenticating(bool value) {
    _$isAuthenticatingAtom.reportWrite(value, super.isAuthenticating, () {
      super.isAuthenticating = value;
    });
  }

  final _$submitAsyncAction = AsyncAction('_LoginStoreBase.submit');

  @override
  Future submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  final _$loginWithGoogleAsyncAction =
      AsyncAction('_LoginStoreBase.loginWithGoogle');

  @override
  Future loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  final _$getAvailableBiometricsAsyncAction =
      AsyncAction('_LoginStoreBase.getAvailableBiometrics');

  @override
  Future getAvailableBiometrics() {
    return _$getAvailableBiometricsAsyncAction
        .run(() => super.getAvailableBiometrics());
  }

  final _$getStorageLoginAsyncAction =
      AsyncAction('_LoginStoreBase.getStorageLogin');

  @override
  Future getStorageLogin() {
    return _$getStorageLoginAsyncAction.run(() => super.getStorageLogin());
  }

  final _$getStorageLoginNormalAsyncAction =
      AsyncAction('_LoginStoreBase.getStorageLoginNormal');

  @override
  Future getStorageLoginNormal() {
    return _$getStorageLoginNormalAsyncAction
        .run(() => super.getStorageLoginNormal());
  }

  final _$checkSupportDeviceAsyncAction =
      AsyncAction('_LoginStoreBase.checkSupportDevice');

  @override
  Future checkSupportDevice() {
    return _$checkSupportDeviceAsyncAction
        .run(() => super.checkSupportDevice());
  }

  final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase');

  @override
  dynamic setErrOrGoal(dynamic value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setErrOrGoal');
    try {
      return super.setErrOrGoal(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsg(dynamic value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic checkBiometrics() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.checkBiometrics');
    try {
      return super.checkBiometrics();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic authenticateBiometric() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.authenticateBiometric');
    try {
      return super.authenticateBiometric();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStorageLogin() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setStorageLogin');
    try {
      return super.setStorageLogin();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStorageLoginNormal() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setStorageLoginNormal');
    try {
      return super.setStorageLoginNormal();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic submitStorage() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.submitStorage');
    try {
      return super.submitStorage();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
supportState: ${supportState},
loading: ${loading},
msg: ${msg},
faceOrFinger: ${faceOrFinger},
errOrGoal: ${errOrGoal},
loginStorage: ${loginStorage},
canCheckBiometrics: ${canCheckBiometrics},
availableBiometrics: ${availableBiometrics},
authorized: ${authorized},
isAuthenticating: ${isAuthenticating},
login: ${login}
    ''';
  }
}
