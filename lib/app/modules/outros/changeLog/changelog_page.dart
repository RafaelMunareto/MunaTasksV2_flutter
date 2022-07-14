import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/home/shared/controller/client_store.dart';
import 'package:munatasks2/app/modules/outros/changeLog/change_text_widget.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';
import 'package:munatasks2/app/shared/components/menu_screen.dart';

class ChangelogPage extends StatefulWidget {
  final String title;
  const ChangelogPage({Key? key, this.title = 'Change log'}) : super(key: key);
  @override
  ChangelogPageState createState() => ChangelogPageState();
}

class ChangelogPageState extends State<ChangelogPage> {
  final ClientStore client = ClientStore();

  @override
  void initState() {
    client.buscaTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        appBar: AppBarWidget(
            title: widget.title,
            icon: Icons.privacy_tip,
            context: context,
            settings: true,
            rota: '/home/'),
        drawer: Drawer(
          child: MenuScreen(
            constraint: constraint.maxWidth,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Observer(builder: (_) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChangeTextWidget(
                          constraint: constraint.maxWidth,
                          theme: client.theme,
                          title: 'Versão 2.3.2',
                          corpo:
                              ' ✓ Inclusão do compoenente de filtro e quantidade da subtarefa. \n\n'
                              ' ✓ Ajuste do bug de atualização dos cards das tarefas e subtarefas.\n\n'
                              ' ✓ Ajuste do bug do web socket. \n\n'
                              ' ✓ Ajuste do bug da mensagem do botão de incluir ou editar subtarefa. \n\n'
                              ' ✓ Ajuste do tamanho inicial na tela do windows.\n\n'
                              ' ✓ Ajuste da versão no popup de atualização do windows para a versão atual e não há local. \n\n'
                              ' ✓ Ajuste do scroll das listas de tarefas na versão mobile. \n\n'
                              ' ✓ Ajuste no salvamento do users no create. \n\n',
                        ),
                        ChangeTextWidget(
                          constraint: constraint.maxWidth,
                          theme: client.theme,
                          title: 'Versão 2.3.0',
                          corpo:
                              ' ✓ Alteração do layout do dashboard com todas as fases. \n\n'
                              ' ✓ Vizualização e filtros laterais com qtd de tarefas e subtarefas.\n\n'
                              ' ✓ Ajuste nos componentes de filtro no header. \n\n'
                              ' ✓ Repaginação dos cards das tarefas com inclusão de progresso das subtarefas. \n\n'
                              ' ✓ Reformulação da aba de criação com divisão das tarefas em fases.\n\n'
                              ' ✓ Ajuste do Bug na inclusão dos funcionários na nova tarefa. \n\n'
                              ' ✓ Lista e filtro da quantidade de subtarefas no create. \n\n'
                              ' ✓ Reformulação das páginas de privacy e change log.\n\n'
                              ' ✓ Refatoração do componente do menu lateral e inclusão em todas as páginas \n\n'
                              ' ✓ Ajuste do backend para a cadeia de vinculação tanto nos totais quanto nas tarefas. \n\n'
                              ' ✓ Inclusão do componente de quantidade das subtarefas na página de criação. \n\n'
                              ' ✓ Melhora no controle de erros na criação das tarefas. \n\n'
                              ' ✓ Criação na versão linux disponível na versão 2.3.0. \n\n',
                        ),
                        ChangeTextWidget(
                          constraint: constraint.maxWidth,
                          theme: client.theme,
                          title: 'Versão 2.2.0',
                          corpo:
                              ' ✓ Alteração do layout do thead do create. \n\n'
                              ' ✓ Inclusão do atalho no create quando falta algum item obrigatório.\n\n'
                              ' ✓ Fechamento do search quando altera alguma tarefa. \n\n'
                              ' ✓ Inclusão do loading nas alterações de tarefas. \n\n'
                              ' ✓ Ajuste do bug do botão novo da subtarefa que não apagava o texto.\n\n'
                              ' ✓ Ajuste do Web Socket e do delete. \n\n'
                              ' ✓ Inclusão do loading nas alterações de tarefas. \n\n'
                              ' ✓ Aumento do tamanho do dialog para 100%.\n\n'
                              ' ✓ Fechamento do search com update e save.\n\n'
                              ' ✓ Bug da formatação do privacy.\n\n'
                              ' ✓ Ajuste do bug de envio de emails com email suporte@munatask.com. ',
                        ),
                        ChangeTextWidget(
                          constraint: constraint.maxWidth,
                          theme: client.theme,
                          title: 'Versão 2.1.8',
                          corpo:
                              ' ✓ Criação do changelog ao clicar no ícone da versão. \n\n'
                              ' ✓ Ajuste do botão incluir subtarefas nos aparelhos mais antigos.\n\n'
                              ' ✓ Ajuste do bug do popup de atualização da versão mobile. ',
                        ),
                      ]),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
