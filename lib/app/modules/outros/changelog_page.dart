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
        child: SingleChildScrollView(
          child: Column(children: const [
            ChangeTextWidget(
              title: 'Versão 2.1.9',
              corpo: ' - Alteração do layout do thead do create. \n\n'
                  ' - Inclusão do atalho no create quando falta alum item obrigatório.\n\n'
                  ' - Fechamento do search quando altera alguma tarefa. \n\n'
                  ' - Inclusão do loading nas alterações de tarefas. \n\n'
                  ' - Ajuste do bug do botão novo da subtarefa que não apagava o texto.\n\n'
                  ' - Ajuste do Web Socket e do delete. \n\n'
                  ' - Inclusão do loading nas alterações de tarefas. \n\n'
                  ' - Aumento do tamanho do dialog para 100%.\n\n'
                  ' - Ajuste do bug de envio de emails com email suporte@munatask.com. \n\n',
            ),
            ChangeTextWidget(
              title: 'Versão 2.1.8',
              corpo:
                  ' - Criação do changelog ao clicar no ícone da versão. \n\n'
                  ' - Ajuste do botão incluir subtarefas nos aparelhos mais antigos.\n\n'
                  ' - Ajuste do bug do popup de atualização da versão mobile. \n\n',
            ),
          ]),
        ),
      ),
    );
  }
}
