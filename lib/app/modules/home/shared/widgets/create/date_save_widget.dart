import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

class DateSaveWidget extends StatefulWidget {
  final TextEditingController dateController;
  const DateSaveWidget({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  @override
  State<DateSaveWidget> createState() => _DateSaveWidgetState();
}

class _DateSaveWidgetState extends State<DateSaveWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    setState(() {
      try {
        widget.dateController.text =
            DateFormat('dd/MM/yyyy').format(store.clientCreate.tarefaModelData);
        store.clientCreate
            .setTarefaDateSave(store.clientCreate.tarefaModelData);
      } catch (e) {
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

    return SizedBox(
      width: kIsWeb && defaultTargetPlatform == TargetPlatform.windows
          ? MediaQuery.of(context).size.width * 0.2
          : MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        autofocus: false,
        controller: widget.dateController,
        onChanged: (value) => store.clientCreate.setTarefaDateSave(value),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
          prefixIcon: InkWell(
            child: Icon(
              Icons.calendar_today,
              color:
                  widget.dateController.text != "" ? Colors.blue : Colors.grey,
            ),
            onTap: () => _selectDate(),
          ),
        ),
      ),
    );
  }
}
