import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class DioStruture {
  final ILocalStorage storage = LocalStorageShare();
  final baseUrlMunatasks = 'http://localhost:3333/';
  String tokenValue = '';

  dioAction() async {
    await storage.get('token').then((value) {
      if (value != null) {
        return Dio(
          BaseOptions(
              baseUrl: baseUrlMunatasks,
              headers: {"Authorization": 'Bearer  ${value[0]}'}),
        );
      }
    });
    return Dio(
      BaseOptions(baseUrl: baseUrlMunatasks),
    );
  }

  statusRequest(response) {
    if (kDebugMode) {
      print(
        response.statusCode.toString() +
            ' ' +
            response.statusMessage.toString() +
            ' ' +
            response.realUri.toString(),
      );
    }
  }
}
