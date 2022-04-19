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

  final _$colorsDioAtom = Atom(name: '_EtiquetaStoreBase.colorsDio');

  @override
  List<dynamic> get colorsDio {
    _$colorsDioAtom.reportRead();
    return super.colorsDio;
  }

  @override
  set colorsDio(List<dynamic> value) {
    _$colorsDioAtom.reportWrite(value, super.colorsDio, () {
      super.colorsDio = value;
    });
  }

  final _$etiquetaDioAtom = Atom(name: '_EtiquetaStoreBase.etiquetaDio');

  @override
  List<EtiquetaDioModel> get etiquetaDio {
    _$etiquetaDioAtom.reportRead();
    return super.etiquetaDio;
  }

  @override
  set etiquetaDio(List<EtiquetaDioModel> value) {
    _$etiquetaDioAtom.reportWrite(value, super.etiquetaDio, () {
      super.etiquetaDio = value;
    });
  }

  final _$expansionTitleAtom = Atom(name: '_EtiquetaStoreBase.expansionTitle');

  @override
  bool get expansionTitle {
    _$expansionTitleAtom.reportRead();
    return super.expansionTitle;
  }

  @override
  set expansionTitle(bool value) {
    _$expansionTitleAtom.reportWrite(value, super.expansionTitle, () {
      super.expansionTitle = value;
    });
  }

  final _$themeAtom = Atom(name: '_EtiquetaStoreBase.theme');

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

  final _$idAtom = Atom(name: '_EtiquetaStoreBase.id');

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
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
  dynamic setColorsDio(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setColorsDio');
    try {
      return super.setColorsDio(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTheme(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setTheme');
    try {
      return super.setTheme(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setExpansionTitle(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setExpansionTitle');
    try {
      return super.setExpansionTitle(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEtiquetaDio(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setEtiquetaDio');
    try {
      return super.setEtiquetaDio(value);
    } finally {
      _$_EtiquetaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic setId(dynamic value) {
    final _$actionInfo = _$_EtiquetaStoreBaseActionController.startAction(
        name: '_EtiquetaStoreBase.setId');
    try {
      return super.setId(value);
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
colorsDio: ${colorsDio},
etiquetaDio: ${etiquetaDio},
expansionTitle: ${expansionTitle},
theme: ${theme},
etiqueta: ${etiqueta},
showValidation: ${showValidation},
icon: ${icon},
iconAction: ${iconAction},
loading: ${loading},
errOrGoal: ${errOrGoal},
msg: ${msg},
updateLoading: ${updateLoading},
id: ${id},
color: ${color},
isValidateEtiqueta: ${isValidateEtiqueta}
    ''';
  }
}
