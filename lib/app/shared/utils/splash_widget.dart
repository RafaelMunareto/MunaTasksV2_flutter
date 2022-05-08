import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/app_widget.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';

class SplashWidget extends StatefulWidget {
  final String title;

  const SplashWidget({Key? key, this.title = "SplashWidget"}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  final ILocalStorage theme = LocalStorageShare();
  final AuthRepository auth = AuthRepository();
  bool lightMode = true;
  Color? color;

  void changeThemeStorage() async {
    await theme.get('theme').then((value) {
      if (value != null) {
        if (value.isNotEmpty) {
          setState(() {
            value?[0] == 'dark' ? lightMode = true : lightMode = false;
            AppWidget.of(context)?.changeTheme(
                value?[0] == 'dark' ? ThemeMode.dark : ThemeMode.light);
            lightMode
                ? color = const Color(0xfff7f6f4)
                : color = const Color(0xff042a49);
          });
        }
      }
    });
  }

  @override
  void initState() {
    changeThemeStorage();
    theme.get('token').then((value) {
      if (value != null) {
        if (value.isNotEmpty) {
          Modular.to.navigate('/home/');
        } else {
          Modular.to.navigate('/auth/');
        }
      } else {
        Modular.to.navigate('/auth/');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          double withDevice = constraint.maxWidth;

          if (withDevice < 600) {
            withDevice = withDevice * 0.58;
          } else if (withDevice < 960) {
            withDevice = withDevice * 0.3;
          } else if (withDevice < 1025) {
            withDevice = withDevice * 0.2;
          } else {
            withDevice = withDevice * 0.15;
          }
          return Center(
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image(
                  image: const AssetImage('assets/icon/icon.png'),
                  width: withDevice),
            ),
          );
        },
      ),
    );
  }
}
