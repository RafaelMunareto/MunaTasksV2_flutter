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
    return LayoutBuilder(builder: (context, constraint) {
      double withDevice = constraint.maxWidth;

      if (withDevice < 600) {
        withDevice = withDevice * 1;
      } else if (withDevice < 960) {
        withDevice = withDevice * 0.7;
      } else if (withDevice < 1025) {
        withDevice = withDevice * 0.5;
      } else {
        withDevice = withDevice * 0.5;
      }
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
            width: withDevice,
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(children: const [
                  ChangeTextWidget(
                    title: 'Versão 1.6.6',
                    corpo:
                        ' - Criação do changelog ao clicar no ícone da versão. \n\n'
                        ' - Ajuste do botão incluir subtarefas nos aparelhos mais antigos.\n\n'
                        ' - Ajuste do bug do popup de atualização da versão mobile. \n\n',
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
