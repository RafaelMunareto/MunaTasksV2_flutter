// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/modules/settings/perfil/services/interfaces/perfil_service_interface.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';

part 'perfil_store.g.dart';

class PerfilStore = _PerfilStoreBase with _$PerfilStore;

abstract class _PerfilStoreBase with Store {
  final IPerfilService perfilService;
  final AuthController auth = Modular.get();
  final FirebaseFirestore bd = Modular.get();
  final ImagePicker picker = ImagePicker();
  final FirebaseAuth firebaseAuth = Modular.get();
  _PerfilStoreBase({required this.perfilService}) {
    getById();
  }

  @observable
  String urlImagemRecuperada = '';

  @observable
  PerfilModel perfil = PerfilModel();

  @observable
  bool loading = false;

  @observable
  bool loadingImagem = false;

  @action
  setLoadingImagem(value) => loadingImagem = value;

  @action
  setLoading(value) => loading = true;

  @observable
  List<dynamic> userModel = [];

  @action
  getById() {
    perfilService.getByDocumentId(auth.user!.uid).then((value) {
      perfil = value;
    }).then((value) {
      for (var element in perfil.idStaff!) {
        bd.collection('usuarios').doc(element.id).get().then(
          (doc) {
            dynamic user = UserModel(
                name: doc['name'],
                email: doc['email'],
                urlImage: doc['urlImage']);
            userModel.add(user);
          },
        );
      }
    }).then((value) {
      Timer(const Duration(seconds: 2), () => setLoading(true));
    });
  }

  @action
  Future recuperarImagem(String origemImagem) async {
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
      setLoadingImagem(true);
      uploadImagem(image);
    }
  }

  @action
  Future uploadImagem(XFile image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo =
        pastaRaiz.child("perfil").child(auth.user!.uid + ".jpg");

    File file = File(image.path);
    UploadTask task = arquivo.putFile(file);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      if (snapshot.state == TaskState.running) {
        setLoadingImagem(true);
      } else if (snapshot.state == TaskState.success) {
        recuperarUrlImagem(snapshot).then((value) => setLoading(false));
      }
    });
  }

  @action
  Future recuperarUrlImagem(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    atualizarUrlImagemFirestore(url);
  }

  @action
  atualizarUrlImagemFirestore(String url) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic> atualizarImage = {"urlImage": url};
    db.collection("usuarios").doc(auth.user!.uid).update(atualizarImage);
    db.collection("perfil").doc(auth.user!.uid).update(atualizarImage);
    firebaseAuth.currentUser?.updatePhotoURL(url).then((value) {
      userModel = [];
      getById();
    }).then((value) {
      setLoadingImagem(false);
    });
  }
}
