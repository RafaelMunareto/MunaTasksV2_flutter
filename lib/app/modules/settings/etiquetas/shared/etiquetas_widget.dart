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

class _EtiquetasWidgetState extends State<EtiquetasWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                return Column(
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
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  _showDialog({EtiquetaModel? model}) {
    model ??= EtiquetaModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
                'Tem certeza que deseja excluír a etiqueta ${model!.etiqueta}'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  widget.delete(model);
                  Navigator.pop(context);
                },
                child: const Text('EXCLUIR'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCELAR'),
              ),
            ],
          );
        });
  }
}
