import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
import 'package:munatasks2/app/shared/utils/snackbar_custom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class DialogInputWidget extends StatefulWidget {
  final dynamic value;
  final String create;
  final Function editar;
  const DialogInputWidget(
      {Key? key, required this.value, required this.editar, this.create = ''})
      : super(key: key);

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
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: valor,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                          width: 2.0,
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
                      ? const Text(
                          "SALVAR",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      : const Text(
                          "EDITAR",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
