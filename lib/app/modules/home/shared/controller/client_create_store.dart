import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

part 'client_create_store.g.dart';

class ClientCreateStore = _ClientCreateStoreBase with _$ClientCreateStore;

abstract class _ClientCreateStoreBase with Store {
  @observable
  ObservableStream<List<SubtarefaInsertModel>>? subtarefaInsertList;

  @observable
  ObservableStream<List<FaseModel>>? faseList;

  @observable
  TarefaModel tarefaModelSave = TarefaModel();

  @observable
  SubtarefaModel subtarefaModel = SubtarefaModel();

  @observable
  List<UserModel> users = [];

  @observable
  EtiquetaModel tarefaModelSaveEtiqueta = EtiquetaModel();

  @observable
  String tarefaModelSaveTexto = '';

  @observable
  dynamic tarefaModelData = '';

  @observable
  int tarefaModelPrioritario = 0;

  @observable
  String subtarefaModelSaveTitle = '';

  @observable
  List individualChip = [];

  @observable
  String fase = 'pause';

  @observable
  String imageUser = '';

  @observable
  UserModel createUser = UserModel();

  @observable
  String subtarefaTextSave = '';

  @observable
  List<SubtarefaModel> subtarefas = [];

  @observable
  bool loading = false;

  @action
  setLoading(value) => loading = value;

  @action
  setTarefaModelSave(value) => tarefaModelSave = value;

  @action
  setUsersSave(value) => users.add(value);

  @action
  setSaveEtiqueta(value) => tarefaModelSaveEtiqueta = value;

  @action
  setTarefaDateSave(value) => tarefaModelData = value;

  @action
  setPrioridadeSaveSelection(value) => tarefaModelPrioritario = value;

  @action
  setTarefaTextSave(value) => tarefaModelSaveTexto = value;

  @action
  setSubtarefaInsertCreate(value) => subtarefaModelSaveTitle = value;

  @action
  setFase(value) => fase = value;

  @action
  cleanTarefaTextSave() => tarefaModelSaveTexto = '';

  @action
  cleanSubtarefaInsertCreate() => subtarefaModelSaveTitle = '';

  @action
  cleanPrioridadeSaveSelection() => tarefaModelPrioritario = 0;

  @action
  cleanUsersSave() => users = [];

  @action
  cleanSaveEtiqueta() => tarefaModelSave.etiqueta = EtiquetaModel();

  @action
  cleanIndividualChip() => individualChip = [];

  @action
  cleanSave() {
    cleanUsersSave();
    cleanSaveEtiqueta();
    cleanIndividualChip();
    cleanTarefaTextSave();
    cleanPrioridadeSaveSelection();
    cleanSubtarefaInsertCreate();
  }

  @action
  setIdStaff(value) {
    if (!users.map((e) => e.reference).contains(value.reference)) {
      users.add(value);
    } else {
      users.removeWhere((e) => e.reference == value.reference);
      if (users.isEmpty) {
        users = [];
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

  @action
  setSubtarefaTextSave(value) => subtarefaTextSave = value;

  @action
  setCreateImageUser(value) {
    if (users.map((e) => e.reference).contains(createUser.reference)) {
      users.removeWhere((e) => e.reference == createUser.reference);
    }

    imageUser = value;
  }

  @action
  setUserCreateSelection(value) {
    if (!users.map((e) => e.reference).contains(value.reference)) {
      createUser = value;
    } else {
      users.removeWhere((e) => e.reference == createUser.reference);
      if (users.isEmpty) {
        users = [];
      }
    }
  }

  @action
  setSubtarefas() {
    setLoading(true);
    subtarefaModel.title = subtarefaModelSaveTitle;
    subtarefaModel.status = fase;
    subtarefaModel.user = createUser;
    subtarefaModel.texto = subtarefaTextSave;
    if (!users.map((e) => e.reference).contains(createUser.reference)) {
      users.add(createUser);
    } else {
      users.removeWhere((e) => e.reference == createUser.reference);
      if (users.isEmpty) {
        users = [];
      }
    }
    subtarefas.add(subtarefaModel);
    subtarefaModel = SubtarefaModel();
    setLoading(false);
  }

  @computed
  bool get isValidSubtarefa {
    return validTextoSubtarefa() == null &&
        validTitleSubtarefa() == null &&
        validaUserSubtarefa() == null;
  }

  String? validTextoSubtarefa() {
    if (subtarefaTextSave.length < 3) {
      return 'Descrição deve ser > 3 caracteres.';
    }
    return null;
  }

  String? validTitleSubtarefa() {
    if (subtarefaModelSaveTitle.isEmpty ||
        subtarefaModelSaveTitle == 'Subtarefa') {
      return 'Escolha o tipo da tarefa.';
    }
    return null;
  }

  String? validaUserSubtarefa() {
    if (createUser.name == '') {
      return 'Responsável obrigatório.';
    }
    return null;
  }
}
