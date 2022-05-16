// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TarefasStore on _TarefasStoreBase, Store {
  late final _$themeAtom =
      Atom(name: '_TarefasStoreBase.theme', context: context);

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

  late final _$themeLoadingAtom =
      Atom(name: '_TarefasStoreBase.themeLoading', context: context);

  @override
  bool get themeLoading {
    _$themeLoadingAtom.reportRead();
    return super.themeLoading;
  }

  @override
  set themeLoading(bool value) {
    _$themeLoadingAtom.reportWrite(value, super.themeLoading, () {
      super.themeLoading = value;
    });
  }

  late final _$_TarefasStoreBaseActionController =
      ActionController(name: '_TarefasStoreBase', context: context);

  @override
  dynamic setTheme(dynamic value) {
    final _$actionInfo = _$_TarefasStoreBaseActionController.startAction(
        name: '_TarefasStoreBase.setTheme');
    try {
      return super.setTheme(value);
    } finally {
      _$_TarefasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setThemeLoading(dynamic value) {
    final _$actionInfo = _$_TarefasStoreBaseActionController.startAction(
        name: '_TarefasStoreBase.setThemeLoading');
    try {
      return super.setThemeLoading(value);
    } finally {
      _$_TarefasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
theme: ${theme},
themeLoading: ${themeLoading}
    ''';
  }
}
