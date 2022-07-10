import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/my_custom_scroll_behavior.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
//import 'package:uni_links2/uni_links.dart';

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
  UserDioClientModel user = UserDioClientModel();
  PerfilDioModel perfil = PerfilDioModel();
  SettingsUserModel settings = SettingsUserModel();

  @override
  initState() {
    super.initState();
    // _handleIncomingLinks();
    getSettings();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  // void _handleIncomingLinks() {
  //   if (defaultTargetPlatform == TargetPlatform.android) {
  //     _sub = uriLinkStream.listen((Uri? uri) {
  //       if (!mounted) return;
  //       Modular.to
  //           .navigate('/auth/change/?code=${uri.toString().split('code=')[1]}');
  //     }, onError: (Object err) {
  //       if (!mounted) return;
  //     });
  //   }
  // }

  getUid() {
    theme.get('userDio').then((value) {
      if (value != null) {
        if (value.isNotEmpty) {
          setState(() {
            user = UserDioClientModel.fromJson(jsonDecode(value[0]));
          });
        }
      }
    });
  }

  getBydDioId() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/${user.id}');
    if (response.data.isNotEmpty) {
      setState(() {
        perfil = PerfilDioModel.fromJson(response.data[0]);
      });
    }
  }

  getSettings() async {
    await changeSettings();
    buscaStorage();
  }

  changeSettings() async {
    await getUid();
    if (user.id != null) {
      await getBydDioId();
      Response response;
      var dio = await DioStruture().dioAction();
      response = await dio.get('perfil/settingsUser/${perfil.id}');
      DioStruture().statusRequest(response);
      if (response.data.isEmpty) {
        SettingsUserModel settings = SettingsUserModel(user: perfil.id);
        response = await dio.post('perfil/settingsUser',
            data: settings.toJson(settings));
        theme.put('theme', settings.theme ? ['dark'] : ['light']);
      } else {
        setState(() {
          settings = SettingsUserModel.fromJson(response.data[0]);
          theme.put('theme', settings.theme ? ['dark'] : ['light']);
        });
      }
    }
  }

  buscaStorage() async {
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
    return MaterialApp.router(
      title: 'MunaTask',
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeMode,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        minWidth: 450,
        defaultName: DESKTOP,
        breakpoints: const [
          ResponsiveBreakpoint.autoScale(450, name: MOBILE),
          ResponsiveBreakpoint.resize(700, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
        ],
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      // ignore: deprecated_member_use
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
