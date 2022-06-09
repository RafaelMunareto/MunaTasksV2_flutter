import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';

part 'client_store.g.dart';

class ClientStore = _ClientStoreBase with _$ClientStore;

abstract class _ClientStoreBase with Store {
  @observable
  String urlImagemRecuperada = '';

  @observable
  bool theme = false;

  @observable
  bool showTeams = false;

  @observable
  bool loading = true;

  @observable
  bool loadingImagem = true;

  @observable
  List<PerfilDioModel> userModel = [];

  @observable
  List<PerfilDioModel> perfis = [];

  @action
  setTheme(value) => theme = value;

  @action
  setPerfis(value) => perfis = value;

  @observable
  bool inputChip = false;

  @observable
  List<dynamic> individualChip = [];

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
  setLoading(value) => loading = value;

  @action
  changeName(value) => perfilDio.name.name = value;

  @action
  changeManager(value) => perfilDio.manager = value;

  @action
  changeTime(value) => perfilDio.nameTime = value;

  @observable
  String nameTime = '';

  @action
  setNameTime(value) => nameTime = value;

  @action
  setPerfilImage(value) => perfilDio.urlImage = value;

  @action
  setIdStaff(value) async {
    perfilDio.idStaff ??= [];
    if (perfilDio.idStaff.isNotEmpty) {
      perfilDio.idStaff = await perfilDio.idStaff
          .map((e) => PerfilDioModel.fromJson(e))
          .toList();
      if (perfilDio.idStaff!.where((e) => e.id == value.id).toList().isEmpty) {
        perfilDio.idStaff?.add(value);
      } else {
        perfilDio.idStaff.removeWhere((element) => element.id == value.id);
        if (perfilDio.idStaff!.isEmpty) {
          individualChip = [];
        }
      }
    } else {
      perfilDio.idStaff.add(value);
    }
  }

  @action
  inputChipChecked(value) {
    if (userModel.map((e) => e.id).contains(value)) {
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
    if (perfilDio.name.name.isEmpty) {
      return 'Campo obrigatório';
    } else if (perfilDio.name.name.length < 3) {
      return 'Min de 3 caracteres';
    }
    return null;
  }

  @computed
  bool get isValideNameTime {
    return validateTime() == null;
  }

  String? validateTime() {
    if (perfilDio.nameTime == null) {
      return 'Campo obrigatório';
    } else if (perfilDio.nameTime!.length < 3) {
      return 'Min de 3 caracteres';
    }
    return null;
  }

  @observable
  UserDioClientModel userSelection = UserDioClientModel();

  @action
  setUserSelection(value) => userSelection = value;

  @observable
  PerfilDioModel perfilDio = PerfilDioModel();

  @observable
  List<dynamic> users = [];

  @action
  setPerfildio(value) => perfilDio = value;

  @action
  setUsersDio(value) => users = value;

  @observable
  String urlImage = '';
}
