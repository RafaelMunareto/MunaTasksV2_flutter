import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/create/create_store.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class CreatePage extends StatefulWidget {
  final String title;
  const CreatePage({Key? key, this.title = 'Nova Tarefa'}) : super(key: key);
  @override
  CreatePageState createState() => CreatePageState();
}

class CreatePageState extends State<CreatePage> {
  final CreateStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.add_circle,
          context: context,
          settings: true,
          rota: '/home'),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
