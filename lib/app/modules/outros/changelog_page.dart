import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/outros/change_text_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class ChangelogPage extends StatefulWidget {
  final String title;
  const ChangelogPage({Key? key, this.title = 'Change log'}) : super(key: key);
  @override
  ChangelogPageState createState() => ChangelogPageState();
}

class ChangelogPageState extends State<ChangelogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.privacy_tip,
          context: context,
          settings: true,
          rota: '/home/'),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const ChangeTextWidget(
                    title: 'Versão 2.1.8',
                    corpo:
                        ' - Criação do changelog ao clicar no ícone da versão. \n\n'
                        ' - Ajuste do botão incluir subtarefas nos aparelhos mais antigos.\n\n'
                        ' - Ajuste do bug do popup de atualização da versão mobile. \n\n',
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
