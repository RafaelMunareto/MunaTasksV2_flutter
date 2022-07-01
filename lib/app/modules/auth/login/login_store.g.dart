// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  late final _$getAvailableBiometricsAsyncAction =
      AsyncAction('_LoginStoreBase.getAvailableBiometrics', context: context);

  @override
  Future getAvailableBiometrics() {
    return _$getAvailableBiometricsAsyncAction
        .run(() => super.getAvailableBiometrics());
  }

  late final _$getStorageLoginAsyncAction =
      AsyncAction('_LoginStoreBase.getStorageLogin', context: context);

  @override
  Future getStorageLogin() {
    return _$getStorageLoginAsyncAction.run(() => super.getStorageLogin());
  }

  late final _$checkSupportDeviceAsyncAction =
      AsyncAction('_LoginStoreBase.checkSupportDevice', context: context);

  @override
  Future checkSupportDevice() {
    return _$checkSupportDeviceAsyncAction
        .run(() => super.checkSupportDevice());
  }

  late final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase', context: context);

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

    ''';
  }
}
