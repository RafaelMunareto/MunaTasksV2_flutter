import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatefulWidget {
  @override
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
  static _AppWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppWidgetState>();
}

class _AppWidgetState extends State<AppWidget> {
  ThemeMode _themeMode = ThemeMode.system;
  final ILocalStorage theme = LocalStorageShare();
  late String darkLight = '';

  @override
  initState() {
    changeThemeStorage();
    super.initState();
  }

  void changeThemeStorage() async {
    await theme.get('theme').then((value) {
      setState(() {
        value?[0] == 'dark'
            ? _themeMode = ThemeMode.dark
            : _themeMode = ThemeMode.light;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MunaTasks V2',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    ).modular();
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
