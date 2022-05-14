import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'tarefas_store.g.dart';

class TarefasStore = _TarefasStoreBase with _$TarefasStore;

abstract class _TarefasStoreBase with Store {
  final ILocalStorage storage = Modular.get();

  _TarefasStoreBase() {
    buscaTheme();
  }

  @observable
  bool theme = false;

  @action
  setTheme(value) => theme = value;

  @observable
  bool themeLoading = false;

  @action
  setThemeLoading(value) => themeLoading = value;

  buscaTheme() async {
    await storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        setTheme(true);
      } else {
        setTheme(false);
      }
      setThemeLoading(true);
    });
  }
}
