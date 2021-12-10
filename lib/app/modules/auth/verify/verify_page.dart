import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/auth/verify/verify_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/background_widget.dart';

class VerifyPage extends StatefulWidget {
  final String title;
  final String code;
  final String mode;

  const VerifyPage(
      {Key? key, this.title = 'Verificação de email', this.code = '', this.mode=''})
      : super(key: key);

  @override
  VerifyPageState createState() => VerifyPageState();
}

class VerifyPageState extends State<VerifyPage> {
  final VerifyStore store = Modular.get();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    store.setCode(widget.code);
    store.setMode(widget.mode);
    store.emailVerify();
    super.initState();
  }

  _card() {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            store.msg,
            style: TextStyle(
                color: store.msgErrOrGoal ? Colors.green : Colors.red,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: BackgroundWidget(
        child: LayoutBuilder(builder: (context, constraint) {
          var largura = constraint.maxWidth;

          if (largura < 600) {
            largura = largura * 1;
          } else if (largura < 768) {
            largura = largura * 0.6;
          } else if (largura < 1024) {
            largura = largura * 0.4;
          } else {
            largura = largura * 0.2;
          }

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
                    "VERIFICAÇÃO DE EMAIL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Observer(builder: (_) {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: store.msg != '' ? _card() : Container()),
                        ]),
                  );
                })
              ],
            ),
          ));
        }),
      ),
    );
  }
}
