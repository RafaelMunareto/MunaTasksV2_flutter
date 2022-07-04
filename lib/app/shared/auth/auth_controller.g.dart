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
  String toString() {
    return '''
status: ${status},
user: ${user}
    ''';
  }
}
