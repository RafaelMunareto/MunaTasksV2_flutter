import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/controller/etiqueta_store.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/services/interfaces/etiqueta_service_interface.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

part 'etiquetas_store.g.dart';

class EtiquetasStore = _EtiquetasStoreBase with _$EtiquetasStore;

abstract class _EtiquetasStoreBase with Store {
  final IEtiquetaService etiquetaService;
  final ILocalStorage storage = Modular.get();
  final EtiquetaStore etiquetaStore = Modular.get();

  _EtiquetasStoreBase({required this.etiquetaService}) {
    buscaTheme();
    getDio();
    getSettings();
  }

  void getSettings() {
    etiquetaService.getSettings().then((value) {
      etiquetaStore.setColorsDio(value.color);
    });
  }

  void buscaTheme() {
    storage.get('theme').then((value) {
      if (value?[0] == 'dark') {
        etiquetaStore.setTheme(true);
      } else {
        etiquetaStore.setTheme(false);
      }
    });
  }

  void getDio() {
    etiquetaStore.setLoading(true);
    etiquetaService.getDio().then((value) {
      etiquetaStore.setEtiquetaDio(value);
    }).whenComplete(() => etiquetaStore.setLoading(false));
  }

  submitDio() async {
    if (etiquetaStore.isValidateEtiqueta) {
      etiquetaStore.setShowValidation(false);
      await etiquetaStore.setLoading(true);
      EtiquetaDioModel etiquetaModel = EtiquetaDioModel(
        color: etiquetaStore.color,
        icon: etiquetaStore.icon,
        etiqueta: etiquetaStore.etiqueta,
        id: etiquetaStore.id,
      );
      etiquetaService.saveDio(etiquetaModel).then((value) {
        if (etiquetaModel.id != null) {
          etiquetaStore.setMsg('${etiquetaModel.etiqueta} editado com sucesso');
        } else {
          etiquetaStore.setMsg('${etiquetaModel.etiqueta} salvo com sucesso');
        }
        etiquetaStore.setErrOrGoal(false);
        etiquetaStore.setLoading(false);
        etiquetaStore.setCleanVariables();
        etiquetaStore.setUpdateLoading(false);
        etiquetaStore.setExpansionTitle(false);
        getDio();
      }, onError: (erro) {
        etiquetaStore.setMsg(erro);
        etiquetaStore.setErrOrGoal(true);
        etiquetaStore.setLoading(false);
      });
    } else {
      etiquetaStore.setShowValidation(true);
    }
  }

  deleteDio(EtiquetaDioModel model) {
    etiquetaService.deleteDio(model).then((value) {
      if (value.statusCode == 200) {
        etiquetaStore.setMsg('${model.etiqueta} deletado com sucesso');
        etiquetaStore.setErrOrGoal(false);
        getDio();
      }
    });
  }

  loadingUpdate(model) {
    etiquetaStore.setUpdateLoading(true);
    etiquetaStore.setEtiqueta(model.etiqueta);
    etiquetaStore.setColor(model.color);
    etiquetaStore.setIcon(model.icon);
    etiquetaStore.setId(model.id);
    etiquetaStore.setEtiqueta(model.etiqueta);
  }
}
