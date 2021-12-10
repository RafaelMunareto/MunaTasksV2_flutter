import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
        value?[0] == 'dark' ? lightMode = false :  lightMode = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    changeThemeStorage();
    Future.delayed(const Duration(seconds: 2), () {
      if(auth.getUser() != null){
        Modular.to.navigate('/home');
      }else{
        Modular.to.navigate('/auth');
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
      body: Center(
        child: Container(
          child: lightMode
              ? const Image(image: AssetImage('assets/img/splash_light.png'))
              : const Image(
                  image: AssetImage('assets/img/splash_dark.png'),
                ),
        ),
      ),
    );
  }
}
