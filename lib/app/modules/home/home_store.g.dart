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

  final _$etiquetaListAtom = Atom(name: 'HomeStoreBase.etiquetaList');

  @override
  ObservableStream<List<EtiquetaModel>>? get etiquetaList {
    _$etiquetaListAtom.reportRead();
    return super.etiquetaList;
  }

  @override
  set etiquetaList(ObservableStream<List<EtiquetaModel>>? value) {
    _$etiquetaListAtom.reportWrite(value, super.etiquetaList, () {
      super.etiquetaList = value;
    });
  }

  final _$openAtom = Atom(name: 'HomeStoreBase.open');

  @override
  bool get open {
    _$openAtom.reportRead();
    return super.open;
  }

  @override
  set open(bool value) {
    _$openAtom.reportWrite(value, super.open, () {
      super.open = value;
    });
  }

  final _$etiquetaSelectionAtom = Atom(name: 'HomeStoreBase.etiquetaSelection');

  @override
  String get etiquetaSelection {
    _$etiquetaSelectionAtom.reportRead();
    return super.etiquetaSelection;
  }

  @override
  set etiquetaSelection(String value) {
    _$etiquetaSelectionAtom.reportWrite(value, super.etiquetaSelection, () {
      super.etiquetaSelection = value;
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

  final _$themeAtom = Atom(name: 'HomeStoreBase.theme');

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

  final _$colorAtom = Atom(name: 'HomeStoreBase.color');

  @override
  String get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(String value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$iconAtom = Atom(name: 'HomeStoreBase.icon');

  @override
  int get icon {
    _$iconAtom.reportRead();
    return super.icon;
  }

  @override
  set icon(int value) {
    _$iconAtom.reportWrite(value, super.icon, () {
      super.icon = value;
    });
  }

  final _$closedListExpandedAtom =
      Atom(name: 'HomeStoreBase.closedListExpanded');

  @override
  bool get closedListExpanded {
    _$closedListExpandedAtom.reportRead();
    return super.closedListExpanded;
  }

  @override
  set closedListExpanded(bool value) {
    _$closedListExpandedAtom.reportWrite(value, super.closedListExpanded, () {
      super.closedListExpanded = value;
    });
  }

  final _$dashboardListAtom = Atom(name: 'HomeStoreBase.dashboardList');

  @override
  Stream<List<dynamic>>? get dashboardList {
    _$dashboardListAtom.reportRead();
    return super.dashboardList;
  }

  @override
  set dashboardList(Stream<List<dynamic>>? value) {
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
  dynamic setEtiquetaSelection(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setEtiquetaSelection');
    try {
      return super.setEtiquetaSelection(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setOpen(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setOpen');
    try {
      return super.setOpen(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscaTheme() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.buscaTheme');
    try {
      return super.buscaTheme();
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
  dynamic cleanTarefasBase() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.cleanTarefasBase');
    try {
      return super.cleanTarefasBase();
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
  dynamic setColor(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setColor');
    try {
      return super.setColor(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIcon(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setIcon');
    try {
      return super.setIcon(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setClosedListExpanded(dynamic value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setClosedListExpanded');
    try {
      return super.setClosedListExpanded(value);
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
  void getEtiquetas() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getEtiquetas');
    try {
      return super.getEtiquetas();
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
  dynamic tratamentoBase(Stream<List<dynamic>>? dashboardList) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.tratamentoBase');
    try {
      return super.tratamentoBase(dashboardList);
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
  dynamic changeFilterEtiquetaList(String value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeFilterEtiquetaList');
    try {
      return super.changeFilterEtiquetaList(value);
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
etiquetaList: ${etiquetaList},
open: ${open},
etiquetaSelection: ${etiquetaSelection},
tarefasBase: ${tarefasBase},
loading: ${loading},
theme: ${theme},
navigateBarSelection: ${navigateBarSelection},
color: ${color},
icon: ${icon},
closedListExpanded: ${closedListExpanded},
dashboardList: ${dashboardList}
    ''';
  }
}
