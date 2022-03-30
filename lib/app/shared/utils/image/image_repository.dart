import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class ImageRepository {
  final ImagePicker picker = ImagePicker();
  final AuthController auth = Modular.get();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ClientStore client = ClientStore();
  final ILocalStorage storage = LocalStorageShare();
  String? url;

  void dispose() {}

  atualizarUrlImagemPerfilProfile(
    String origemImagem,
    String id,
    Function setLoading,
  ) async {
    XFile? image;
    switch (origemImagem) {
      case "camera":
        image = await picker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        image = await picker.pickImage(source: ImageSource.gallery);
        break;
    }
    if (image != null) {
      setLoading(true);
    }

    Response response;
    var formData = FormData.fromMap({
      'urlImage': await MultipartFile.fromFile(image!.path, filename: id),
    });
    response =
        await DioStruture().dioAction().put('perfil/$id', data: formData);

    setLoading(false);
  }
}
