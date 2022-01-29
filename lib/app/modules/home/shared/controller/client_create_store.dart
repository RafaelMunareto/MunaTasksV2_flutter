import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

part 'client_create_store.g.dart';

class ClientCreateStore = _ClientCreateStoreBase with _$ClientCreateStore;

abstract class _ClientCreateStoreBase with Store {
  @observable
  ObservableStream<List<SubtarefaInsertModel>>? subtarefaInsertList;

  @observable
  TarefaModel tarefaModelSave = TarefaModel();

  @action
  setTarefaModelSave(value) => tarefaModelSave = value;

  @observable
  EtiquetaModel saveEtiqueta = EtiquetaModel();

  @action
  setSaveEtiqueta(value) => saveEtiqueta = value;

  @observable
  List<UserModel> usersSave = [];

  @action
  setUsersSave(value) => usersSave.add(value);

  @observable
  List saveIdStaff = [];

  @observable
  List individualChip = [];

  @action
  cleanUsersSave() => saveIdStaff = [];

  @action
  cleanSaveEtiqueta() => saveEtiqueta = EtiquetaModel();

  @action
  cleanIndividualChip() => individualChip = [];

  @observable
  String tarefaTextSave = "";

  @action
  setTarefaTextSave(value) => tarefaTextSave = value;

  @action
  cleanTarefaTextSave() => tarefaTextSave = '';

  @observable
  DateTime tarefaDateSave = DateTime.now();

  @action
  setTarefaDateSave(value) => tarefaDateSave = value;

  @observable
  int prioridadeSaveSelection = 0;

  @action
  setPrioridadeSaveSelection(value) => prioridadeSaveSelection = value;

  @action
  cleanPrioridadeSaveSelection() => prioridadeSaveSelection = 0;

  @action
  cleanSave() {
    cleanUsersSave();
    cleanSaveEtiqueta();
    cleanIndividualChip();
    cleanTarefaTextSave();
    cleanPrioridadeSaveSelection();
  }

  @action
  setIdStaff(value) {
    if (!saveIdStaff.map((e) => e.reference).contains(value.reference)) {
      saveIdStaff.add(value);
    } else {
      saveIdStaff.removeWhere((e) => e.reference == value.reference);
      if (saveIdStaff.isEmpty) {
        saveIdStaff = [];
      }
    }
  }

  @action
  setIdReferenceStaff(value) {
    if (!individualChip.map((e) => e).contains(value)) {
      individualChip.add(value);
    } else {
      individualChip.remove(value);
      if (individualChip.isEmpty) {
        individualChip = [];
      }
    }
  }
}
