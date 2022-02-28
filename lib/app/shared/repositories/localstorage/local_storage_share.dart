import 'dart:async';
import 'dart:convert';

import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageShare implements ILocalStorage {
  final Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  LocalStorageShare() {
    _init();
  }

  @override
  Future delete(String key) async {
    var shared = await _instance.future;
    shared.remove(key);
  }

  @override
  Future get(String key) async {
    var shared = await _instance.future;
    return shared.getStringList(key);
  }

  @override
  Future put(String key, List<String> value) async {
    var shared = await _instance.future;
    shared.setStringList(key, value);
  }

  @override
  Future putObject(String key, String value) async {
    var shared = await _instance.future;
    shared.setString(key, value);
  }
}
