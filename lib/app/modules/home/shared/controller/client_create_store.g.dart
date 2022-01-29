// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientCreateStore on _ClientCreateStoreBase, Store {
  final _$subtarefaInsertListAtom =
      Atom(name: '_ClientCreateStoreBase.subtarefaInsertList');

  @override
  ObservableStream<List<SubtarefaInsertModel>>? get subtarefaInsertList {
    _$subtarefaInsertListAtom.reportRead();
    return super.subtarefaInsertList;
  }

  @override
  set subtarefaInsertList(ObservableStream<List<SubtarefaInsertModel>>? value) {
    _$subtarefaInsertListAtom.reportWrite(value, super.subtarefaInsertList, () {
      super.subtarefaInsertList = value;
    });
  }

  final _$tarefaModelSaveAtom =
      Atom(name: '_ClientCreateStoreBase.tarefaModelSave');

  @override
  TarefaModel get tarefaModelSave {
    _$tarefaModelSaveAtom.reportRead();
    return super.tarefaModelSave;
  }

  @override
  set tarefaModelSave(TarefaModel value) {
    _$tarefaModelSaveAtom.reportWrite(value, super.tarefaModelSave, () {
      super.tarefaModelSave = value;
    });
  }

  final _$saveEtiquetaAtom = Atom(name: '_ClientCreateStoreBase.saveEtiqueta');

  @override
  EtiquetaModel get saveEtiqueta {
    _$saveEtiquetaAtom.reportRead();
    return super.saveEtiqueta;
  }

  @override
  set saveEtiqueta(EtiquetaModel value) {
    _$saveEtiquetaAtom.reportWrite(value, super.saveEtiqueta, () {
      super.saveEtiqueta = value;
    });
  }

  final _$usersSaveAtom = Atom(name: '_ClientCreateStoreBase.usersSave');

  @override
  List<UserModel> get usersSave {
    _$usersSaveAtom.reportRead();
    return super.usersSave;
  }

  @override
  set usersSave(List<UserModel> value) {
    _$usersSaveAtom.reportWrite(value, super.usersSave, () {
      super.usersSave = value;
    });
  }

  final _$saveIdStaffAtom = Atom(name: '_ClientCreateStoreBase.saveIdStaff');

  @override
  List<dynamic> get saveIdStaff {
    _$saveIdStaffAtom.reportRead();
    return super.saveIdStaff;
  }

  @override
  set saveIdStaff(List<dynamic> value) {
    _$saveIdStaffAtom.reportWrite(value, super.saveIdStaff, () {
      super.saveIdStaff = value;
    });
  }

  final _$individualChipAtom =
      Atom(name: '_ClientCreateStoreBase.individualChip');

  @override
  List<dynamic> get individualChip {
    _$individualChipAtom.reportRead();
    return super.individualChip;
  }

  @override
  set individualChip(List<dynamic> value) {
    _$individualChipAtom.reportWrite(value, super.individualChip, () {
      super.individualChip = value;
    });
  }

  final _$tarefaTextSaveAtom =
      Atom(name: '_ClientCreateStoreBase.tarefaTextSave');

  @override
  String get tarefaTextSave {
    _$tarefaTextSaveAtom.reportRead();
    return super.tarefaTextSave;
  }

  @override
  set tarefaTextSave(String value) {
    _$tarefaTextSaveAtom.reportWrite(value, super.tarefaTextSave, () {
      super.tarefaTextSave = value;
    });
  }

  final _$tarefaDateSaveAtom =
      Atom(name: '_ClientCreateStoreBase.tarefaDateSave');

  @override
  DateTime get tarefaDateSave {
    _$tarefaDateSaveAtom.reportRead();
    return super.tarefaDateSave;
  }

  @override
  set tarefaDateSave(DateTime value) {
    _$tarefaDateSaveAtom.reportWrite(value, super.tarefaDateSave, () {
      super.tarefaDateSave = value;
    });
  }

  final _$prioridadeSaveSelectionAtom =
      Atom(name: '_ClientCreateStoreBase.prioridadeSaveSelection');

  @override
  int get prioridadeSaveSelection {
    _$prioridadeSaveSelectionAtom.reportRead();
    return super.prioridadeSaveSelection;
  }

  @override
  set prioridadeSaveSelection(int value) {
    _$prioridadeSaveSelectionAtom
        .reportWrite(value, super.prioridadeSaveSelection, () {
      super.prioridadeSaveSelection = value;
    });
  }

  final _$_ClientCreateStoreBaseActionController =
      ActionController(name: '_ClientCreateStoreBase');

  @override
  dynamic setTarefaModelSave(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setTarefaModelSave');
    try {
      return super.setTarefaModelSave(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSaveEtiqueta(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setSaveEtiqueta');
    try {
      return super.setSaveEtiqueta(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUsersSave(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setUsersSave');
    try {
      return super.setUsersSave(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanUsersSave() {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.cleanUsersSave');
    try {
      return super.cleanUsersSave();
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanSaveEtiqueta() {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.cleanSaveEtiqueta');
    try {
      return super.cleanSaveEtiqueta();
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanIndividualChip() {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.cleanIndividualChip');
    try {
      return super.cleanIndividualChip();
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTarefaTextSave(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setTarefaTextSave');
    try {
      return super.setTarefaTextSave(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanTarefaTextSave() {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.cleanTarefaTextSave');
    try {
      return super.cleanTarefaTextSave();
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTarefaDateSave(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setTarefaDateSave');
    try {
      return super.setTarefaDateSave(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPrioridadeSaveSelection(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setPrioridadeSaveSelection');
    try {
      return super.setPrioridadeSaveSelection(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanPrioridadeSaveSelection() {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.cleanPrioridadeSaveSelection');
    try {
      return super.cleanPrioridadeSaveSelection();
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanSave() {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.cleanSave');
    try {
      return super.cleanSave();
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIdStaff(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setIdStaff');
    try {
      return super.setIdStaff(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIdReferenceStaff(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setIdReferenceStaff');
    try {
      return super.setIdReferenceStaff(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
subtarefaInsertList: ${subtarefaInsertList},
tarefaModelSave: ${tarefaModelSave},
saveEtiqueta: ${saveEtiqueta},
usersSave: ${usersSave},
saveIdStaff: ${saveIdStaff},
individualChip: ${individualChip},
tarefaTextSave: ${tarefaTextSave},
tarefaDateSave: ${tarefaDateSave},
prioridadeSaveSelection: ${prioridadeSaveSelection}
    ''';
  }
}
