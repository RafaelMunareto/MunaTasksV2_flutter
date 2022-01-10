import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/controller/etiqueta_store.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/colors_model.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';

part 'etiquetas_store.g.dart';

class EtiquetasStore = _EtiquetasStoreBase with _$EtiquetasStore;

abstract class _EtiquetasStoreBase with Store {
  final IEtiquetaService etiquetaService;
  final EtiquetaStore etiquetaStore = Modular.get();

  _EtiquetasStoreBase({required this.etiquetaService}) {
    getColors();
    getList();
  }

  @action
  void getColors() {
    etiquetaStore.colorsList = etiquetaService.getColor().asObservable();
  }

  @action
  void getList() {
    etiquetaStore.etiquetaList = etiquetaService.get().asObservable();
  }

  @action
  submit() async {
    if (etiquetaStore.isValidateEtiqueta) {
      etiquetaStore.setShowValidation(false);
      await etiquetaStore.setLoading(true);
      etiquetaStore.setColorAction(false);
      EtiquetaModel etiquetaModel = EtiquetaModel(
          color: etiquetaStore.color,
          icon: etiquetaStore.icon,
          etiqueta: etiquetaStore.etiqueta,
          reference: etiquetaStore.reference);
      etiquetaService.save(etiquetaModel).then((value) {
        etiquetaStore.setEtiqueta('teste');
        etiquetaStore.setMsg('Salvo com sucesso');
        etiquetaStore.setErrOrGoal(false);
        etiquetaStore.setLoading(false);
        etiquetaStore.setCleanVariables();
      }, onError: (erro) {
        etiquetaStore.setMsg(erro);
        etiquetaStore.setErrOrGoal(true);
        etiquetaStore.setLoading(false);
      });
    } else {
      etiquetaStore.setShowValidation(true);
    }
  }

  @action
  delete(EtiquetaModel model) {
    etiquetaService.delete(model);
  }

  @action
  loadingUpdate(model) {
    etiquetaStore.setUpdateLoading(true);
    etiquetaStore.setEtiqueta(model.etiqueta);
    etiquetaStore.setColor(model.color);
    etiquetaStore.setIcon(model.icon);
    etiquetaStore.setReference(model.reference);
    etiquetaStore.setEtiqueta(model.etiqueta);
  }
}
