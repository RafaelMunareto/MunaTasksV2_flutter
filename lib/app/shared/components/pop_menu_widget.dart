import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class PopMenuWidget extends StatelessWidget {
  final double constraint;
  final PerfilDioModel perfil;
  const PopMenuWidget({
    Key? key,
    required this.constraint,
    required this.perfil,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: perfil.urlImage != ''
              ? InputChip(
                  avatar: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(perfil.urlImage ?? ''),
                  ),
                  label: Text(
                    perfil.name.name,
                    maxLines: 1,
                  ),
                )
              : Container(),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => Modular.to.navigate('/settings/'),
          child: ListTile(
            leading: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.settings,
                color: lightThemeData(context).iconTheme.color,
              ),
            ),
            title: const MouseRegion(
                cursor: SystemMouseCursors.click, child: Text('Configurações')),
          ),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => Modular.to.navigate('/settings/perfil'),
          child: ListTile(
            leading: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.account_circle,
                color: lightThemeData(context).iconTheme.color,
              ),
            ),
            title: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'Perfil e Equipes',
                  maxLines: 1,
                )),
          ),
        ),
        PopupMenuItem(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => Modular.to.navigate('/home/tarefas'),
          child: constraint < 1280
              ? ListTile(
                  leading: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(
                      Icons.account_circle,
                      color: lightThemeData(context).iconTheme.color,
                    ),
                  ),
                  title: const MouseRegion(
                      cursor: SystemMouseCursors.click, child: Text('Tarefas')),
                )
              : null,
        ),
      ],
    );
  }
}
