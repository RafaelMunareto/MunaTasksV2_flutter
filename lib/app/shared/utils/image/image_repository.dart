import 'dart:async';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class ImageRepository {
  final ImagePicker picker = ImagePicker();
  final ClientStore client = ClientStore();

  void dispose() {}

  Future recuperarImagem(
      String origemImagem, Function loading, String id) async {
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
      loading(true);
      return uploadImagem(image, loading, id);
    }
  }

  uploadImagem(XFile image, Function loading, String id) async {
    FormData formData = FormData.fromMap(
      {
        "files.image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      },
    );

    Response response;
    response =
        await DioStruture().dioAction().put('perfil/$id', data: formData);
    DioStruture().statusRequest(response);
  }

  atualizarUrlImagemPerfilProfile(
      String origemImagem, Function loading, String id) async {
    recuperarImagem(origemImagem, loading, id);
    loading(false);
  }
}
