// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  late final _$statusAtom =
      Atom(name: '_AuthControllerBase.status', context: context);

  @override
  AuthStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_AuthControllerBase.user', context: context);

  @override
  UserDioClientModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserDioClientModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase', context: context);

  @override
  dynamic setUser(UserDioClientModel value) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> loginWithGoogle() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.loginWithGoogle');
    try {
      return super.loginWithGoogle();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic logout() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.logout');
    try {
      return super.logout();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> checkBiometrics() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.checkBiometrics');
    try {
      return super.checkBiometrics();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> getAvailableBiometrics() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.getAvailableBiometrics');
    try {
      return super.getAvailableBiometrics();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<String> authenticateWithBiometrics(bool faceOrFinger) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.authenticateWithBiometrics');
    try {
      return super.authenticateWithBiometrics(faceOrFinger);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancelAuthentication() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.cancelAuthentication');
    try {
      return super.cancelAuthentication();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> getLoginDio(dynamic email, dynamic password) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.getLoginDio');
    try {
      return super.getLoginDio(email, password);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic saveUser(UserDioClientModel model) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.saveUser');
    try {
      return super.saveUser(model);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> perfilUser(UserDioClientModel user) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.perfilUser');
    try {
      return super.perfilUser(user);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> sendEmailChangePassword(String email) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.sendEmailChangePassword');
    try {
      return super.sendEmailChangePassword(email);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> changeUserPassword(String id, String password) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.changeUserPassword');
    try {
      return super.changeUserPassword(id, password);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
user: ${user}
    ''';
  }
}
