import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/controller/client_store.dart';
import 'package:munatasks2/app/shared/components/icon_redonded_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
//import 'package:image_cropper_for_web/image_cropper_for_web.dart';

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
  final ImagePicker picker = ImagePicker();
  CroppedFile? imageFile;

  List<PlatformUiSettings>? buildUiSettings(BuildContext context) {
    return [
      // WebUiSettings(
      //   context: context,
      //   presentStyle: CropperPresentStyle.dialog,
      //   boundary: Boundary(
      //     width: 330,
      //     height: 330,
      //   ),
      //   viewPort: ViewPort(width: 280, height: 280, type: 'circle'),
      //   enableExif: false,
      //   enableZoom: true,
      //   showZoomer: true,
      //   mouseWheelZoom: true,
      //   enforceBoundary: false,
      // ),
      AndroidUiSettings(
          toolbarTitle: 'Recortar',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Recortar',
      ),
    ];
  }

  _getFromGallery() async {
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile);
  }

  _getFromCamera() async {
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile);
  }

  _cropImage(filePath) async {
    if (filePath != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath.path!,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: buildUiSettings(context),
      );
      if (croppedFile != null) {
        setState(() {
          store.atualizaImagem(croppedFile);
        });
      }
    }
  }

  popMenu() {
    return PopupMenuButton(
      icon: IconRedondedWidget(
        icon: Icons.photo_camera,
        color: store.client.theme
            ? darkThemeData(context).primaryColor
            : lightThemeData(context).primaryColor,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => _getFromCamera(),
          child: SizedBox(
            width: double.infinity,
            child: ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: store.client.theme
                    ? darkThemeData(context).primaryColor
                    : lightThemeData(context).primaryColor,
              ),
              title: const Text(
                'Camera',
                maxLines: 1,
              ),
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => _getFromGallery(),
          child: SizedBox(
            width: double.infinity,
            child: ListTile(
              leading: Icon(
                Icons.image,
                color: store.client.theme
                    ? darkThemeData(context).primaryColor
                    : lightThemeData(context).primaryColor,
              ),
              title: const Text(
                'Galeria',
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  popMenuDesktop() {
    return PopupMenuButton(
      icon: IconRedondedWidget(
        icon: Icons.image,
        color: store.client.theme
            ? darkThemeData(context).primaryColor
            : lightThemeData(context).primaryColor,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => _getFromGallery(),
          child: ListTile(
            leading: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.image,
                color: store.client.theme
                    ? darkThemeData(context).primaryColor
                    : lightThemeData(context).primaryColor,
              ),
            ),
            title: const Text(
              'Galeria',
              maxLines: 1,
            ),
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
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16, 8, 8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 210,
          child: Stack(
            children: [
              if (client.perfilDio.id != '')
                Positioned(
                  top: 0,
                  left: 30,
                  child: Center(
                    child: Observer(builder: (_) {
                      return store.client.loadingImagem
                          ? const CircularProgressWidget()
                          : Container(
                              width: 170.0,
                              height: 170.0,
                              decoration: store.client.perfilDio.urlImage != ''
                                  ? BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: CachedNetworkImageProvider(
                                          store.client.perfilDio.urlImage,
                                        ),
                                      ),
                                    )
                                  : const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage('assets/img/person.png'),
                                      ),
                                    ),
                            );
                    }),
                  ),
                )
              else
                const Positioned(
                  left: 90,
                  top: 50,
                  child: CircularProgressWidget(),
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        client.textFieldNameBool
                            ? Icons.drive_file_rename_outline
                            : client.perfilDio.name.name.isNotEmpty &&
                                    client.perfilDio.name.name.length >= 3
                                ? Icons.task_alt
                                : Icons.task_alt,
                        color: store.client.theme
                            ? darkThemeData(context).primaryColor
                            : lightThemeData(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 165,
                child: GestureDetector(
                  child:
                      kIsWeb || defaultTargetPlatform == TargetPlatform.windows
                          ? popMenuDesktop()
                          : popMenu(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
