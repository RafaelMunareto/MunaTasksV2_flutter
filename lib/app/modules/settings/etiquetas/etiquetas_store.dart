import 'package:cloud_firestore/cloud_firestore.dart';
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
    getList();
  }

  @observable
  EtiquetaModel etiquetaModel = EtiquetaModel();

  @action
  setEtiquetaModel(value) => etiquetaModel = value;

  @observable
  ObservableStream<List<ColorsModel>>? colorsList;

  @observable
  ObservableStream<List<EtiquetaModel>>? etiquetaList;

  @observable
  String etiqueta = '';

  @action
  changeEtiqueta(value) => etiqueta = value;

  @observable
  int? icon;

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
  bool updateLoading = false;

  @action
  setUpdateLoading(value) => updateLoading = value;

  @observable
  DocumentReference? reference;

  @action
  setReference(value) => reference = value;

  @action
  setColor(value) => color = value;

  @action
  void getColors() {
    colorsList = etiquetaService.getColor().asObservable();
  }

  @action
  void getList() {
    etiquetaList = etiquetaService.get().asObservable();
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
    if (isValidateEtiqueta) {
      if (!updateLoading) {
        setEtiquetaModel(
            EtiquetaModel(color: color, icon: icon, etiqueta: etiqueta));
      }
      etiquetaService.save(etiquetaModel).then((value) {
        setMsg('Salvo com sucesso');
        setErrOrGoal(false);
        setLoading(false);
        setCleanVariables();
      }, onError: (erro) {
        setMsg(erro);
        setErrOrGoal(true);
        setLoading(false);
      });
    }
  }

  setCleanVariables() {
    changeEtiqueta('');
    setIcon(null);
    setColor('');
  }

  @action
  delete(EtiquetaModel model) {
    etiquetaService.delete(model);
  }

  @action
  loadingUpdate(model) {
    setUpdateLoading(true);
    setEtiquetaModel(model);
  }
}
