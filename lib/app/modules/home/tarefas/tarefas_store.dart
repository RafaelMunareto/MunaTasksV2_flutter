import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'tarefas_store.g.dart';

class TarefasStore = _TarefasStoreBase with _$TarefasStore;

abstract class _TarefasStoreBase with Store {
  final ILocalStorage storage = Modular.get();
  final ClientStore client = Modular.get();

  _TarefasStoreBase() {
    client.buscaTheme();
  }
}
