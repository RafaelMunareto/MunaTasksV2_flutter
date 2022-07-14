import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_qtd_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

import '../../../settings/etiquetas/shared/models/etiqueta_dio_model.dart';

part 'client_create_store.g.dart';

class ClientCreateStore = _ClientCreateStoreBase with _$ClientCreateStore;

abstract class _ClientCreateStoreBase with Store {
  @observable
  dynamic tarefaModelSave = TarefaDioModel();

  @observable
  List<dynamic> users = [];

  @observable
  EtiquetaDioModel tarefaModelSaveEtiqueta = EtiquetaDioModel();

  @observable
  String tarefaModelSaveTexto = '';

  @observable
  dynamic tarefaModelData = '';

  @observable
  int tarefaModelPrioritario = 4;

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
  dynamic createUser = PerfilDioModel();

  @observable
  String subtarefaTextSave = '';

  @observable
  List<dynamic> subtarefas = [];

  @observable
  List<dynamic> subtarefasFilter = [];

  @action
  setSubtarefasFilter(value) => subtarefasFilter = value;

  @action
  setSubtarefasUpdate(value) => subtarefas = value;

  @observable
  bool loadingSubtarefa = false;

  @observable
  bool loadingUser = false;

  @observable
  bool loadingTarefa = false;

  @observable
  String id = '';

  @action
  setReference(value) => tarefaModelSave.id = value;

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
  cleanPrioridadeSaveSelection() => tarefaModelPrioritario = 4;

  @action
  cleanTarefaModelSave() => tarefaModelSave = TarefaDioModel();

  @action
  cleanUsersSave() => users = [];

  @action
  cleanSubtarefas() => subtarefas = [];

  @action
  cleanSaveEtiqueta() => tarefaModelSave.etiqueta = EtiquetaDioModel();

  @action
  cleanIndividualChip() => individualChip = [];

  @action
  cleanCreateUser() => createUser = PerfilDioModel();

  @action
  cleanFase() => fase = 'pause';

  @action
  cleanTarefaModelData() => tarefaModelData = '';

  @action
  cleanFaseTarefa() => faseTarefa = 'pause';

  @action
  cleanReference() => tarefaModelSave.id = '';

  @action
  cleanTarefaId() => tarefaId = '';

  @action
  cleanTarefaModelSaveEtiqueta() =>
      tarefaModelSaveEtiqueta = EtiquetaDioModel();

  @action
  setIndividualChip(value) => individualChip = value;

  @action
  cleanSave() {
    cleanUsersSave();
    cleanTarefaId();
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
    cleanSubtarefaId();
  }

  @action
  setIdReferenceStaff(value) {
    if (individualChip.where((e) => e.id == value.id).isEmpty) {
      individualChip.add(value);
    } else {
      individualChip.removeWhere((a) => a.id == value.id);
    }
  }

  @action
  setSubtarefaTextSave(value) => subtarefaTextSave = value;

  // @action
  // setCreateImageUser(value) {
  //   if (users.map((e) => e.id).contains(createUser.id)) {
  //     users.removeWhere((e) => e.id == createUser.id);
  //   }

  //   imageUser = value;
  // }

  @action
  setUserCreateSelection(value) {
    createUser = value;
  }

  @action
  setTarefa() async {
    tarefaModelSave.etiqueta = tarefaModelSaveEtiqueta;
    tarefaModelSave.texto = tarefaModelSaveTexto;
    tarefaModelSave.fase = changeFaseTarefa(faseTarefa);
    tarefaModelSave.data = tarefaModelData;
    tarefaModelSave.subTarefa = subtarefas;
    if (createUser.id != "") {
      if (tarefaModelSave.subtarefas
          .where((a) => a.user.id == createUser.id)
          .isEmpty) {
        users.removeWhere((element) => element.id == createUser.id);
      }
      if (users.where((a) => a.id == createUser.id).isEmpty) {
        users.add(createUser);
      }
    }
    tarefaModelSave.users = users.map((e) => e).toList();
    tarefaModelSave.prioridade = tarefaModelPrioritario;
    cleanSubtarefa();
  }

  @observable
  dynamic tarefaId;

  @action
  setTarefaId(value) => tarefaId = value;

  @action
  setSubtarefaId(value) => subtarefaModel.id = value;

  @action
  cleanSubtarefaId() => subtarefaModel.id = '';

  @action
  setSubtarefaUpdate(dynamic model) {
    setSubtarefaTextSave(model.texto);
    setSubtarefaInsertCreate(model.title);
    setFase(model.status);
    setUserCreateSelection(model.user);
    setIdReferenceStaff(
      model.user,
    );
    setSubtarefaId(model.id);
  }

  @action
  setTarefaUpdate(TarefaDioModel tarefa) {
    setTarefaId(tarefa.id);
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
    if (subtarefas.map((e) => e.user.email == model.user.name.email).length >
        2) {
      users.removeWhere((e) => e.name.email == model.user.name.email);
    } else if (subtarefas
            .map((e) => e.user.email == model.user.name.email)
            .length ==
        1) {
      users.removeWhere((e) => e.name.email == model.user.name.email);
    }

    subtarefas.removeWhere(
      (e) =>
          e.texto == model.texto &&
          e.title == model.title &&
          e.user.name == model.user.name,
    );

    // if (subtarefasFilter
    //         .map((e) => e.user.email == model.user.name.email)
    //         .length >
    //     2) {
    //   users.removeWhere((e) => e.name.email == model.user.name.email);
    // } else if (subtarefasFilter
    //         .map((e) => e.user.email == model.user.name.email)
    //         .length ==
    //     1) {
    //   users.removeWhere((e) => e.name.email == model.user.name.email);
    // }

    // subtarefasFilter.removeWhere(
    //   (e) =>
    //       e.texto == model.texto &&
    //       e.title == model.title &&
    //       e.user.name == model.user.name,
    // );
    setLoadingSubtarefa(false);
    setLoadingUser(false);
    subtarefasVsPerfil();
  }

  @observable
  SubtarefasDioModel subtarefaModel = SubtarefasDioModel();

  @observable
  bool editar = false;

  @action
  setEditar(value) => editar = value;

  @action
  setSubtarefas() {
    setLoadingSubtarefa(true);
    subtarefaModel.title = subtarefaModelSaveTitle;
    subtarefaModel.status = fase;
    subtarefaModel.user = createUser;
    subtarefaModel.texto = subtarefaTextSave;

    if (subtarefas.where((e) => e.id == subtarefaModel.id).isNotEmpty) {
      subtarefas = subtarefas.map((e) {
        if (e.id == subtarefaModel.id) {
          return subtarefaModel;
        }
        return e;
      }).toList();
    } else {
      subtarefas.add(subtarefaModel);
    }

    subtarefaModel = SubtarefasDioModel();
    setLoadingSubtarefa(false);
    setLoadingUser(false);
    setEditar(false);
  }

  @action
  setSubtarefasSearch(value) => subtarefas = value;

  @computed
  bool get isValidTarefa {
    return validTitleTarefa() == null &&
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
    return validTitleSubtarefa() == null && validaUserSubtarefa() == null;
  }

  String? validTextoSubtarefa() {
    if (tarefaModelSaveTexto.length < 3) {
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
    if (createUser.id == '') {
      return 'Responsável obrigatório.';
    }
    return null;
  }

  @observable
  bool loadingSearch = false;

  @action
  setLoadingSearch(value) => loadingSearch = value;

  @observable
  bool subtarefaAction = false;

  @action
  setSubtarefaAction(value) => subtarefaAction = value;

  @observable
  bool editarSubtarefa = false;

  @observable
  List<SubtarefasQtdModel> totais = [];

  @action
  setEditarSubtarefa(value) => editarSubtarefa = value;

  @action
  cleanSubtarefasFilter() => subtarefasFilter = [];

  @action
  subtarefasVsPerfil() async {
    totais = [];
    await cleanSubtarefasFilter();
    await setSubtarefasFilter(subtarefas);
    totais.add(SubtarefasQtdModel.fromDocument({
      "name": 'TODOS',
      "urlImage": DioStruture().baseUrlMunatasks + 'files/todos.png',
      "qtdSubtarefa": subtarefas.length
    }));
    for (var e in subtarefasFilter) {
      if (totais.where((element) => element.name == e.user.name.name).isEmpty) {
        totais.add(SubtarefasQtdModel.fromDocument({
          "name": e.user.name.name,
          "urlImage": e.user.urlImage,
          "qtdSubtarefa": calculaQtdSubtarefa(e.user.id)
        }));
      }
    }
  }

  @action
  totaisDelete(value) {
    totais.map((e) {
      if (e.name == value.name.name) {
        return e.qtdSubtarefa - 1;
      }
      return e;
    });
  }

  @action
  subtarefasVsPerfilUpdate() async {
    totais = [];
    for (var e in subtarefas) {
      if (totais.where((element) => element.name == e.user.name.name).isEmpty) {
        totais.add(SubtarefasQtdModel.fromDocument({
          "name": e.user.name.name,
          "urlImage": e.user.urlImage,
          "qtdSubtarefa": calculaQtdSubtarefa(e.user.id)
        }));
      }
    }
  }

  calculaQtdSubtarefa(String id) {
    return subtarefas.where((element) => element.user.id == id).length;
  }
}
