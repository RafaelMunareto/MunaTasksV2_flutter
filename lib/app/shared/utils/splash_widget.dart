import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
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

  void changeThemeStorage() async {
    await theme.get('theme').then((value) {
      setState(() {
        value?[0] == 'dark' ? lightMode = false : lightMode = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    changeThemeStorage();
    SessionManager().containsKey("token").then((value) {
      value ? Modular.to.navigate('/home/') : Modular.to.navigate('/auth/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xfff7f6f4) : const Color(0xff042a49),
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
              child: lightMode
                  ? Center(
                      child: Image(
                          image: const AssetImage('assets/icon/icon.png'),
                          width: withDevice))
                  : Center(
                      child: Image(
                          image: const AssetImage('assets/icon/icon.png'),
                          width: withDevice),
                    ),
            ),
          );
        },
      ),
    );
  }
}
