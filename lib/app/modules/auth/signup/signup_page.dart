import 'dart:async';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/signup/signup_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/background_widget.dart';
import 'package:munatasks2/app/shared/components/button_widget.dart';
import 'package:munatasks2/app/shared/components/link_rote_widget.dart';
import 'package:munatasks2/app/shared/components/text_field_widget.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:mobx/mobx.dart';

class SignupPage extends StatefulWidget {
  final String title;

  const SignupPage({Key? key, this.title = 'Registre-se'}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final SignupStore store = Modular.get();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if (store.client.msg != '') {
          SnackbarCustom().createSnackBareErrOrGoal(_scaffoldKey,
              errOrGoal: store.client.msgErrOrGoal,
              message: store.client.msg,
              rota: '/auth/');
          if (store.client.msgErrOrGoal) {
            Timer(const Duration(seconds: 2),
                () => store.client.setCleanVariables());
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
                    "CADASTRO",
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
                        labelText: 'Nome',
                        onChanged: store.client.changeName,
                        errorText: store.client.validateName)),
                SizedBox(
                    child: TextFieldWidget(
                        labelText: 'E-mail',
                        onChanged: store.client.changeEmail,
                        errorText: store.client.validateEmail)),
                SizedBox(
                  child: TextFieldWidget(
                      labelText: 'Senha',
                      obscure: true,
                      onChanged: store.client.changePassword,
                      errorText: store.client.validatePassword),
                ),
                Observer(builder: (_) {
                  return SizedBox(
                    child: TextFieldWidget(
                        labelText: 'Confirma????o de senha',
                        obscure: true,
                        onChanged: store.client.changeConfirmPassword,
                        functionBool: store.isValidRegisterEmailGrupo,
                        function: store.submit,
                        errorText: store.client.validateConfirmPassword),
                  );
                }),
                SizedBox(height: size.height * 0.05),
                Observer(builder: (_) {
                  return Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ButtonWidget(
                        label: 'CADASTRAR',
                        theme: store.client.theme,
                        width: size.width * 0.5,
                        loading: store.client.loading,
                        function: store.isValidRegisterEmailGrupo
                            ? store.submit
                            : null),
                  );
                }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 58),
                  child: const LinkRoteWidget(
                      labelBold: 'J?? possui cadastro? Login', rota: '/auth/'),
                ),
              ],
            ),
          ));
        }),
      ),
    );
  }
}
