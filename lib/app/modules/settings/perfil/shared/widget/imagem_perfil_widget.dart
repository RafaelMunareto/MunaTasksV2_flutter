import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/components/icon_redonded_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class ImagemPerfilWidget extends StatefulWidget {
  final dynamic errorName;
  const ImagemPerfilWidget({
    Key? key,
    required this.errorName,
  }) : super(key: key);

  @override
  State<ImagemPerfilWidget> createState() => _ImagemPerfilWidgetState();
}

class _ImagemPerfilWidgetState extends State<ImagemPerfilWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animacaoSize;
  late Animation<double> _animacaoSize2;
  final ClientStore client = Modular.get();
  final PerfilStore store = Modular.get();

  popMenu() {
    return PopupMenuButton(
      icon: IconRedondedWidget(
        icon: Icons.photo_camera,
        color: lightThemeData(context).primaryColor,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            store.imageRepository.atualizarUrlImagemPerfilProfile(
              "camera",
              client.perfilDio.id,
              client.setLoadingImagem,
            );
          },
          child: const ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => {
            store.imageRepository.atualizarUrlImagemPerfilProfile(
              "galeria",
              client.perfilDio.id,
              client.setLoadingImagem,
            )
          },
          child: const ListTile(
            leading: Icon(Icons.image),
            title: Text('Galeria'),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller2 =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animacaoSize = Tween<double>(begin: 0, end: 250).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _animacaoSize2 = Tween<double>(begin: 0, end: 220).animate(
        CurvedAnimation(parent: _controller2, curve: Curves.decelerate));

    return AnimatedBuilder(animation: _animacaoSize, builder: _buildAnimation);
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Observer(builder: (_) {
      return SizedBox(
        width: double.infinity,
        height: 210,
        child: Stack(
          children: [
            if (client.perfilDio.urlImage != "")
              Positioned(
                top: 0,
                left: 30,
                child: Center(
                  child: Container(
                    width: 170.0,
                    height: 170.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(client.perfilDio.urlImage),
                      ),
                    ),
                  ),
                ),
              )
            else
              const Positioned(
                left: 90,
                top: 50,
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            Positioned(
              top: 125,
              left: 90,
              child: client.textFieldNameBool
                  ? SizedBox(
                      width: _animacaoSize.value,
                      child: Chip(
                        label: SizedBox(
                            width: 180,
                            child: Text(
                              client.perfilDio.name != ""
                                  ? client.perfilDio.name.name
                                  : "",
                              style: const TextStyle(fontSize: 18.00),
                            )),
                      ),
                    )
                  : Observer(
                      builder: (_) {
                        return SizedBox(
                          width: _animacaoSize2.value,
                          child: TextFormField(
                            style: const TextStyle(shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 3.0,
                                color: Colors.white,
                              ),
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 8.0,
                                color: Colors.white,
                              ),
                            ], height: 1.0, fontWeight: FontWeight.bold),
                            initialValue: client.perfilDio.name.name,
                            onChanged: (value) {
                              client.changeName(value);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              errorText: widget.errorName == null
                                  ? null
                                  : widget.errorName(),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Positioned(
              top: 135,
              left: 320,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      client.showTextFieldName(!client.textFieldNameBool &&
                          client.perfilDio.name.name.length >= 3);
                      if (client.textFieldNameBool &&
                          client.perfilDio.name.name.length >= 3) {
                        _controller.forward();
                        _controller2.reverse();
                        store.saveName();
                      } else {
                        _controller2.forward();
                        _controller.reverse();
                      }
                    });
                  },
                  child: Icon(
                    client.textFieldNameBool
                        ? Icons.drive_file_rename_outline
                        : client.perfilDio.name.name.isNotEmpty &&
                                client.perfilDio.name.name.length >= 3
                            ? Icons.task_alt
                            : Icons.task_alt,
                    color: lightThemeData(context).primaryColor,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 165,
              child: GestureDetector(child: popMenu()),
            ),
          ],
        ),
      );
    });
  }
}
