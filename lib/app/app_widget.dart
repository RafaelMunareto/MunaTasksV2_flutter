import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/modules/settings/principal/shared/model/settings_user_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
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
  UserDioClientModel user = UserDioClientModel();
  PerfilDioModel perfil = PerfilDioModel();
  SettingsUserModel settings = SettingsUserModel();

  @override
  initState() {
    changeSettings();
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

  getUid() {
    theme.get('userDio').then((value) {
      setState(() {});
      user = UserDioClientModel.fromJson(jsonDecode(value[0]));
    });
  }

  getBydDioId() async {
    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/${user.id}');
    setState(() {
      perfil = PerfilDioModel.fromJson(response.data[0]);
    });
  }

  void changeSettings() async {
    await getUid();
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
      title: 'MunaTask',
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
