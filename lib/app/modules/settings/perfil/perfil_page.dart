import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/text_field_widget.dart';

class PerfilPage extends StatefulWidget {
  final String title;
  const PerfilPage({Key? key, this.title = 'Perfil'}) : super(key: key);
  @override
  PerfilPageState createState() => PerfilPageState();
}
class PerfilPageState extends State<PerfilPage> {
  final PerfilStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, context: context, size: altura, settings: true, back: true),

      body: Column(
        children: <Widget>[
          TextFieldWidget(labelText: 'Nome', onChanged: (_) {}, errorText: () {}),
          TextFieldWidget(labelText: 'Função', onChanged: (_) {}, errorText: () {}),
          TextFieldWidget(labelText: 'Time', onChanged: (_) {}, errorText: () {}),
        ],
      ),
    );
  }
}