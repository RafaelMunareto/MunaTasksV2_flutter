import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
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
  TextEditingController valor = TextEditingController();
  final PrincipalStore store = Modular.get();

  @override
  void initState() {
    if (widget.value != '') {
      if (store.label == 'Tempo') {
        valor.text = widget.value.tempoName;
      } else {
        valor.text = widget.value;
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
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: valor,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        store.isSwitched
                            ? darkThemeData(context).primaryColor
                            : lightThemeData(context).primaryColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          side: const BorderSide(
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (widget.create == 'Novo') {
                        widget.editar(widget.value, valor.text);
                        SnackbarCustom().createSnackBar(
                            'Salvo com sucesso!', Colors.green, context);
                      } else {
                        widget.editar(valor.text, widget.value);
                        SnackbarCustom().createSnackBar(
                            'Editado com sucesso!', Colors.green, context);
                      }
                      Modular.to.pop();
                    },
                    child: widget.create == 'Novo'
                        ? Text(
                            "SALVAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.constraint >=
                                      LarguraLayoutBuilder().telaPc
                                  ? 20
                                  : 12,
                            ),
                          )
                        : Text(
                            "EDITAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.constraint >=
                                      LarguraLayoutBuilder().telaPc
                                  ? 20
                                  : 12,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
