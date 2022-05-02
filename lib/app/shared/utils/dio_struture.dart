import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class DioStruture {
  final ILocalStorage storage = LocalStorageShare();
  final baseUrlMunatasks =
      'https://45.82.75.3:3000/'; //web desktop local 'http://localhost:3333/ app 'http://10.0.2.2:3333/''
  List<String> localStorage = [];
  String token = '';
  dioAction() async {
    localStorage = await storage.get('token');
    token = localStorage.isNotEmpty ? localStorage[0] : '';

    return Dio(BaseOptions(
        baseUrl: baseUrlMunatasks,
        headers: {"Authorization": 'Bearer $token'}));
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
