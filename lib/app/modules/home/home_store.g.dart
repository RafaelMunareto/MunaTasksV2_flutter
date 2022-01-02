// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$badgetNavigateAtom = Atom(name: 'HomeStoreBase.badgetNavigate');

  @override
  List<int> get badgetNavigate {
    _$badgetNavigateAtom.reportRead();
    return super.badgetNavigate;
  }

  @override
  set badgetNavigate(List<int> value) {
    _$badgetNavigateAtom.reportWrite(value, super.badgetNavigate, () {
      super.badgetNavigate = value;
    });
  }

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

  final _$tarefasAtom = Atom(name: 'HomeStoreBase.tarefas');

  @override
  List<TarefaModel> get tarefas {
    _$tarefasAtom.reportRead();
    return super.tarefas;
  }

  @override
  set tarefas(List<TarefaModel> value) {
    _$tarefasAtom.reportWrite(value, super.tarefas, () {
      super.tarefas = value;
    });
  }

  final _$tarefasBaseAtom = Atom(name: 'HomeStoreBase.tarefasBase');

  @override
  List<TarefaModel> get tarefasBase {
    _$tarefasBaseAtom.reportRead();
    return super.tarefasBase;
  }

  @override
  set tarefasBase(List<TarefaModel> value) {
    _$tarefasBaseAtom.reportWrite(value, super.tarefasBase, () {
      super.tarefasBase = value;
    });
  }

  final _$loadingAtom = Atom(name: 'HomeStoreBase.loading');

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
  Stream<List<TarefaModel?>>? get dashboardList {
    _$dashboardListAtom.reportRead();
    return super.dashboardList;
  }

  @override
  set dashboardList(Stream<List<TarefaModel?>>? value) {
    _$dashboardListAtom.reportWrite(value, super.dashboardList, () {
      super.dashboardList = value;
    });
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  dynamic setBadgetNavigate(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setBadgetNavigate');
    try {
      return super.setBadgetNavigate(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTarefa(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setTarefa');
    try {
      return super.setTarefa(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeTarefa(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeTarefa');
    try {
      return super.changeTarefa(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanTarefas() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.cleanTarefas');
    try {
      return super.cleanTarefas();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void deleteTasks(TarefaModel model) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.deleteTasks');
    try {
      return super.deleteTasks(model);
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
badgetNavigate: ${badgetNavigate},
cardSelection: ${cardSelection},
tarefas: ${tarefas},
tarefasBase: ${tarefasBase},
loading: ${loading},
navigateBarSelection: ${navigateBarSelection},
dashboardList: ${dashboardList}
    ''';
  }
}
