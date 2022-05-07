import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/shared/components/text_field_widget.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class DialogInputWidget extends StatefulWidget {
  final dynamic value;
  final String create;
  final Function editar;
  final double constraint;
  const DialogInputWidget({
    Key? key,
    required this.value,
    required this.editar,
    this.create = '',
    required this.constraint,
  }) : super(key: key);

  @override
  State<DialogInputWidget> createState() => _DialogInputWidgetState();
}

class _DialogInputWidgetState extends State<DialogInputWidget> {
  final PrincipalStore store = Modular.get();

  @override
  void initState() {
    if (widget.value != '') {
      if (store.client.label == 'Tempo') {
        store.client.setValueEscolha(widget.value.tempoName);
      } else {
        store.client.setValueEscolha(widget.value);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Wrap(
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Observer(builder: (_) {
                      return TextFieldWidget(
                        outline: true,
                        initialValue: store.client.valueEscolha,
                        errorText: store.client.validTextoTarefa,
                        onChanged: store.client.setValueEscolha,
                        labelText: store.client.label,
                      );
                    }),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Observer(builder: (_) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          store.client.isValidTarefa
                              ? store.client.isSwitched
                                  ? darkThemeData(context).primaryColor
                                  : lightThemeData(context).primaryColor
                              : Colors.grey,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (store.client.isValidTarefa) {
                          if (widget.create == 'Novo') {
                            widget.editar(
                                widget.value, store.client.valueEscolha);
                            SnackbarCustom().createSnackBar(
                                'Salvo com sucesso!', Colors.green, context);
                          } else {
                            widget.editar(
                                store.client.valueEscolha, widget.value);
                            SnackbarCustom().createSnackBar(
                                'Editado com sucesso!', Colors.green, context);
                          }
                          Modular.to.pop();
                        } else {
                          null;
                        }
                      },
                      child: widget.create == 'Novo'
                          ? Text(
                              "SALVAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.constraint >
                                        LarguraLayoutBuilder().larguraModal
                                    ? 20
                                    : 12,
                              ),
                            )
                          : Text(
                              "EDITAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.constraint >
                                        LarguraLayoutBuilder().larguraModal
                                    ? 20
                                    : 12,
                              ),
                            ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
