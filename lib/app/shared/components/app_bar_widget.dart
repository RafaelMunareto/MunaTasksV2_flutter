import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double size;
  final dynamic context;
  final dynamic controller;
  final IconData icon;
  final dynamic user;
  final bool settings;
  final bool back;
  final String rota;

  AppBarWidget(
      {Key? key,
      this.title = "",
      this.size = 125,
      this.context,
      this.controller,
      this.icon = Icons.person,
      this.user = '',
      this.settings = false,
      this.back = true,
      this.rota = '/auth'})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(size);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/fundo_app_bar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [settings ? _popMenu() : Container()],
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(icon, size: 24),
              ),
              TextSpan(
                  text: ' ' + title.toUpperCase(),
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
        leading: back
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Modular.to.navigate(rota))
            : Container(),
      ),
    );
  }

  _popMenu() {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: user != ''
              ? InputChip(
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL.toString()),
                  ),
                  label: Text(user.displayName),
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
            title: Text('Perfil'),
          ),
        ),
      ],
    );
  }
}
