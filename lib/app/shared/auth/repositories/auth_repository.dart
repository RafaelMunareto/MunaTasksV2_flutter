import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/error_pt_br.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = Modular.get();
  final FirebaseFirestore db = Modular.get();
  final FirebaseDynamicLinks fdl = Modular.get();
  final ILocalStorage storage = LocalStorageShare();

  @override
  Future getEmailPasswordLogin(email, password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future getFacebookLogin() {
    throw UnimplementedError();
  }

  @override
  Future<String> getToken() {
    throw UnimplementedError();
  }

  @override
  getGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User? user = (await auth.signInWithCredential(credential)).user;
    storage.put('user', []);
    storage.put('user',
        [user!.uid, user.displayName.toString(), user.photoURL.toString()]);
    return user;
  }

  @override
  getUser() {
    User? user = FirebaseAuth.instance.currentUser;

    return user;
  }

  @override
  Future getLogout() {
    return auth.signOut();
  }

  @override
  Future createUserSendEmailLink(name, email, password) {
    return auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) {
      User? user = FirebaseAuth.instance.currentUser;
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://munatasksv2.firebaseapp.com/auth/verify',
        androidPackageName: "munacorp.munatasks2.br.munatasks2",
        handleCodeInApp: true,
      );
      if (kIsWeb) {
        user!.sendEmailVerification();
      } else {
        if (user != null && !getUser().emailVerified) {
          user.sendEmailVerification(actionCodeSettings);
        }
      }
      firebaseUser.user!.updatePhotoURL(
          'https://firebasestorage.googleapis.com/v0/b/flutterpadrao.appspot.com/o/perfil%2Fbancario1.png?alt=media&token=ff79a9b9-7f1e-4e53-98c7-824324f74935');
      firebaseUser.user!.updateDisplayName(name).then((value) {
        db.collection('usuarios').doc(auth.currentUser!.uid).set({
          "name": name,
          "email": email,
          "urlImage":
              'https://firebasestorage.googleapis.com/v0/b/flutterpadrao.appspot.com/o/perfil%2Fbancario1.png?alt=media&token=ff79a9b9-7f1e-4e53-98c7-824324f74935',
          "verificado": false
        });
      });
    });
  }

  @override
  Future getGrupoEmail() {
    return db.collection('grupoEmail').get();
  }

  @override
  Future emailVerify(code) async {
    await auth.checkActionCode(code);
    await auth.applyActionCode(code);
    getUser().reload();
    await db
        .collection('usuarios')
        .doc(getUser().uid)
        .update({"verificado": true});

    await db.collection('perfil').doc(getUser().uid).set({
      "name": getUser().displayName,
      "urlImage":
          'https://firebasestorage.googleapis.com/v0/b/flutterpadrao.appspot.com/o/perfil%2Fbancario1.png?alt=media&token=ff79a9b9-7f1e-4e53-98c7-824324f74935',
      "manager": false,
      "nameTime": "Nome do time",
      "idStaff": []
    });
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  @override
  Future createUserEmailPassword(name, email, password) {
    return auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) async {
      firebaseUser.user!.updatePhotoURL(
          'https://firebasestorage.googleapis.com/v0/b/flutterpadrao.appspot.com/o/perfil%2Fbancario1.png?alt=media&token=ff79a9b9-7f1e-4e53-98c7-824324f74935');
      firebaseUser.user!.updateDisplayName(name).then((value) {
        changeUserVerificacao();
      });
    });
  }

  @override
  Future sendChangePasswordEmail(email) {
    var actionCodeSettings = ActionCodeSettings(
      url: 'https://munatasksv2.firebaseapp.com/auth/verify',
      androidPackageName: "munacorp.munatasks2.br.munatasks2",
      handleCodeInApp: true,
    );
    if (kIsWeb) {
      return auth.sendPasswordResetEmail(email: email);
    }
    return auth.sendPasswordResetEmail(
        email: email, actionCodeSettings: actionCodeSettings);
  }

  @override
  Future changeResetPassword(password, code) async {
    try {
      await auth.verifyPasswordResetCode(code).then((value) {
        auth.currentUser?.reload();
        return auth.confirmPasswordReset(code: code, newPassword: password);
      });
    } on FirebaseAuthException catch (e) {
      return ErrorPtBr().verificaCodeErro('auth/' + e.code);
    }
  }

  changeUserVerificacao() async {
    await db.collection('usuarios').doc(getUser().uid).update({
      "name": getUser().displayName,
      "email": getUser().email,
      "urlImage":
          'https://firebasestorage.googleapis.com/v0/b/flutterpadrao.appspot.com/o/perfil%2Fbancario1.png?alt=media&token=ff79a9b9-7f1e-4e53-98c7-824324f74935',
      "verificado": true
    });
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return db.collection('usuarios').snapshots().map((query) =>
        query.docs.map((doc) => UserModel.fromDocument(doc)).toList());
  }
}
