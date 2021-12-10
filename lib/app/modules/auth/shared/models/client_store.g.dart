// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientStore on _ClientStoreBase, Store {
  Computed<bool>? _$isValidLoginComputed;

  @override
  bool get isValidLogin =>
      (_$isValidLoginComputed ??= Computed<bool>(() => super.isValidLogin,
              name: '_ClientStoreBase.isValidLogin'))
          .value;
  Computed<bool>? _$isValidChangePasswordComputed;

  @override
  bool get isValidChangePassword => (_$isValidChangePasswordComputed ??=
          Computed<bool>(() => super.isValidChangePassword,
              name: '_ClientStoreBase.isValidChangePassword'))
      .value;
  Computed<bool>? _$isValidEmailComputed;

  @override
  bool get isValidEmail =>
      (_$isValidEmailComputed ??= Computed<bool>(() => super.isValidEmail,
              name: '_ClientStoreBase.isValidEmail'))
          .value;

  final _$nameAtom = Atom(name: '_ClientStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_ClientStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_ClientStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_ClientStoreBase.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$_ClientStoreBaseActionController =
      ActionController(name: '_ClientStoreBase');

  @override
  dynamic changeName(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.changeName');
    try {
      return super.changeName(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmail(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.changeEmail');
    try {
      return super.changeEmail(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.changePassword');
    try {
      return super.changePassword(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeConfirmPassword(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.changeConfirmPassword');
    try {
      return super.changeConfirmPassword(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCleanVariables() {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction(
        name: '_ClientStoreBase.setCleanVariables');
    try {
      return super.setCleanVariables();
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
isValidLogin: ${isValidLogin},
isValidChangePassword: ${isValidChangePassword},
isValidEmail: ${isValidEmail}
    ''';
  }
}
