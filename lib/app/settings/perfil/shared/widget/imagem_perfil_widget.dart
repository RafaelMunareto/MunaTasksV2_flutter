import 'package:flutter/material.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_model.dart';

class ImagemPerfilWidget extends StatefulWidget {
  final bool loadingImagem;
  final PerfilModel perfil;
  final Function recuperarImagem;
  const ImagemPerfilWidget(
      {Key? key,
      required this.loadingImagem,
      required this.perfil,
      required this.recuperarImagem})
      : super(key: key);

  @override
  State<ImagemPerfilWidget> createState() => _ImagemPerfilWidgetState();
}

class _ImagemPerfilWidgetState extends State<ImagemPerfilWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: !widget.loadingImagem
              ? Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.perfil.urlImage),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 190,
                  height: 190,
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                    child: Icon(Icons.camera_alt,
                        color: ThemeData.light().primaryColor, size: 48),
                    onTap: () {
                      widget.recuperarImagem("camera");
                    })),
            Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                    child: Icon(Icons.image,
                        color: ThemeData.light().primaryColor, size: 48),
                    onTap: () {
                      widget.recuperarImagem("galeria");
                    })),
          ],
        ),
      ],
    );
  }
}
