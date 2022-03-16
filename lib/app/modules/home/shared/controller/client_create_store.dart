import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/fase_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_insert_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
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
  String faseTarefa = 'pause';

  @observable
  String imageUser = '';

  @observable
  UserModel createUser = UserModel();

  @observable
  String subtarefaTextSave = '';

  @observable
  List<SubtarefaModel> subtarefas = [];

  @action
  setSubtarefasUpdate(value) => subtarefas = value;

  @observable
  bool loadingSubtarefa = false;

  @observable
  bool loadingUser = false;

  @observable
  bool loadingTarefa = false;

  @observable
  dynamic reference;

  @action
  setReference(value) => reference = value;

  @action
  cleanImageUser() => imageUser = "";

  @action
  cleanSubaterafaText() => subtarefaTextSave = "";

  @action
  setLoadingSubtarefa(value) => loadingSubtarefa = value;

  @action
  setLoadingUser(value) => loadingUser = value;

  @action
  setLoadingTarefa(value) => loadingTarefa = value;

  @action
  setTarefaModelSave(value) => tarefaModelSave = value;

  @action
  setUsersSave(value) => users.add(value);

  @action
  setUsersUpdate(value) => users = value;

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
  setFaseTarefa(value) => faseTarefa = value;

  @action
  cleanTarefaTextSave() => tarefaModelSaveTexto = '';

  @action
  cleanSubtarefaInsertCreate() => subtarefaModelSaveTitle = '';

  @action
  cleanPrioridadeSaveSelection() => tarefaModelPrioritario = 0;

  @action
  cleanTarefaModelSave() => tarefaModelSave = TarefaModel();

  @action
  cleanUsersSave() => users = [];

  @action
  cleanSubtarefas() => subtarefas = [];

  @action
  cleanSaveEtiqueta() => tarefaModelSave.etiqueta = EtiquetaModel();

  @action
  cleanIndividualChip() => individualChip = [];

  @action
  cleanCreateUser() => createUser = UserModel();

  @action
  cleanFase() => fase = 'pause';

  @action
  cleanTarefaModelData() => tarefaModelData = '';

  @action
  cleanFaseTarefa() => faseTarefa = 'pause';

  @action
  cleanReference() => reference = null;

  @action
  cleanTarefaModelSaveEtiqueta() => tarefaModelSaveEtiqueta = EtiquetaModel();

  @action
  cleanSave() {
    cleanUsersSave();
    cleanSaveEtiqueta();
    cleanIndividualChip();
    cleanTarefaTextSave();
    cleanPrioridadeSaveSelection();
    cleanFaseTarefa();
    cleanSubtarefas();
    cleanSubtarefa();
    cleanTarefaModelSave();
    cleanTarefaModelData();
    cleanReference();
    cleanTarefaModelSaveEtiqueta();
  }

  @action
  cleanSubtarefa() {
    cleanSubaterafaText();
    cleanImageUser();
    cleanSubtarefaInsertCreate();
    cleanFase();
    cleanCreateUser();
  }

  @action
  setIdStaff(value) {
    if (!users.map((e) => e.email).contains(value.email)) {
      users.add(value);
    } else {
      users.removeWhere((e) => e.email == value.email);
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
    createUser = value;
  }

  @action
  setTarefa() {
    tarefaModelSave.etiqueta = tarefaModelSaveEtiqueta;
    tarefaModelSave.reference = reference;
    tarefaModelSave.texto = tarefaModelSaveTexto;
    tarefaModelSave.fase = changeFaseTarefa(faseTarefa);
    tarefaModelSave.data = tarefaModelData;
    tarefaModelSave.subTarefa = subtarefas;
    tarefaModelSave.users = users.map((e) => e).toList();
    tarefaModelSave.prioridade = tarefaModelPrioritario;
  }

  @action
  setTarefaUpdate(TarefaDioModel tarefa) {
    setSaveEtiqueta(tarefa.etiqueta);
    setTarefaTextSave(tarefa.texto);
    setFaseTarefa(changeFaseTarefaReverse(tarefa.fase));
    setSubtarefasUpdate(tarefa.subTarefa);
    setTarefaDateSave(tarefa.data);
    setUsersUpdate(tarefa.users);
    setPrioridadeSaveSelection(tarefa.prioridade);
    setReference(tarefa.id);
  }

  changeFaseTarefa(faseTarefa) {
    switch (faseTarefa) {
      case 'pause':
        return 0;
      case 'play':
        return 1;
      case 'check':
        return 2;
    }
  }

  changeFaseTarefaReverse(faseTarefa) {
    switch (faseTarefa) {
      case 0:
        return 'pause';
      case 1:
        return 'play';
      case 2:
        return 'check';
    }
  }

  @action
  removeDismissSubtarefa(model) {
    setLoadingSubtarefa(true);
    setLoadingUser(true);
    if (subtarefas.map((e) => e.user.email == model.user.email).length > 2) {
      users.removeWhere((e) => e.email == model.user.email);
    } else if (subtarefas.map((e) => e.user.email == model.user.email).length ==
        1) {
      users.removeWhere((e) => e.email == model.user.email);
    }

    subtarefas.removeWhere(
      (e) =>
          e.texto == model.texto &&
          e.title == model.title &&
          e.user.name == model.user.name,
    );
    setLoadingSubtarefa(false);
    setLoadingUser(false);
  }

  @action
  setSubtarefas() {
    setLoadingSubtarefa(true);
    subtarefaModel.title = subtarefaModelSaveTitle;
    subtarefaModel.status = fase;
    subtarefaModel.user = createUser;
    subtarefaModel.texto = subtarefaTextSave;
    users.where((e) => e.email == createUser.email).length;
    // ignore: prefer_is_empty
    if (users.where((e) => e.email == createUser.email).length < 1) {
      setLoadingUser(true);
      users.add(createUser);
      setIdReferenceStaff(createUser.email);
    } else if (users.where((e) => e.email == createUser.email).length > 1) {
      users.removeWhere((e) => e.email == createUser.email);
      if (users.isEmpty) {
        users = [];
      }
    }
    subtarefas.add(subtarefaModel);
    subtarefaModel = SubtarefaModel();
    setLoadingSubtarefa(false);
    setLoadingUser(false);
    cleanSubtarefa();
  }

  @computed
  bool get isValidTarefa {
    return validTextoTarefa() == null &&
        validTitleTarefa() == null &&
        validaUserTarefa() == null &&
        validaDataTarefa() == null;
  }

  String? validTextoTarefa() {
    if (tarefaModelSaveTexto.length < 3) {
      return 'Descrição deve ser > 3 caracteres.';
    }
    return null;
  }

  String? validTitleTarefa() {
    if (tarefaModelSaveEtiqueta.etiqueta.isEmpty ||
        tarefaModelSaveEtiqueta.etiqueta == "Etiqueta") {
      return 'Etiqueta obrigatório.';
    }
    return null;
  }

  String? validaUserTarefa() {
    if (users.isEmpty) {
      return 'Responsável obrigatório.';
    }
    return null;
  }

  String? validaDataTarefa() {
    if (tarefaModelData == '') {
      return 'Data obrigatória.';
    }
    return null;
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
    if (createUser.email == '') {
      return 'Responsável obrigatório.';
    }
    return null;
  }
}
