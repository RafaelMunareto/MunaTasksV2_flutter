import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class CreateUserSubtarefaWidget extends StatefulWidget {
  final bool subtarefa;
  const CreateUserSubtarefaWidget({
    Key? key,
    required this.subtarefa,
  }) : super(key: key);

  @override
  State<CreateUserSubtarefaWidget> createState() =>
      _CreateUserSubtarefaWidgetState();
}

class _CreateUserSubtarefaWidgetState extends State<CreateUserSubtarefaWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacaoOpacity;
  final HomeStore store = Modular.get();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animacaoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.9),
      ),
    );
    _controller.forward();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: _buildAnimation,
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: _animacaoOpacity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Observer(
            builder: (_) {
              if (store.client.perfis.isEmpty) {
                return const Center(
                  child: CircularProgressWidget(),
                );
              } else {
                List<PerfilDioModel> list = store.client.perfis;
                list.removeWhere((e) => e.name.name == 'TODOS');
                store.clientCreate
                    .setIndividualChip([store.clientCreate.createUser]);

                return LayoutBuilder(builder: (context, constraint) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 8,
                            child: SingleChildScrollView(
                              child: Wrap(
                                runAlignment: WrapAlignment.spaceAround,
                                spacing: 24,
                                children: [
                                  for (var linha in list)
                                    Padding(
                                      padding: constraint.maxWidth >
                                              LarguraLayoutBuilder()
                                                  .larguraModal
                                          ? const EdgeInsets.only(bottom: 16.0)
                                          : const EdgeInsets.only(bottom: 16.0),
                                      child: InputChip(
                                        key: ObjectKey(linha.id),
                                        labelPadding: const EdgeInsets.all(2),
                                        elevation: 4.0,
                                        selected: store
                                            .clientCreate.individualChip
                                            .where((a) => a.id == linha.id)
                                            .isNotEmpty,
                                        avatar: CircleAvatarWidget(
                                          nameUser: '',
                                          url: linha.urlImage,
                                        ),
                                        label: SizedBox(
                                          width: 100,
                                          child: Text(
                                            linha.name.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue.shade700),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (widget.subtarefa) {
                                            store.clientCreate
                                                .setUserCreateSelection(linha);
                                            store.clientCreate
                                                .setCreateImageUser(
                                                    linha.urlImage);
                                            store.clientCreate
                                                .setIdReferenceStaff(
                                              linha,
                                            );
                                          } else {
                                            store.clientCreate
                                                .setIdReferenceStaff(linha);
                                            store.clientCreate
                                                .setLoadingUser(false);
                                          }
                                          FocusScope.of(context).unfocus();
                                          Modular.to.pop();
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              onPressed: () {
                                Modular.to.pop();
                              },
                              child: const AutoSizeText(
                                'FECHAR',
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
