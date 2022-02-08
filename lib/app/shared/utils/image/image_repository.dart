import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

class ImageRepository {
  final ImagePicker picker = ImagePicker();
  final AuthController auth = Modular.get();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ClientStore client = ClientStore();
  String? url;

  void dispose() {}

  Future recuperarImagem(String origemImagem, Function loading) async {
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
      return uploadImagem(image, loading);
    }
  }

  uploadImagem(XFile image, Function loading) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo =
        pastaRaiz.child("perfil").child(auth.user!.uid + ".jpg");

    File file = File(image.path);
    UploadTask task = arquivo.putFile(file);

    task.snapshotEvents.listen((TaskSnapshot snapshot) async {
      if (snapshot.state == TaskState.running) {
        loading(true);
      } else if (snapshot.state == TaskState.success) {
        await recuperarUrlImagem(snapshot, loading);
      }
    });
  }

  recuperarUrlImagem(TaskSnapshot snapshot, Function loading) async {
    url = await snapshot.ref.getDownloadURL();
    Timer(const Duration(seconds: 3), () => loading(false));
  }

  atualizarUrlImagemPerfilProfile(
      String origemImagem,
      Function loading,
      List<UserModel> userModel,
      Function getById,
      Function setPerfilImage) async {
    await recuperarImagem(origemImagem, loading);
    if (!client.loadingImagem) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      Map<String, dynamic> atualizarImage = {"urlImage": url};
      await db
          .collection("usuarios")
          .doc(auth.user!.uid)
          .update(atualizarImage);
      await db.collection("perfil").doc(auth.user!.uid).update(atualizarImage);

      firebaseAuth.currentUser?.updatePhotoURL(url).then((value) {
        userModel = [];
      }).then((value) {
        getById();
      });
    }
  }
}
