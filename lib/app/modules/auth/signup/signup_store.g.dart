// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignupStore on _SignupStoreBase, Store {
  Computed<bool>? _$isValidRegisterEmailGrupoComputed;

  @override
  bool get isValidRegisterEmailGrupo => (_$isValidRegisterEmailGrupoComputed ??=
          Computed<bool>(() => super.isValidRegisterEmailGrupo,
              name: '_SignupStoreBase.isValidRegisterEmailGrupo'))
      .value;

  late final _$_SignupStoreBaseActionController =
      ActionController(name: '_SignupStoreBase', context: context);

  @override
  void submit() {
    final _$actionInfo = _$_SignupStoreBaseActionController.startAction(
        name: '_SignupStoreBase.submit');
    try {
      return super.submit();
    } finally {
      _$_SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isValidRegisterEmailGrupo: ${isValidRegisterEmailGrupo}
    ''';
  }
}
