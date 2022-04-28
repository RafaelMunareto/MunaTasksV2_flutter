import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uni_links/uni_links.dart';

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
  bool isDark = false;
  StreamSubscription? _sub;

  @override
  initState() {
    changeThemeStorage();
    super.initState();
    _handleIncomingLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _handleIncomingLinks() {
    if (!kIsWeb && defaultTargetPlatform != TargetPlatform.windows) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        Modular.to
            .navigate('/auth/change/?code=${uri.toString().split('code=')[1]}');
      }, onError: (Object err) {
        if (!mounted) return;
      });
    }
  }

  void changeThemeStorage() async {
    await theme.get('theme').then((value) {
      value?[0] == 'dark'
          ? _themeMode = ThemeMode.dark
          : _themeMode = ThemeMode.light;
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
      // ignore: deprecated_member_use
    ).modular();
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
