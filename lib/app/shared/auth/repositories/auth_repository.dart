import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ILocalStorage storage = LocalStorageShare();

  @override
  Future getFacebookLogin() {
    throw UnimplementedError();
  }

  @override
  getGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // final AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
  }

  @override
  Future getLogout() {
    return storage.put('userDio', []);
  }

  @override
  Future loginDio(email, password) async {
    Response response;
    var dio = Dio(
      BaseOptions(
        baseUrl: DioStruture().baseUrlMunatasks,
      ),
    );

    response = await dio.post('sessions',
        data: jsonEncode({"email": email, "password": password}));
    DioStruture().statusRequest(response);
    storage.put('userDio', [jsonEncode(UserDioModel.fromJson(response.data))]);
    return response;
  }

  @override
  getUser() async {
    await storage.get('userDio').then((value) {
      if (value != null) {
        return UserDioClientModel.fromJson(jsonDecode(value[0])['user']);
      }
    });
    return '';
  }
}
