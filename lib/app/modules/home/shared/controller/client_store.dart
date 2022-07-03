import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/app_widget.dart';
import 'package:munatasks2/app/modules/home/shared/model/notifications_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefas_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/fase_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/retard_dio_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/settings_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

import '../../../../shared/auth/model/user_dio_client.model.dart';

part 'client_store.g.dart';

class ClientStore = _ClientStoreBase with _$ClientStore;

abstract class _ClientStoreBase with Store {
  final ILocalStorage storage = Modular.get();
  buscaTheme(context) async {
    await storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        setTheme(true);
      } else {
        setTheme(false);
      }
      setThemeLoading(true);
    });

    AppWidget.of(context)
        ?.changeTheme(theme ? ThemeMode.dark : ThemeMode.light);
  }

  @observable
  List<int> badgetNavigate = [0, 0, 0];

  @action
  setBadgetNavigate(value) => badgetNavigate = value;

  @observable
  String cardSelection = '';

  @observable
  SettingsModel settings = SettingsModel();

  @action
  setSettings(value) => settings = value;

  @observable
  List<String> subtarefaActionList = ['pause', 'play', 'check'];

  @observable
  List<dynamic> tarefasTotais = [];

  @observable
  bool open = false;

  @action
  setOpen(value) => open = value;

  @observable
  int etiquetaSelection = 57585;

  @observable
  PerfilDioModel? userSelection;

  @observable
  String orderSelection = 'DATA';

  @action
  setOrderSelection(value) => orderSelection = value;

  @observable
  int prioridadeSelection = 0;

  @action
  setPrioridadeSelection(value) => prioridadeSelection = value;

  @observable
  String subtarefaAction = '';

  @action
  setSubtarefaAction(value) => subtarefaAction = value;

  @observable
  int retardSelection = 0;

  @action
  setRetardSelection(value) => retardSelection = value;

  @action
  setEtiquetaSelection(value) => etiquetaSelection = value;

  @action
  setUserSelection(value) => userSelection = value;

  @observable
  bool orderAscDesc = true;

  @action
  setOrderAscDesc(value) => orderAscDesc = value;

  @observable
  bool loading = true;

  @observable
  bool loadingTasks = false;

  @observable
  bool loadingTasksTotal = true;

  @action
  setLoading(value) => loading = value;

  @observable
  bool theme = false;

  @observable
  bool themeLoading = false;

  @action
  setThemeLoading(value) => themeLoading = value;

  @action
  setTheme(value) => theme = value;

  @observable
  int navigateBarSelection = 0;

  @action
  setNavigateBarSelection(value) => navigateBarSelection = value;

  @action
  setColor(value) => color = value;

  @action
  setIcon(value) => icon = value;

  @observable
  String color = '';

  @observable
  int icon = 0;

  @observable
  List<SubtarefasDioModel> subtarefaModel = [];

  @action
  cleanSubtarefaModel() => subtarefaModel = [];

  @action
  setSubtarefaModel(value) => subtarefaModel.add(value);

  @observable
  String imgUrl = DioStruture().baseUrlMunatasks + 'files/todos.png';

  @action
  setImgUrl(value) => imgUrl = value;

  @observable
  String searchValue = '';

  @action
  setSearchValue(value) => searchValue = value;

  @observable
  PerfilDioModel perfilUserLogado = PerfilDioModel();

  @action
  setPerfilUserlogado(value) => perfilUserLogado = value;

  @observable
  bool expandTarefa = false;

  @action
  setExpandTarefa(value) => expandTarefa = value;

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

  @action
  cleanTarefasTotais() => tarefasTotais = [];

  @action
  setTarefasTotais(value) => tarefasTotais = value;

  @observable
  List<TarefaDioModel> taskDio = [];

  @action
  setTaskDio(value) => taskDio = value;

  @observable
  List<TarefaDioModel> taskDioSearch = [];

  @action
  setTaskDioSearch(value) => taskDioSearch = value;

  @action
  cleanTaskDioSearch() => taskDioSearch = [];

  @observable
  UserDioClientModel userDio = UserDioClientModel();

  @action
  setUserDio(value) => userDio = value;

  @observable
  List<PerfilDioModel> perfis = [];

  @action
  setPerfis(value) => perfis = value;

  @observable
  List<EtiquetaDioModel> etiquetas = [];

  @observable
  List<NotificationsDioModel> notifications = [];

  @action
  setNotifications(value) => notifications = value;

  @action
  setEtiquetas(value) => etiquetas = value;

  @observable
  bool loadingNotifications = false;

  @action
  setLoadingNotifications(value) => loadingNotifications = value;

  @observable
  List<RetardDioModel> retard = [];

  @action
  setRetard(value) => retard = value;

  @observable
  List<FaseDioModel> fase = [];

  @action
  setFase(value) => fase = value;

  @observable
  dynamic dateInicial = '';

  @observable
  dynamic dateFinal = '';

  @action
  setDateInicial(value) => dateInicial = value;

  @action
  setDateFinal(value) => dateFinal = value;

  @observable
  bool filterDate = false;

  @action
  setFilterDate(value) => filterDate = value;

  @observable
  SettingsUserModel settingsUser = SettingsUserModel();

  @action
  setSettingsUser(value) => settingsUser = value;

  @observable
  String version = '';

  @action
  setVersion(value) => version = value;

  @observable
  bool loadingRefresh = false;

  @action
  setLoadingRefresh(value) => loadingRefresh = value;

  @observable
  bool checkUpdateDesktop = false;

  @action
  setCheckUpdateDesktop(value) => checkUpdateDesktop = value;

  @observable
  String versionBd = '';

  @action
  setVersionBd(value) => versionBd = value;

  @observable
  bool closeSearch = false;

  @action
  setCloseSearch(value) => closeSearch = value;
}
