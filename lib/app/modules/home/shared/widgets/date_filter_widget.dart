import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/components/button_widget.dart';

class DateFilterWidget extends StatefulWidget {
  const DateFilterWidget({Key? key}) : super(key: key);

  @override
  State<DateFilterWidget> createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  TextEditingController dateInicial = TextEditingController();
  TextEditingController dateFinal = TextEditingController();
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (store.client.dateInicial != '') {
        dateInicial.text =
            DateFormat('dd/MM/yyyy').format(store.client.dateInicial);
        store.client.setDateInicial(store.client.dateInicial);
      } else {
        dateInicial.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
        store.client.setDateInicial(DateTime.now());
      }
      if (store.client.dateFinal != '') {
        dateFinal.text =
            DateFormat('dd/MM/yyyy').format(store.client.dateFinal);
        store.client.setDateFinal(store.client.dateFinal);
      } else {
        dateFinal.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
        store.client.setDateFinal(DateTime.now());
      }
    });

    void _selectDateInitial() async {
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
          store.client.setDateInicial(newDate);
          dateInicial.text = dateFormat;
          FocusScope.of(context).unfocus();
        });
      }
    }

    void _selectDateFinal() async {
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
          store.client.setDateFinal(newDate);
          dateFinal.text = dateFormat;
          FocusScope.of(context).unfocus();
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: AutoSizeText(
                  'DATA INICIAL',
                  maxLines: 1,
                ),
              ),
              title: TextField(
                textAlign: TextAlign.justify,
                autofocus: false,
                controller: dateInicial,
                onChanged: (value) => store.client.setDateInicial(value),
                onTap: () => _selectDateInitial(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(18),
                  prefixIcon: InkWell(
                    child: Icon(
                      Icons.calendar_today,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: 17.0),
                child: AutoSizeText(
                  'DATA FINAL',
                  maxLines: 1,
                ),
              ),
              title: TextField(
                textAlign: TextAlign.justify,
                autofocus: false,
                controller: dateFinal,
                onTap: () => _selectDateFinal(),
                onChanged: (value) => store.client.setDateFinal(value),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(18),
                  prefixIcon: InkWell(
                    child: Icon(
                      Icons.calendar_today,
                    ),
                  ),
                ),
              ),
            ),
            ButtonWidget(
              theme: store.client.theme,
              label: 'FILTRAR DATA',
              function: () {
                store.filterDate();
                store.client.setFilterDate(true);
                Modular.to.pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
