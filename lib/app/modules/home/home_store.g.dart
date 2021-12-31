// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$cardSelectionAtom = Atom(name: 'HomeStoreBase.cardSelection');

  @override
  String get cardSelection {
    _$cardSelectionAtom.reportRead();
    return super.cardSelection;
  }

  @override
  set cardSelection(String value) {
    _$cardSelectionAtom.reportWrite(value, super.cardSelection, () {
      super.cardSelection = value;
    });
  }

  final _$navigateBarSelectionAtom =
      Atom(name: 'HomeStoreBase.navigateBarSelection');

  @override
  int get navigateBarSelection {
    _$navigateBarSelectionAtom.reportRead();
    return super.navigateBarSelection;
  }

  @override
  set navigateBarSelection(int value) {
    _$navigateBarSelectionAtom.reportWrite(value, super.navigateBarSelection,
        () {
      super.navigateBarSelection = value;
    });
  }

  final _$dashboardListAtom = Atom(name: 'HomeStoreBase.dashboardList');

  @override
  ObservableStream<List<TarefaModel>>? get dashboardList {
    _$dashboardListAtom.reportRead();
    return super.dashboardList;
  }

  @override
  set dashboardList(ObservableStream<List<TarefaModel>>? value) {
    _$dashboardListAtom.reportWrite(value, super.dashboardList, () {
      super.dashboardList = value;
    });
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  dynamic setNavigateBarSelection(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setNavigateBarSelection');
    try {
      return super.setNavigateBarSelection(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelection(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setSelection');
    try {
      return super.setSelection(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void save(TarefaModel model) {
    final _$actionInfo =
        _$HomeStoreBaseActionController.startAction(name: 'HomeStoreBase.save');
    try {
      return super.save(model);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(TarefaModel model) {
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
cardSelection: ${cardSelection},
navigateBarSelection: ${navigateBarSelection},
dashboardList: ${dashboardList}
    ''';
  }
}
