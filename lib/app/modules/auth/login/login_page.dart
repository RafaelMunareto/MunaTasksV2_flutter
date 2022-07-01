import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/background_widget.dart';
import 'package:munatasks2/app/shared/components/button_widget.dart';
import 'package:munatasks2/app/shared/components/link_rote_widget.dart';
import 'package:munatasks2/app/shared/components/text_field_widget.dart';
import 'package:munatasks2/app/shared/utils/downloads_widget.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (store.client.msg != '') {
          SnackbarCustom().createSnackBareErrOrGoal(_scaffoldKey,
              message: store.client.msg, errOrGoal: store.client.msgErrOrGoal);
          if (store.client.msgErrOrGoal) {
            Timer(
              const Duration(seconds: 2),
              () => store.client.setCleanVariables(),
            );
          }
          store.client.setMsg('');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: BackgroundWidget(
        child: LayoutBuilder(builder: (context, constraint) {
          var largura = LarguraLayoutBuilder().largura(constraint.maxWidth);
          return SingleChildScrollView(
              child: SizedBox(
            width: largura,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                    child: TextFieldWidget(
                        labelText: 'E-mail',
                        onChanged: store.client.changeEmail,
                        errorText: store.client.validateEmail)),
                Observer(builder: (_) {
                  return SizedBox(
                    child: TextFieldWidget(
                        labelText: 'Senha',
                        obscure: true,
                        onChanged: store.client.changePassword,
                        functionBool: store.client.isValidLogin,
                        function: store.submit,
                        errorText: store.client.validatePassword),
                  );
                }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: const LinkRoteWidget(
                      labelBold: 'Esqueceu a senha ? ', rota: '/auth/forget/'),
                ),
                SizedBox(height: size.height * 0.05),
                Observer(builder: (_) {
                  return Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ButtonWidget(
                        label: 'LOGIN',
                        theme: store.client.theme,
                        width: size.width * 0.5,
                        loading: store.client.loading,
                        function:
                            store.client.isValidLogin ? store.submit : null),
                  );
                }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 58),
                  child: const LinkRoteWidget(
                      labelBold: 'Não tem cadastro? Registre-se',
                      rota: '/auth/signup/'),
                ),
                Observer(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 32, right: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        store.client.supportState == SupportState.supported
                            ? GestureDetector(
                                onTap: store.authenticateBiometric,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: 64,
                                  child: store.client.faceOrFinger
                                      ? const Image(
                                          image:
                                              AssetImage('assets/img/face.png'))
                                      : const Image(
                                          image: AssetImage(
                                              'assets/img/digital.png')),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
                kIsWeb
                    ? constraint.maxWidth < LarguraLayoutBuilder().telaPc
                        ? Container()
                        : const Padding(
                            padding: EdgeInsets.only(top: 28.0),
                            child: DownloadsWidget(),
                          )
                    : Container(),
              ],
            ),
          ));
        }),
      ),
    );
  }
}
