import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

part 'client_store.g.dart';

class ClientStore = _ClientStoreBase with _$ClientStore;

abstract class _ClientStoreBase with Store {
  @observable
  String urlImagemRecuperada = '';

  @observable
  ObservableStream<List<UserModel>>? usuarios;

  @observable
  bool showTeams = false;

  @observable
  PerfilModel perfil = PerfilModel();

  @observable
  bool loading = false;

  @observable
  bool loadingImagem = false;

  @observable
  List<UserModel> userModel = [];

  @observable
  bool inputChip = false;

  @observable
  List<dynamic>? individualChip = [];

  @observable
  bool textFieldNameBool = false;

  @action
  showTextFieldName(value) => textFieldNameBool = value;

  @action
  setInputChip(value) => inputChip = value;

  @action
  setShowTeams(value) => showTeams = value;

  @action
  setLoadingImagem(value) => loadingImagem = value;

  @action
  setLoading(value) => loading = true;

  @action
  changeName(value) => perfil.name = value;

  @action
  changeManager(value) => perfil.manager = value;

  @action
  changeTime(value) => perfil.nameTime = value;

  @action
  setIdStaff(value) {
    if (!userModel.map((e) => e.reference).contains(value)) {
      perfil.idStaff?.add(value);
    } else {
      perfil.idStaff?.remove(value);
      if (perfil.idStaff!.isEmpty) {
        individualChip = [];
      }
    }
  }

  @action
  inputChipChecked(value) {
    if (userModel.map((e) => e.reference).contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  @computed
  bool get isValideName {
    return validateName() == null;
  }

  String? validateName() {
    if (perfil.name.isEmpty) {
      return 'Campo obrigatório';
    } else if (perfil.name.length < 3) {
      return 'Min de 3 caracteres';
    }
    return null;
  }

  @computed
  bool get isValideNameTime {
    return validateTime() == null;
  }

  String? validateTime() {
    if (perfil.nameTime.isEmpty) {
      return 'Campo obrigatório';
    } else if (perfil.nameTime.length < 3) {
      return 'Min de 3 caracteres';
    }
    return null;
  }
}
