import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/date_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/radio_order_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/filters/teams_selection_widget.dart';
import 'package:munatasks2/app/modules/settings/perfil/shared/model/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/components/pop_search_widget.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final double size;
  final dynamic context;
  final IconData? icon;
  final bool settings;
  final bool back;
  final String rota;
  final bool home;
  final bool? loadingItens;
  final dynamic zoomController;
  final Function? setOpen;
  final dynamic etiquetaList;
  final Function? setValueSearch;
  final Function? changeFilterSearch;
  final Function? getDioFase;
  final Function? getPass;
  final dynamic client;
  final bool? closeSearch;
  final Function? setCloseSearch;

  AppBarWidget(
      {Key? key,
      this.title = "",
      this.size = 55,
      this.context,
      this.home = false,
      this.icon = Icons.person,
      this.settings = false,
      this.back = true,
      this.setOpen,
      this.loadingItens,
      this.zoomController,
      this.etiquetaList,
      this.rota = '/auth',
      this.setValueSearch,
      this.changeFilterSearch,
      this.getDioFase,
      this.getPass,
      this.client,
      this.closeSearch,
      this.setCloseSearch})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(size);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  PerfilDioModel perfil = PerfilDioModel();
  AuthRepository auth = AuthRepository();
  ILocalStorage storage = LocalStorageShare();
  UserDioClientModel user = UserDioClientModel();

  getPerfil() async {
    await auth.getUser().then((e) {
      user = e;
    });

    Response response;
    var dio = await DioStruture().dioAction();
    response = await dio.get('perfil/user/${user.id}');
    DioStruture().statusRequest(response);
    perfil = response.data.isNotEmpty
        ? PerfilDioModel.fromJson(response.data[0])
        : PerfilDioModel();
  }

  @override
  void initState() {
    getPerfil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return AppBar(
        title: !widget.home
            ? Wrap(
                children: [
                  Icon(widget.icon),
                  Text(
                    ' ' + widget.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icon/icon.png'),
                          opacity: 0.1,
                        ),
                      ),
                    ),
                    PopSearchWidget(
                      constraint: constraint.maxWidth,
                      setValueSearch: widget.setValueSearch,
                      changeFilterSearch: widget.changeFilterSearch,
                    ),
                    if (widget.loadingItens != null)
                      widget.loadingItens!
                          ? const Center(
                              child: SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox(
                              width: 22,
                              height: 22,
                            ),
                    Tooltip(
                      message: "Filtra Etiquetas",
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Observer(builder: (_) {
                          return GestureDetector(
                            child: widget.client.icon != 0
                                ? Icon(
                                    IconData(widget.client.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: ConvertIcon()
                                        .convertColor(widget.client.color),
                                  )
                                : const Icon(
                                    Icons.bookmark,
                                  ),
                            onTap: () {
                              DialogButtom().showDialog(
                                const RadioEtiquetasFilterWidget(),
                                widget.client.theme,
                                constraint.maxWidth,
                                context,
                              );
                            },
                          );
                        }),
                      ),
                    ),
                    Tooltip(
                      message: "Faz o ordenamento.",
                      child: GestureDetector(
                        child: const MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Icon(
                            Icons.filter_alt,
                          ),
                        ),
                        onTap: () => DialogButtom().showDialog(
                          const RadioOrderWidget(),
                          widget.client.theme,
                          constraint.maxWidth,
                          context,
                          width: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                    ),
                    Tooltip(
                      message: "Faz filtro de datas.",
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Observer(
                            builder: (_) {
                              return GestureDetector(
                                  child: Icon(
                                    widget.client.filterDate
                                        ? Icons.history
                                        : Icons.timelapse,
                                    color: widget.client.filterDate
                                        ? Colors.red
                                        : widget.client.theme
                                            ? darkThemeData(context)
                                                .iconTheme
                                                .color
                                            : lightThemeData(context)
                                                .iconTheme
                                                .color,
                                  ),
                                  onTap: () {
                                    if (!widget.client.filterDate) {
                                      DialogButtom().showDialog(
                                        const DateFilterWidget(),
                                        widget.client.theme,
                                        constraint.maxWidth,
                                        context,
                                      );
                                    } else {
                                      widget.client.setFilterDate(false);
                                      widget.getDioFase!();
                                    }
                                  });
                            },
                          )),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Observer(
                          builder: (_) {
                            return widget.client.userSelection == null ||
                                    widget.client.userSelection.name!.name ==
                                        'TODOS'
                                ? const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(
                                      Icons.people,
                                    ),
                                  )
                                : CircleAvatarWidget(
                                    nameUser:
                                        widget.client.userSelection.name!.name,
                                    url: widget.client.imgUrl,
                                  );
                          },
                        ),
                        onTap: () {
                          if (widget.client.perfilUserLogado.manager) {
                            DialogButtom().showDialog(
                              const TeamsSelectionWidget(),
                              widget.client.theme,
                              constraint.maxWidth,
                              context,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }
}
