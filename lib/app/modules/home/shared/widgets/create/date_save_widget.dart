import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class DateSaveWidget extends StatefulWidget {
  final TextEditingController dateController;
  final double constraint;
  const DateSaveWidget({
    Key? key,
    required this.dateController,
    required this.constraint,
  }) : super(key: key);

  @override
  State<DateSaveWidget> createState() => _DateSaveWidgetState();
}

class _DateSaveWidgetState extends State<DateSaveWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (store.clientCreate.tarefaModelData != '') {
        widget.dateController.text =
            DateFormat('dd/MM/yyyy').format(store.clientCreate.tarefaModelData);
        store.clientCreate
            .setTarefaDateSave(store.clientCreate.tarefaModelData);
      } else {
        widget.dateController.text =
            DateFormat('dd/MM/yyyy').format(DateTime.now());
        store.clientCreate.setTarefaDateSave(DateTime.now());
      }
    });

    void _selectDate() async {
      final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        helpText: 'Selecione uma data',
      );
      if (newDate != null) {
        var dateFormat = DateFormat('dd/MM/yyyy').format(newDate);
        setState(() {
          store.clientCreate.setTarefaDateSave(newDate);
          widget.dateController.text = dateFormat;
          FocusScope.of(context).unfocus();
        });
      }
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: TextField(
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize:
                widget.constraint < LarguraLayoutBuilder().telaPc ? 14 : 16),
        autofocus: false,
        controller: widget.dateController,
        onChanged: (value) => store.clientCreate.setTarefaDateSave(value),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: InkWell(
            child: Icon(Icons.calendar_today,
                color: store.client.theme
                    ? darkThemeData(context).primaryColor
                    : lightThemeData(context).primaryColor),
            onTap: () => _selectDate(),
          ),
        ),
      ),
    );
  }
}
