// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etiqueta_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EtiquetaStore on _EtiquetaStoreBase, Store {
  Computed<bool>? _$isValidateEtiquetaComputed;

  @override
  bool get isValidateEtiqueta => (_$isValidateEtiquetaComputed ??=
          Computed<bool>(() => super.isValidateEtiqueta,
              name: '_EtiquetaStoreBase.isValidateEtiqueta'))
      .value;

  final _$colorsListAtom = Atom(name: '_EtiquetaStoreBase.colorsList');

  @override
  ObservableStream<List<ColorsModel>>? get colorsList {
    _$colorsListAtom.reportRead();
    return super.colorsList;
  }

  @override
  set colorsList(ObservableStream<List<ColorsModel>>? value) {
    _$colorsListAtom.reportWrite(value, super.colorsList, () {
      super.colorsList = value;
    });
  }

  final _$etiquetaListAtom = Atom(name: '_EtiquetaStoreBase.etiquetaList');

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

  final _$etiquetaDioAtom = Atom(name: '_EtiquetaStoreBase.etiquetaDio');

  @override
  dynamic get etiquetaDio {
    _$etiquetaDioAtom.reportRead();
    return super.etiquetaDio;
  }

  @override
  set etiquetaDio(dynamic value) {
    _$etiquetaDioAtom.reportWrite(value, super.etiquetaDio, () {
      super.etiquetaDio = value;
    });
  }

  final _$etiquetaAtom = Atom(name: '_EtiquetaStoreBase.etiqueta');

  @override
  String get etiqueta {
    _$etiquetaAtom.reportRead();
    return super.etiqueta;
  }

  @override
  set etiqueta(String value) {
    _$etiquetaAtom.reportWrite(value, super.etiqueta, () {
      super.etiqueta = value;
    });
  }

  final _$showValidationAtom = Atom(name: '_EtiquetaStoreBase.showValidation');

  @override
  bool get showValidation {
    _$showValidationAtom.reportRead();
    return super.showValidation;
  }

  @override
  set showValidation(bool value) {
    _$showValidationAtom.reportWrite(value, super.showValidation, () {
      super.showValidation = value;
    });
  }

  final _$iconAtom = Atom(name: '_EtiquetaStoreBase.icon');

  @override
  int? get icon {
    _$iconAtom.reportRead();
    return super.icon;
  }

  @override
  set icon(int? value) {
    _$iconAtom.reportWrite(value, super.icon, () {
      super.icon = value;
    });
  }

  final _$iconActionAtom = Atom(name: '_EtiquetaStoreBase.iconAction');

  @override
  bool get iconAction {
    _$iconActionAtom.reportRead();
    return super.iconAction;
  }

  @override
  set iconAction(bool value) {
    _$iconActionAtom.reportWrite(value, super.iconAction, () {
      super.iconAction = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EtiquetaStoreBase.loading');

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

  final _$errOrGoalAtom = Atom(name: '_EtiquetaStoreBase.errOrGoal');

  @override
  bool get errOrGoal {
    _$errOrGoalAtom.reportRead();
    return super.errOrGoal;
  }

  @override
  set errOrGoal(bool value) {
    _$errOrGoalAtom.reportWrite(value, super.errOrGoal, () {
      super.errOrGoal = value;
    });
  }

  final _$msgAtom = Atom(name: '_EtiquetaStoreBase.msg');

  @override
  String get msg {
    _$msgAtom.reportRead();
    return super.msg;
  }

  @override
  set msg(String value) {
    _$msgAtom.reportWrite(value, super.msg, () {
      super.msg = value;
    });
  }

  final _$updateLoadingAtom = Atom(name: '_EtiquetaStoreBase.updateLoading');

  @override
  bool get updateLoading {
    _$updateLoadingAtom.reportRead();
    return super.updateLoading;
  }

  @override
  set updateLoading(bool value) {
    _$updateLoadingAtom.reportWrite(value, super.updateLoading, () {
      super.updateLoading = value;
    });
  }

  final _$referenceAtom = Atom(name: '_EtiquetaStoreBase.reference');

  @override
  DocumentReference<Object?>? get reference {
    _$referenceAtom.reportRead();
    return super.reference;
  }

  @override
  set reference(DocumentReference<Object?>? value) {
    _$referenceAtom.reportWrite(value, super.reference, () {
      super.reference = value;
    });
  }

  final _$colorAtom = Atom(name: '_EtiquetaStoreBase.color');

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

  final _$_EtiquetaStoreBaseActionController =
      ActionController(name: '_EtiquetaStoreBase');

  @override
  dynamic setEtiqueta(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setEtiqueta');
    try {
      return super.setEtiqueta(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowValidation(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setShowValidation');
    try {
      return super.setShowValidation(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIcon(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setIcon');
    try {
      return super.setIcon(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIconAction(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setIconAction');
    try {
      return super.setIconAction(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrOrGoal(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setErrOrGoal');
    try {
      return super.setErrOrGoal(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsg(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUpdateLoading(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setUpdateLoading');
    try {
      return super.setUpdateLoading(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setReference(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setReference');
    try {
      return super.setReference(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setColor(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setColor');
    try {
      return super.setColor(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCleanVariables() {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setCleanVariables');
    try {
      return super.setCleanVariables();
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
colorsList: ${colorsList},
etiquetaList: ${etiquetaList},
etiquetaDio: ${etiquetaDio},
etiqueta: ${etiqueta},
showValidation: ${showValidation},
icon: ${icon},
iconAction: ${iconAction},
loading: ${loading},
errOrGoal: ${errOrGoal},
msg: ${msg},
updateLoading: ${updateLoading},
reference: ${reference},
color: ${color},
isValidateEtiqueta: ${isValidateEtiqueta}
    ''';
  }
}
