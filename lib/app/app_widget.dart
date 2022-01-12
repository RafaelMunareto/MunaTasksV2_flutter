import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

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
    initDynamicLinks();
    super.initState();
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) {
        var actionCode = deepLink.queryParameters['oobCode'];
        var tipo = deepLink.queryParameters['mode'];
        if (tipo == 'verifyEmail') {
          Modular.to.navigate('/auth/verify?oobCode=$actionCode&mode=$tipo');
        } else if (tipo == 'resetPassword') {
          Modular.to.navigate('/auth/change/$actionCode');
        }
      }
    }, onError: (OnLinkErrorException e) async {
      SnackbarCustom()
          .createSnackBarErrorFirebase(e.message, Colors.red, context);
    });
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
      title: 'Flutter Padrão',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeMode,
    ).modular();
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
