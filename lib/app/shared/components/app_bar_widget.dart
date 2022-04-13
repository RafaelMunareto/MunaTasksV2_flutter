import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:simple_animations/simple_animations.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final double size;
  final dynamic context;
  final IconData icon;
  final bool settings;
  final bool back;
  final String rota;
  final dynamic tarefas;
  final bool home;
  final dynamic zoomController;
  final Function? setOpen;
  final int etiquetaSelection;
  final Function? setEtiquetaSelection;
  final dynamic etiquetaList;
  final Function? setValueSearch;
  final Function? changeFilterSearch;
  AppBarWidget({
    Key? key,
    this.title = "",
    this.size = 75,
    this.context,
    this.home = false,
    this.icon = Icons.person,
    this.settings = false,
    this.back = true,
    this.setOpen,
    this.zoomController,
    this.etiquetaSelection = 57585,
    this.setEtiquetaSelection,
    this.etiquetaList,
    this.tarefas,
    this.rota = '/auth',
    this.setValueSearch,
    this.changeFilterSearch,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(size);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool search = false;
  PerfilDioModel perfil = PerfilDioModel();
  AuthRepository auth = AuthRepository();
  UserDioClientModel user = UserDioClientModel();

  getPerfil() async {
    await auth.getUser().then((e) {
      user = e;
    });

    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/${user.id}');
    DioStruture().statusRequest(response);
    setState(() {
      perfil = PerfilDioModel.fromJson(response.data[0]);
    });
  }

  @override
  void initState() {
    getPerfil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.size),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/fundo_app_bar.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          widget.settings && !widget.home
              ? _popMenu()
              : GestureDetector(
                  child: Padding(
                    padding: kIsWeb &&
                            defaultTargetPlatform == TargetPlatform.windows
                        ? const EdgeInsets.only(right: 48.0)
                        : const EdgeInsets.only(right: 12.0),
                    child: !search
                        ? Icon(
                            Icons.search,
                            color: Colors.white,
                            size: kIsWeb &&
                                    defaultTargetPlatform ==
                                        TargetPlatform.windows
                                ? 48
                                : 24,
                          )
                        : const Icon(Icons.close, color: Colors.white),
                  ),
                  onTap: () {
                    setState(() {
                      search = !search;
                    });
                    if (search == false) {
                      setState(() {
                        widget.setValueSearch!('');
                      });
                      widget.changeFilterSearch!();
                    }
                  })
        ],
        title: !widget.home
            ? RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(widget.icon),
                    ),
                    TextSpan(
                      text: ' ' + widget.title.toUpperCase(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              )
            : search
                ? _popSearch()
                : Container(),
        leading: widget.back
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Modular.to.navigate(widget.rota))
            : InkWell(
                onTap: () {
                  widget.zoomController.toggle!();
                  widget.setOpen!(
                      widget.zoomController.stateNotifier.value.toString() ==
                              'DrawerState.opening'
                          ? true
                          : false);
                },
                child: kIsWeb && defaultTargetPlatform == TargetPlatform.windows
                    ? Container()
                    : const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
              ),
      ),
    );
  }

  _popMenu() {
    return PopupMenuButton(
      icon: Padding(
        padding: kIsWeb && defaultTargetPlatform == TargetPlatform.windows
            ? const EdgeInsets.only(right: 48.0)
            : const EdgeInsets.only(right: 12.0),
        child: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: perfil.urlImage != ''
              ? InputChip(
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(perfil.urlImage ?? ''),
                  ),
                  label: Text(perfil.name.name),
                )
              : Container(),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => Modular.to.navigate('/settings/'),
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: lightThemeData(context).primaryColor,
            ),
            title: const Text('Configurações'),
          ),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => Modular.to.navigate('/settings/perfil'),
          child: ListTile(
            leading: Icon(Icons.account_circle,
                color: lightThemeData(context).primaryColor),
            title: const Text('Perfil e Equipes'),
          ),
        ),
      ],
    );
  }

  _popSearch() {
    return PlayAnimation<double>(
      tween: Tween(begin: 0.1, end: MediaQuery.of(context).size.width),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
      builder: (context, child, value) {
        return Container(
          width: value,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                widget.setValueSearch!(value);
              });
              widget.changeFilterSearch!();
            },
            style: const TextStyle(color: Colors.white, fontSize: 12),
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            autofocus: true,
          ),
        );
      },
    );
  }
}
