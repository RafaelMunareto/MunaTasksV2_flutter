import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/prioridade_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/retard_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/subtarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_total_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_totais_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

import '../../../../shared/auth/model/user_dio_client.model.dart';

part 'client_store.g.dart';

class ClientStore = _ClientStoreBase with _$ClientStore;

abstract class _ClientStoreBase with Store {
  @observable
  List<int> badgetNavigate = [0, 0, 0];

  @action
  setBadgetNavigate(value) => badgetNavigate = value;

  @observable
  String cardSelection = '';

  @observable
  List<TarefaModel> tarefas = [];

  @observable
  ObservableStream<List<TarefaModel>>? dashboardList;

  @observable
  ObservableStream<List<EtiquetaModel>>? etiquetaList;

  @observable
  ObservableStream<List<UserModel>>? userList;

  @observable
  ObservableStream<List<OrderModel>>? orderList;

  @observable
  ObservableStream<List<RetardModel>>? retardList;

  @observable
  ObservableStream<List<PrioridadeModel>>? prioridadeList;

  @observable
  List<String> subtarefaActionList = ['pause', 'play', 'check'];

  @observable
  List<TarefaTotaisModel> tarefasTotais = [];

  @observable
  bool open = false;

  @action
  setOpen(value) => open = value;

  @observable
  int etiquetaSelection = 57585;

  @observable
  UserModel? userSelection;

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
  List<TarefaModel> tarefasBase = [];

  @observable
  bool loading = true;

  @observable
  bool theme = false;

  @action
  setLoading(value) => loading = value;

  @action
  setTarefa(value) => tarefasBase.add(value);

  @action
  setTarefasBase(value) => tarefasBase = value;

  @action
  deleteTarefasBase(value) => tarefasBase
      .removeWhere((element) => element.reference!.id == value.reference!.id);

  @action
  cleanTarefasBase() => tarefasBase = [];

  @action
  changeTarefa(value) => tarefas = value;

  @action
  cleanTarefas() => tarefas = [];

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
  List<UserModel> usersBase = [];

  @action
  cleanUsersBase() => usersBase = [];

  @action
  setUsersBase(value) => usersBase.add(value);

  @observable
  List<SubtareDiofaModel> subtarefaModel = [];

  @action
  cleanSubtarefaModel() => subtarefaModel = [];

  @action
  setSubtarefaModel(value) => subtarefaModel.add(value);

  @observable
  EtiquetaModel? etiquetasRelacionadas;

  @action
  setEtiquetasRelacionadas(value) => etiquetasRelacionadas = value;

  @observable
  UserModel? userSubtarefa;

  @action
  setUserSubtarefa(value) => userSubtarefa = value;

  @observable
  String imgUrl =
      'https://firebasestorage.googleapis.com/v0/b/munatasksv2.appspot.com/o/allPeople.png?alt=media&token=19a38226-7467-4f83-a201-20214af45bc1';

  @action
  setImgUrl(value) => imgUrl = value;

  @observable
  String searchValue = '';

  @action
  setSearchValue(value) => searchValue = value;

  @observable
  PerfilModel perfilUserLogado = PerfilModel();

  @action
  setPerfilUserlogado(value) => perfilUserLogado = value;

  @observable
  bool expand = false;

  @observable
  bool expandTarefa = false;

  @action
  setExpandTarefa(value) => expandTarefa = value;

  @action
  setExpand(value) => expand = value;

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
  setTarefasTotais(value) => tarefasTotais.add(value);

  @observable
  List<TarefaDioModel> taskDio = [];

  @action
  setTaskDio(value) => taskDio = value;

  @observable
  UserDioClientModel userDio = UserDioClientModel();

  @action
  setUserDio(value) => userDio = value;

  @observable
  TarefaDioTotalModel tarefasDioTotais = TarefaDioTotalModel();

  @action
  setTarefasDioTotais(value) => tarefasDioTotais = value;
}
