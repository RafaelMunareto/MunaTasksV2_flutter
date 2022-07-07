import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/home/shared/model/tarefa_dio_model.dart';

part 'client_tarefas_store.g.dart';

class ClientTarefasStore = _ClientTarefasStoreBase with _$ClientTarefasStore;

abstract class _ClientTarefasStoreBase with Store {
  @observable
  String idSelection = '';

  @action
  setIdSelection(value) => idSelection = value;

  @observable
  List<TarefaDioModel> tasksDio = [];

  @action
  setTaskDio(value) => tasksDio = value;
}
