import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/date_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_order_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/teams_selection_widget.dart';
import 'package:munatasks2/app/modules/settings/perfil/models/perfil_dio_model.dart';
import 'package:munatasks2/app/shared/auth/model/user_dio_client.model.dart';
import 'package:munatasks2/app/shared/auth/repositories/auth_repository.dart';
import 'package:munatasks2/app/shared/components/pop_menu_widget.dart';
import 'package:munatasks2/app/shared/components/pop_search_widget.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:munatasks2/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final double size;
  final dynamic context;
  final IconData? icon;
  final bool settings;
  final bool back;
  final String rota;
  final dynamic tarefas;
  final bool home;
  final dynamic zoomController;
  final Function? setOpen;
  final dynamic etiquetaList;
  final Function? setValueSearch;
  final Function? changeFilterSearch;
  final Function? getDioFase;
  final dynamic client;
  AppBarWidget({
    Key? key,
    this.title = "",
    this.size = 55,
    this.context,
    this.home = false,
    this.icon = Icons.person,
    this.settings = false,
    this.back = true,
    this.setOpen,
    this.zoomController,
    this.etiquetaList,
    this.tarefas,
    this.rota = '/auth',
    this.setValueSearch,
    this.changeFilterSearch,
    this.getDioFase,
    this.client,
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
    return LayoutBuilder(builder: (context, constraint) {
      return AppBar(
        actions: [
          !widget.home
              ? PopMenuWidget(constraint: constraint.maxWidth, perfil: perfil)
              : GestureDetector(
                  child: !search
                      ? MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Icon(
                            Icons.search,
                            size: constraint.maxWidth >=
                                    LarguraLayoutBuilder().telaPc
                                ? 36
                                : 24,
                          ),
                        )
                      : const MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Icon(
                            Icons.close,
                          ),
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
            ? Wrap(
                children: [
                  Icon(widget.icon),
                  Text(
                    ' ' + widget.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: lightThemeData(context).iconTheme.color,
                    ),
                  ),
                ],
              )
            : search && widget.home
                ? PopSearchWidget(
                    setValueSearch: widget.setValueSearch,
                    changeFilterSearch: widget.changeFilterSearch)
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: widget.client.icon != 0
                                  ? Icon(
                                      IconData(widget.client.icon,
                                          fontFamily: 'MaterialIcons'),
                                      color: ConvertIcon()
                                          .convertColor(widget.client.color),
                                    )
                                  : Icon(
                                      Icons.bookmark,
                                      color: widget.client.theme
                                          ? darkThemeData(context)
                                              .iconTheme
                                              .color
                                          : lightThemeData(context)
                                              .iconTheme
                                              .color,
                                    ),
                              onTap: () {
                                DialogButtom().showDialog(
                                  const RadioEtiquetasFilterWidget(),
                                  widget.client.theme,
                                  constraint.maxWidth,
                                  context,
                                );
                              },
                            ),
                          ),
                          title: GestureDetector(
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(
                                      Icons.filter_alt,
                                    ),
                                  ),
                                  constraint.maxWidth >=
                                          LarguraLayoutBuilder().telaPc
                                      ? MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            widget.client.orderAscDesc
                                                ? '${widget.client.orderSelection} DESC'
                                                : '${widget.client.orderSelection} ASC',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            onTap: () => DialogButtom().showDialog(
                              Observer(builder: (_) {
                                return const RadioOrderWidget();
                              }),
                              widget.client.theme,
                              constraint.maxWidth,
                              context,
                              width: MediaQuery.of(context).size.height * 0.4,
                            ),
                          ),
                          trailing: Wrap(
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.people,
                                    color: widget.client.theme
                                        ? darkThemeData(context).iconTheme.color
                                        : lightThemeData(context)
                                            .iconTheme
                                            .color,
                                  ),
                                  onTap: () {
                                    if (widget
                                        .client.perfilUserLogado.manager) {
                                      DialogButtom().showDialog(
                                        const TeamsSelectionWidget(),
                                        widget.client.theme,
                                        constraint.maxWidth,
                                        context,
                                      );
                                    }
                                  },
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 32.0),
                                  child: GestureDetector(
                                    child: Observer(
                                      builder: (_) {
                                        return Icon(
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
                                        );
                                      },
                                    ),
                                    onTap: () {
                                      if (widget
                                          .client.perfilUserLogado.manager) {
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
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
        leading: widget.back
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
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
                child: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                    ? Container()
                    : const Icon(
                        Icons.menu,
                      ),
              ),
      );
    });
  }
}
