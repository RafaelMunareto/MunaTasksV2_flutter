import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/order_model.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';

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
  ObservableStream<List<EtiquetaModel>>? etiquetaList;

  @observable
  ObservableStream<List<OrderModel>>? orderList;

  @observable
  bool open = false;

  @observable
  String etiquetaSelection = 'TODOS';

  @observable
  String orderSelection = 'DATA';

  @action
  setOrderSelection(value) => orderSelection = value;

  @action
  setEtiquetaSelection(value) => etiquetaSelection = value;

  @action
  setOpen(value) => open = value;

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
  cleanTarefasBase() => tarefasBase = [];

  @action
  changeTarefa(value) => tarefas = value;

  @action
  cleanTarefas() => tarefas = [];

  @observable
  int navigateBarSelection = 0;

  @action
  setColor(value) => color = value;

  @action
  setIcon(value) => icon = value;

  @observable
  String color = '';

  @observable
  int icon = 0;

  @observable
  bool closedListExpanded = false;

  @action
  setClosedListExpanded(value) => closedListExpanded = value;
}
