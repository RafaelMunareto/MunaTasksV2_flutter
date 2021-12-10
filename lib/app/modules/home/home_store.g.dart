// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$versionListAtom = Atom(name: 'HomeStoreBase.versionList');

  @override
  ObservableStream<List<VersionModel>>? get versionList {
    _$versionListAtom.reportRead();
    return super.versionList;
  }

  @override
  set versionList(ObservableStream<List<VersionModel>>? value) {
    _$versionListAtom.reportWrite(value, super.versionList, () {
      super.versionList = value;
    });
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  void getList() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getList');
    try {
      return super.getList();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void save(VersionModel model) {
    final _$actionInfo =
        _$HomeStoreBaseActionController.startAction(name: 'HomeStoreBase.save');
    try {
      return super.save(model);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(VersionModel model) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.delete');
    try {
      return super.delete(model);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.logout');
    try {
      return super.logout();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
versionList: ${versionList}
    ''';
  }
}
