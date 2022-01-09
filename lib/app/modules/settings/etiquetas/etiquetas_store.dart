import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';

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

  @action
  changeEtiqueta(value) => etiqueta = value;

  @observable
  dynamic icon;

  @action
  setIcon(value) => icon = value;

  @observable
  bool iconAction = false;

  @action
  setIconAction(value) => iconAction = value;

  @observable
  bool colorAction = false;

  @action
  setColorAction(value) => colorAction = value;

  @observable
  String color = '';

  @observable
  bool loading = false;

  @action
  setLoading(value) => loading = value;

  @observable
  bool errOrGoal = false;

  @observable
  String msg = '';

  @action
  setErrOrGoal(value) => errOrGoal = value;

  @action
  setMsg(value) => msg = value;

  @observable
  List<IconData> iconData = [
    Icons.settings,
    Icons.error,
    Icons.bookmark,
    Icons.card_membership,
    Icons.double_arrow,
    Icons.vignette,
    Icons.local_library
  ];

  @action
  setColor(value) => color = value;

  @action
  void getColors() {
    colorsList = etiquetaService.getColor().asObservable();
  }

  String? validateEtiqueta() {
    if (etiqueta.isEmpty) {
      return 'Campo obrigatório';
    } else if (etiqueta.length < 3) {
      return 'Min de 3 caracteres';
    }
    return null;
  }

  String? validateIcon() {
    if (etiqueta.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? validateColor() {
    if (etiqueta.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  @computed
  bool get isValidateEtiqueta {
    return validateEtiqueta() == null &&
        validateColor() == null &&
        validateIcon() == null;
  }

  @action
  submit() {
    setLoading(true);
    EtiquetaModel etiquetaModel =
        EtiquetaModel(color: color, icon: icon, etiqueta: etiqueta);
    if (isValidateEtiqueta) {
      etiquetaService.save(etiquetaModel).then((value) {
        setCleanVariables();
        setMsg('Salvo com sucesso');
        setErrOrGoal(false);
        setLoading(false);
      }, onError: (erro) {
        setMsg(erro);
        setErrOrGoal(true);
        setLoading(false);
      });
    }
  }

  @action
  setCleanVariables() {
    changeEtiqueta('');
    setIcon(null);
    setColor('');
  }
}
