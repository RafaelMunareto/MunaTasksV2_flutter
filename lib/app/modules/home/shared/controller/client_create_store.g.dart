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

  final _$faseListAtom = Atom(name: '_ClientCreateStoreBase.faseList');

  @override
  ObservableStream<List<FaseModel>>? get faseList {
    _$faseListAtom.reportRead();
    return super.faseList;
  }

  @override
  set faseList(ObservableStream<List<FaseModel>>? value) {
    _$faseListAtom.reportWrite(value, super.faseList, () {
      super.faseList = value;
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

  final _$subtarefaModelAtom =
      Atom(name: '_ClientCreateStoreBase.subtarefaModel');

  @override
  SubtarefaModel get subtarefaModel {
    _$subtarefaModelAtom.reportRead();
    return super.subtarefaModel;
  }

  @override
  set subtarefaModel(SubtarefaModel value) {
    _$subtarefaModelAtom.reportWrite(value, super.subtarefaModel, () {
      super.subtarefaModel = value;
    });
  }

  final _$usersAtom = Atom(name: '_ClientCreateStoreBase.users');

  @override
  List<UserModel> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<UserModel> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$tarefaModelSaveEtiquetaAtom =
      Atom(name: '_ClientCreateStoreBase.tarefaModelSaveEtiqueta');

  @override
  EtiquetaModel get tarefaModelSaveEtiqueta {
    _$tarefaModelSaveEtiquetaAtom.reportRead();
    return super.tarefaModelSaveEtiqueta;
  }

  @override
  set tarefaModelSaveEtiqueta(EtiquetaModel value) {
    _$tarefaModelSaveEtiquetaAtom
        .reportWrite(value, super.tarefaModelSaveEtiqueta, () {
      super.tarefaModelSaveEtiqueta = value;
    });
  }

  final _$tarefaModelSaveTextoAtom =
      Atom(name: '_ClientCreateStoreBase.tarefaModelSaveTexto');

  @override
  String get tarefaModelSaveTexto {
    _$tarefaModelSaveTextoAtom.reportRead();
    return super.tarefaModelSaveTexto;
  }

  @override
  set tarefaModelSaveTexto(String value) {
    _$tarefaModelSaveTextoAtom.reportWrite(value, super.tarefaModelSaveTexto,
        () {
      super.tarefaModelSaveTexto = value;
    });
  }

  final _$tarefaModelDataAtom =
      Atom(name: '_ClientCreateStoreBase.tarefaModelData');

  @override
  dynamic get tarefaModelData {
    _$tarefaModelDataAtom.reportRead();
    return super.tarefaModelData;
  }

  @override
  set tarefaModelData(dynamic value) {
    _$tarefaModelDataAtom.reportWrite(value, super.tarefaModelData, () {
      super.tarefaModelData = value;
    });
  }

  final _$tarefaModelPrioritarioAtom =
      Atom(name: '_ClientCreateStoreBase.tarefaModelPrioritario');

  @override
  int get tarefaModelPrioritario {
    _$tarefaModelPrioritarioAtom.reportRead();
    return super.tarefaModelPrioritario;
  }

  @override
  set tarefaModelPrioritario(int value) {
    _$tarefaModelPrioritarioAtom
        .reportWrite(value, super.tarefaModelPrioritario, () {
      super.tarefaModelPrioritario = value;
    });
  }

  final _$subtarefaModelSaveTitleAtom =
      Atom(name: '_ClientCreateStoreBase.subtarefaModelSaveTitle');

  @override
  String get subtarefaModelSaveTitle {
    _$subtarefaModelSaveTitleAtom.reportRead();
    return super.subtarefaModelSaveTitle;
  }

  @override
  set subtarefaModelSaveTitle(String value) {
    _$subtarefaModelSaveTitleAtom
        .reportWrite(value, super.subtarefaModelSaveTitle, () {
      super.subtarefaModelSaveTitle = value;
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

  final _$faseAtom = Atom(name: '_ClientCreateStoreBase.fase');

  @override
  String get fase {
    _$faseAtom.reportRead();
    return super.fase;
  }

  @override
  set fase(String value) {
    _$faseAtom.reportWrite(value, super.fase, () {
      super.fase = value;
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
  dynamic setSubtarefaInsertCreate(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setSubtarefaInsertCreate');
    try {
      return super.setSubtarefaInsertCreate(value);
    } finally {
      _$_ClientCreateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFase(dynamic value) {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.setFase');
    try {
      return super.setFase(value);
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
  dynamic cleanSubtarefaInsertCreate() {
    final _$actionInfo = _$_ClientCreateStoreBaseActionController.startAction(
        name: '_ClientCreateStoreBase.cleanSubtarefaInsertCreate');
    try {
      return super.cleanSubtarefaInsertCreate();
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
faseList: ${faseList},
tarefaModelSave: ${tarefaModelSave},
subtarefaModel: ${subtarefaModel},
users: ${users},
tarefaModelSaveEtiqueta: ${tarefaModelSaveEtiqueta},
tarefaModelSaveTexto: ${tarefaModelSaveTexto},
tarefaModelData: ${tarefaModelData},
tarefaModelPrioritario: ${tarefaModelPrioritario},
subtarefaModelSaveTitle: ${subtarefaModelSaveTitle},
individualChip: ${individualChip},
fase: ${fase}
    ''';
  }
}
