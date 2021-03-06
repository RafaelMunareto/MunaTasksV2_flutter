import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/auth_module.dart';
import 'package:munatasks2/app/modules/outros/outros_module.dart';
import 'package:munatasks2/app/modules/settings/settings_module.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:munatasks2/app/shared/auth/repositories/biometric_repository.dart';
import 'package:munatasks2/app/shared/auth/repositories/biometric_repository_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/splash_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme_preferences.dart';
import 'package:local_auth/local_auth.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<ILocalStorage>((i) => LocalStorageShare()),
    Bind.instance<LocalAuthentication>(LocalAuthentication()),
    Bind.singleton<ThemePreferences>((i) => ThemePreferences()),
    Bind.singleton<IAuthRepository>((i) => AuthRepository()),
    Bind.singleton<IAuthRepository>((i) => AuthRepository()),
    Bind.singleton<IBiometricRepository>((i) => BiometricRepository()),
    Bind.singleton<AuthController>((i) =>
        AuthController(authRepository: i.get(), biometricRepository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => const SplashWidget()),
    ModuleRoute('/auth',
        module: AuthModule(), transition: TransitionType.leftToRightWithFade),
    ModuleRoute('/home',
        module: HomeModule(), transition: TransitionType.leftToRightWithFade),
    ModuleRoute('/privacy',
        module: OutrosModule(), transition: TransitionType.leftToRightWithFade),
    ModuleRoute('/settings',
        module: SettingsModule(),
        transition: TransitionType.leftToRightWithFade),
    ModuleRoute('/outros',
        module: OutrosModule(), transition: TransitionType.leftToRightWithFade),
  ];
}
