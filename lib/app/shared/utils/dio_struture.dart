import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class DioStruture {
  final ILocalStorage storage = LocalStorageShare();
  String token = '';
  final baseUrlMunatasks = 'https://munatasks.herokuapp.com/';
  dioAction() {
    tokenDio();
    return Dio(
      BaseOptions(
        baseUrl: baseUrlMunatasks,
        headers: {
          "Authorization": 'Bearer ' +
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMTZjN2MwMzRhYzViNTJjZmQ4N2Y4MSIsImlhdCI6MTY0NjA4NTc5Mn0.n6m3BNKCJRiZ3LESK-FXpgaixiV8LT9FVNVTywsaHQY'
        },
      ),
    );
  }

  statusRequest(response) {
    print(
      response.statusCode.toString() +
          ' ' +
          response.statusMessage.toString() +
          ' ' +
          response.realUri.toString(),
    );
  }

  tokenDio() async {
    await storage.get('userDio').then((value) {
      token = jsonDecode(value[0])['token'];
    });
  }
}
