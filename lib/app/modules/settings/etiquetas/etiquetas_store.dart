import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';

part 'etiquetas_store.g.dart';

class EtiquetasStore = _EtiquetasStoreBase with _$EtiquetasStore;

abstract class _EtiquetasStoreBase with Store {
  final IEtiquetaService etiquetaService;

  _EtiquetasStoreBase({required this.etiquetaService}) {
    getColors();
  }

  @observable
  ObservableStream<List<ColorsModel>>? colorsList;

  @observable
  String etiqueta = '';

  @observable
  String color = '';

  @action
  void getColors() {
    colorsList = etiquetaService.getColor().asObservable();
  }
}
