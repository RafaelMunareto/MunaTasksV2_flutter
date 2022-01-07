// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etiquetas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EtiquetasStore on _EtiquetasStoreBase, Store {
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

  final _$_EtiquetasStoreBaseActionController =
      ActionController(name: '_EtiquetasStoreBase');

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
  String toString() {
    return '''
colorsList: ${colorsList},
etiqueta: ${etiqueta},
color: ${color}
    ''';
  }
}
