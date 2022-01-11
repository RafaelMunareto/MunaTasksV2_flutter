import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';

class IconWidget extends StatefulWidget {
  final Function setIcon;
  final dynamic icon;
  final String color;
  const IconWidget({Key? key, required this.setIcon, required this.icon, required this.color}) : super(key: key);

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  Icon? _icon;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      title: const Text('Escolha um ícone'),
      searchHintText: 'Pesquisar',
      closeChild: const Text('Fechar',textScaleFactor: 1.25,)
      iconPackModes: [IconPack.material],
    );
    setState(() {
      if(icon != null){
        widget.setIcon(icon.codePoint);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Escolha uma ícone'),
              ),
              onTap: _pickIcon,
            ),
            const SizedBox(height: 10),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Icon(
                    IconData(widget.icon ?? 0,
                        fontFamily: 'MaterialIcons'),
                    size: 48,
                    color: ConvertIcon()
                        .convertColor(widget.color)),
              ),
          ],
        ),
      ),
    );
  }
}