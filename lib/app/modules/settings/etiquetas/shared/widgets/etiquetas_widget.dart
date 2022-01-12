import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/settings/etiquetas/shared/models/etiqueta_model.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class EtiquetasWidget extends StatefulWidget {
  final dynamic etiquetasList;
  final Function getList;
  final Function delete;
  final Function loadingUpdate;
  const EtiquetasWidget(
      {Key? key,
      required this.etiquetasList,
      required this.getList,
      required this.delete,
      required this.loadingUpdate})
      : super(key: key);

  @override
  State<EtiquetasWidget> createState() => _EtiquetasWidgetState();
}

class _EtiquetasWidgetState extends State<EtiquetasWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacidade;

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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Observer(
          builder: (_) {
            if (widget.etiquetasList.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (widget.etiquetasList.hasError) {
              return Center(
                child: ElevatedButton(
                  onPressed: widget.getList(),
                  child: const Text('Error'),
                ),
              );
            } else {
              List<EtiquetaModel> list = widget.etiquetasList.data;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  var model = list[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.loadingUpdate(model);
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
                                color: ConvertIcon().convertColor(model.color),
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
            }
          },
        ),
      ),
    );
  }

  _showDialog({EtiquetaModel? model}) {
    model ??= EtiquetaModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Excluir etiqueta.',
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            content: Text(
                'Tem certeza que deseja excluír a etiqueta ${model!.etiqueta} ?'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Colors.deepPurple,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  widget.delete(model);
                  Navigator.pop(context);
                },
                child: const Text(
                  'EXCLUIR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
