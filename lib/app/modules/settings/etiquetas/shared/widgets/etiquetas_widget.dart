import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/etiquetas_store.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_dio_model.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card/tarefas_none_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';

class EtiquetasWidget extends StatefulWidget {
  const EtiquetasWidget({Key? key}) : super(key: key);

  @override
  State<EtiquetasWidget> createState() => _EtiquetasWidgetState();
}

class _EtiquetasWidgetState extends State<EtiquetasWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacidade;
  final EtiquetasStore store = Modular.get();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1400), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    opacidade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)));

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
      opacity: opacidade,
      child: store.etiquetaStore.etiquetaDio.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: TarefasNoneWidget(
                theme: store.etiquetaStore.theme,
                title: "Não há nenhuma etiqueta!",
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Observer(builder: (_) {
                return ListView.builder(
                  itemCount: store.etiquetaStore.etiquetaDio.length,
                  itemBuilder: (_, index) {
                    var model = store.etiquetaStore.etiquetaDio[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              store.loadingUpdate(model);
                            },
                            child: ListTile(
                              leading: Icon(
                                IconData(model.icon ?? 0,
                                    fontFamily: 'MaterialIcons'),
                                color: ConvertIcon().convertColor(model.color),
                              ),
                              title: Text(
                                model.etiqueta,
                                style: TextStyle(
                                  color:
                                      ConvertIcon().convertColor(model.color),
                                ),
                              ),
                              trailing: GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  _showDialog(model: model);
                                },
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                );
              })),
    );
  }

  _showDialog({EtiquetaDioModel? model}) {
    model ??= EtiquetaDioModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Excluir etiqueta.',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 140, 82, 241)),
            ),
            content: Text(
                'Tem certeza que deseja excluír a etiqueta ${model!.etiqueta} ?'),
            actions: [
              SimpleButtonWidget(
                theme: store.etiquetaStore.theme,
                buttonName: 'CANCELAR',
                popUp: true,
              ),
              SimpleButtonWidget(
                theme: store.etiquetaStore.theme,
                buttonName: 'EXCLUIR',
                popUp: true,
                function: store.deleteDio,
                dataFunction: model,
                scnack: true,
                msgSnack: 'Deletado com sucesso!',
              ),
            ],
          );
        });
  }
}
