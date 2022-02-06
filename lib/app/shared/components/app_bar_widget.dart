import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
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
  final String etiquetaSelection;
  final Function? setEtiquetaSelection;
  final dynamic etiquetaList;
  final Function? setValueSearch;
  final Function? changeFilterSearch;
  AppBarWidget({
    Key? key,
    this.title = "",
    this.size = 115,
    this.context,
    this.home = false,
    this.icon = Icons.person,
    this.settings = false,
    this.back = true,
    this.setOpen,
    this.zoomController,
    this.etiquetaSelection = '',
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
  final AuthController auth = Modular.get();
  bool search = false;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.size),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/fundo_app_bar.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          widget.settings && !widget.home
              ? _popMenu()
              : GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: !search
                        ? const Icon(Icons.search, color: Colors.white)
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
                child: const Icon(Icons.menu),
              ),
      ),
    );
  }

  _popMenu() {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: auth.user!.photoURL != ''
              ? InputChip(
                  avatar: CircleAvatar(
                    backgroundImage:
                        NetworkImage(auth.user!.photoURL.toString()),
                  ),
                  label: Text(auth.user!.displayName.toString()),
                )
              : Container(),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => Modular.to.navigate('/settings'),
          child: const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
          ),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => Modular.to.navigate('/settings/perfil'),
          child: const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfil e Equipes'),
          ),
        ),
      ],
    );
  }

  _popSearch() {
    return PlayAnimation<double>(
      tween: Tween(begin: 0.1, end: MediaQuery.of(context).size.width),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
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
