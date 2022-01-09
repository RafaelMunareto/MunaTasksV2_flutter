// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etiquetas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EtiquetasStore on _EtiquetasStoreBase, Store {
  Computed<bool>? _$isValidateEtiquetaComputed;

  @override
  bool get isValidateEtiqueta => (_$isValidateEtiquetaComputed ??=
          Computed<bool>(() => super.isValidateEtiqueta,
              name: '_EtiquetasStoreBase.isValidateEtiqueta'))
      .value;

  final _$colorsListAtom = Atom(name: '_EtiquetasStoreBase.colorsList');

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

  final _$etiquetaAtom = Atom(name: '_EtiquetasStoreBase.etiqueta');

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

  final _$iconAtom = Atom(name: '_EtiquetasStoreBase.icon');

  @override
  dynamic get icon {
    _$iconAtom.reportRead();
    return super.icon;
  }

  @override
  set icon(dynamic value) {
    _$iconAtom.reportWrite(value, super.icon, () {
      super.icon = value;
    });
  }

  final _$iconActionAtom = Atom(name: '_EtiquetasStoreBase.iconAction');

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

  final _$colorActionAtom = Atom(name: '_EtiquetasStoreBase.colorAction');

  @override
  bool get colorAction {
    _$colorActionAtom.reportRead();
    return super.colorAction;
  }

  @override
  set colorAction(bool value) {
    _$colorActionAtom.reportWrite(value, super.colorAction, () {
      super.colorAction = value;
    });
  }

  final _$colorAtom = Atom(name: '_EtiquetasStoreBase.color');

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

  final _$loadingAtom = Atom(name: '_EtiquetasStoreBase.loading');

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

  final _$errOrGoalAtom = Atom(name: '_EtiquetasStoreBase.errOrGoal');

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

  final _$msgAtom = Atom(name: '_EtiquetasStoreBase.msg');

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

  final _$iconDataAtom = Atom(name: '_EtiquetasStoreBase.iconData');

  @override
  List<IconData> get iconData {
    _$iconDataAtom.reportRead();
    return super.iconData;
  }

  @override
  set iconData(List<IconData> value) {
    _$iconDataAtom.reportWrite(value, super.iconData, () {
      super.iconData = value;
    });
  }

  final _$_EtiquetasStoreBaseActionController =
      ActionController(name: '_EtiquetasStoreBase');

  @override
  dynamic changeEtiqueta(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.changeEtiqueta');
    try {
      return super.changeEtiqueta(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIcon(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setIcon');
    try {
      return super.setIcon(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIconAction(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setIconAction');
    try {
      return super.setIconAction(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setColorAction(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setColorAction');
    try {
      return super.setColorAction(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrOrGoal(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setErrOrGoal');
    try {
      return super.setErrOrGoal(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMsg(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setColor(dynamic value) {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setColor');
    try {
      return super.setColor(value);
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getColors() {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.getColors');
    try {
      return super.getColors();
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic submit() {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.submit');
    try {
      return super.submit();
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCleanVariables() {
    final _$actionInfo = _$_EtiquetasStoreBaseActionController.startAction(
        name: '_EtiquetasStoreBase.setCleanVariables');
    try {
      return super.setCleanVariables();
    } finally {
      _$_EtiquetasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
colorsList: ${colorsList},
etiqueta: ${etiqueta},
icon: ${icon},
iconAction: ${iconAction},
colorAction: ${colorAction},
color: ${color},
loading: ${loading},
errOrGoal: ${errOrGoal},
msg: ${msg},
iconData: ${iconData},
isValidateEtiqueta: ${isValidateEtiqueta}
    ''';
  }
}
