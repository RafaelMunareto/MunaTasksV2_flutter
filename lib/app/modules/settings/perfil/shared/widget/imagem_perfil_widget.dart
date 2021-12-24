import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_model.dart';
import 'package:munatasks2/app/shared/components/icon_redonded_widget.dart';

class ImagemPerfilWidget extends StatefulWidget {
  final bool loadingImagem;
  final Function setLoadingImagem;
  final PerfilModel perfil;
  final Function atualizarUrlImagemPerfilProfile;
  final List<UserModel> userModel;
  final Function getById;
  final bool textFieldNameBool;
  final Function changeName;
  final Function save;
  final Function showTextFieldName;
  final dynamic errorName;
  const ImagemPerfilWidget(
      {Key? key,
      required this.loadingImagem,
      required this.setLoadingImagem,
      required this.perfil,
      required this.atualizarUrlImagemPerfilProfile,
      required this.userModel,
      required this.getById,
      required this.textFieldNameBool,
      required this.changeName,
      required this.save,
      required this.errorName,
      required this.showTextFieldName})
      : super(key: key);

  @override
  State<ImagemPerfilWidget> createState() => _ImagemPerfilWidgetState();
}

class _ImagemPerfilWidgetState extends State<ImagemPerfilWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animacaoSize;
  late Animation<double> _animacaoSize2;

  popMenu() {
    return PopupMenuButton(
      icon: IconRedondedWidget(
        icon: Icons.photo_camera,
        color: ThemeData().primaryColor,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            widget.atualizarUrlImagemPerfilProfile("camera",
                widget.setLoadingImagem, widget.userModel, widget.getById);
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
            widget.atualizarUrlImagemPerfilProfile("galeria",
                widget.setLoadingImagem, widget.userModel, widget.getById)
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
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Stack(
        children: [
          if (!widget.loadingImagem)
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
                    image: NetworkImage(widget.perfil.urlImage),
                  ),
                ),
              )),
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
            child: Observer(
              builder: (_) {
                return widget.textFieldNameBool
                    ? SizedBox(
                        width: _animacaoSize.value,
                        child: Chip(
                          backgroundColor: Colors.grey[200],
                          label: SizedBox(
                              width: 180,
                              child: Text(
                                widget.perfil.name,
                                style: const TextStyle(fontSize: 18.00),
                              )),
                        ),
                      )
                    : Observer(
                        builder: (_) {
                          return SizedBox(
                            width: _animacaoSize2.value,
                            child: TextFormField(
                              style: const TextStyle(
                                  height: 1.0, fontWeight: FontWeight.bold),
                              initialValue: widget.perfil.name,
                              onChanged: (value) {
                                widget.changeName(value);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                errorText: widget.errorName == null
                                    ? null
                                    : widget.errorName(),
                              ),
                            ),
                          );
                        },
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
                    widget.showTextFieldName(!widget.textFieldNameBool &&
                        widget.perfil.name.isNotEmpty &&
                        widget.perfil.name.length >= 3);
                    if (!widget.textFieldNameBool &&
                        widget.perfil.name.isNotEmpty &&
                        widget.perfil.name.length >= 3) {
                      _controller.forward();
                      _controller2.reverse();
                      widget.save();
                    } else {
                      _controller2.forward();
                      _controller.reverse();
                    }
                  });
                },
                child: Observer(
                  builder: (_) {
                    return Icon(
                      widget.textFieldNameBool
                          ? Icons.drive_file_rename_outline
                          : widget.perfil.name.isNotEmpty &&
                                  widget.perfil.name.length >= 3
                              ? Icons.task_alt
                              : Icons.task_alt,
                      color: ThemeData.light().primaryColor,
                    );
                  },
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
  }
}
