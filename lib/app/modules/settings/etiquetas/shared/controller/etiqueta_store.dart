import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';

part 'etiqueta_store.g.dart';

class EtiquetaStore = _EtiquetaStoreBase with _$EtiquetaStore;

abstract class _EtiquetaStoreBase with Store {
  @observable
  ObservableStream<List<ColorsModel>>? colorsList;

  @observable
  List colorsDio = [];

  @action
  setColorsDio(value) => colorsDio = value;

  @observable
  List<EtiquetaDioModel> etiquetaDio = [];

  @observable
  bool expansionTitle = false;

  @action
  setExpansionTitle(value) => expansionTitle = value;

  @action
  setEtiquetaDio(value) => etiquetaDio = value;

  @action
  setEtiqueta(value) => etiqueta = value;

  @observable
  String etiqueta = '';

  @observable
  bool showValidation = false;

  @action
  setShowValidation(value) => showValidation = value;

  @observable
  int? icon;

  @action
  setIcon(value) => icon = value;

  @observable
  bool iconAction = false;

  @action
  setIconAction(value) => iconAction = value;

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
  bool updateLoading = false;

  @action
  setUpdateLoading(value) => updateLoading = value;

  @observable
  DocumentReference? reference;

  @action
  setReference(value) => reference = value;

  @observable
  String? id;

  @action
  setId(value) => id = value;

  @observable
  String color = '';

  @action
  setColor(value) => color = value;

  String? validateEtiqueta() {
    if (etiqueta.isEmpty) {
      return 'Campo obrigatório';
    } else if (etiqueta.length < 3) {
      return 'Min de 3 caracteres';
    }
    return null;
  }

  String? validateIcon() {
    if (icon == null) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? validateColor() {
    if (color.isEmpty) {
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
  setCleanVariables() {
    setEtiqueta('');
    setReference(null);
    setIcon(null);
    setColor('');
  }
}
