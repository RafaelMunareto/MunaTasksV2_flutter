import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_hive.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';

class ThemePreferences {
  static const String prefKey = 'pref_them_key';
  final ILocalStorage _localStorage = LocalStorageHive();

  setTheme(value)
  {
    _localStorage.put(prefKey, value);
  }

  getTheme(){
    _localStorage.get(prefKey);
  }
}