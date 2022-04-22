import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class TarefasPage extends StatefulWidget {
  final String title;
  const TarefasPage({Key? key, this.title = 'Tarefas '}) : super(key: key);
  @override
  TarefasPageState createState() => TarefasPageState();
}

class TarefasPageState extends State<TarefasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          context: context,
          icon: Icons.task,
          settings: true,
          rota: '/home/',
          back: true),
      body: const LandscapeWidget(),
    );
  }
}
