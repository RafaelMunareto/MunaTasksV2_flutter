// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_tarefas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientTarefasStore on _ClientTarefasStoreBase, Store {
  late final _$idSelectionAtom =
      Atom(name: '_ClientTarefasStoreBase.idSelection', context: context);

  @override
  String get idSelection {
    _$idSelectionAtom.reportRead();
    return super.idSelection;
  }

  @override
  set idSelection(String value) {
    _$idSelectionAtom.reportWrite(value, super.idSelection, () {
      super.idSelection = value;
    });
  }

  late final _$tasksDioAtom =
      Atom(name: '_ClientTarefasStoreBase.tasksDio', context: context);

  @override
  List<TarefaDioModel> get tasksDio {
    _$tasksDioAtom.reportRead();
    return super.tasksDio;
  }

  @override
  set tasksDio(List<TarefaDioModel> value) {
    _$tasksDioAtom.reportWrite(value, super.tasksDio, () {
      super.tasksDio = value;
    });
  }

  late final _$_ClientTarefasStoreBaseActionController =
      ActionController(name: '_ClientTarefasStoreBase', context: context);

  @override
  dynamic setIdSelection(dynamic value) {
    final _$actionInfo = _$_ClientTarefasStoreBaseActionController.startAction(
        name: '_ClientTarefasStoreBase.setIdSelection');
    try {
      return super.setIdSelection(value);
    } finally {
      _$_ClientTarefasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTaskDio(dynamic value) {
    final _$actionInfo = _$_ClientTarefasStoreBaseActionController.startAction(
        name: '_ClientTarefasStoreBase.setTaskDio');
    try {
      return super.setTaskDio(value);
    } finally {
      _$_ClientTarefasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
idSelection: ${idSelection},
tasksDio: ${tasksDio}
    ''';
  }
}
