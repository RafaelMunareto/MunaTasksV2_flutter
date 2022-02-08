import 'package:munatasks2/app/modules/auth/shared/models/client_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/change/change_page.dart';
import 'package:munatasks2/app/modules/auth/change/change_store.dart';
import 'package:munatasks2/app/modules/auth/forget/forget_page.dart';
import 'package:munatasks2/app/modules/auth/forget/forget_store.dart';
import 'package:munatasks2/app/modules/auth/login/login_page.dart';
import 'package:munatasks2/app/modules/auth/login/login_store.dart';
import 'package:munatasks2/app/modules/auth/signup/signup_page.dart';
import 'package:munatasks2/app/modules/auth/signup/signup_store.dart';
import 'package:munatasks2/app/modules/auth/verify/verify_page.dart';
import 'package:munatasks2/app/modules/auth/verify/verify_store.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ClientStore()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => SignupStore()),
    Bind.lazySingleton((i) => VerifyStore()),
    Bind.lazySingleton((i) => ForgetStore()),
    Bind.lazySingleton((i) => ChangeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/",
        child: (context, args) => const LoginPage(),
        transition: TransitionType.leftToRightWithFade),
    ChildRoute("/signup/",
        child: (context, args) => const SignupPage(),
        transition: TransitionType.leftToRightWithFade),
    ChildRoute("/verify/",
        child: (context, args) => VerifyPage(
            code: args.queryParams['oobCode'] ?? '',
            mode: args.queryParams['mode'] ?? ''),
        transition: TransitionType.leftToRightWithFade),
    ChildRoute("/forget/",
        child: (context, args) => const ForgetPage(),
        transition: TransitionType.leftToRightWithFade),
    ChildRoute("/change/:code/",
        child: (context, args) => ChangePage(code: args.params['code']),
        transition: TransitionType.leftToRightWithFade),
  ];
}
