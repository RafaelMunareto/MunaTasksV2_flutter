import 'package:mobx/mobx.dart';

part 'etiquetas_store.g.dart';

class EtiquetasStore = _EtiquetasStoreBase with _$EtiquetasStore;
abstract class _EtiquetasStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}