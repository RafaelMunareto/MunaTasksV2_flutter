import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/card_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/landscape_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_etiquetas_filter_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/radio_order_widget.dart';
import 'package:munatasks2/app/modules/home/shared/widgets/teams_selection_widget.dart';
import 'package:munatasks2/app/shared/components/circle_avatar_widget.dart';
import 'package:munatasks2/app/shared/utils/circular_progress_widget.dart';
import 'package:munatasks2/app/shared/utils/convert_icon.dart';
import 'package:munatasks2/app/shared/utils/dialog_buttom.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class BodyHomePageWidget extends StatefulWidget {
  const BodyHomePageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyHomePageWidget> createState() => _BodyHomePageWidgetState();
}

class _BodyHomePageWidgetState extends State<BodyHomePageWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return kIsWeb || Platform.isWindows
            ? SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: store.client.theme
                                        ? darkThemeData(context)
                                            .shadowColor
                                            .withOpacity(0.2)
                                        : lightThemeData(context)
                                            .shadowColor
                                            .withOpacity(0.2),
                                  ),
                                  BoxShadow(
                                    color: store.client.theme
                                        ? darkThemeData(context)
                                            .scaffoldBackgroundColor
                                        : lightThemeData(context)
                                            .scaffoldBackgroundColor,
                                    spreadRadius: -3.0,
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: GestureDetector(
                                  child: store.client.icon != 0
                                      ? Icon(
                                          IconData(store.client.icon,
                                              fontFamily: 'MaterialIcons'),
                                          color: ConvertIcon()
                                              .convertColor(store.client.color),
                                        )
                                      : Icon(
                                          Icons.bookmark,
                                          color: store.client.theme
                                              ? darkThemeData(context)
                                                  .iconTheme
                                                  .color
                                              : lightThemeData(context)
                                                  .iconTheme
                                                  .color,
                                        ),
                                  onTap: () {
                                    DialogButtom().showDialog(
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: RadioEtiquetasFilterWidget(
                                          changeFilterEtiquetaList:
                                              store.changeFilterEtiquetaList,
                                          setColor: store.client.setColor,
                                          setIcon: store.client.setIcon,
                                          setEtiquetaSelection:
                                              store.client.setEtiquetaSelection,
                                        ),
                                      ),
                                      store.client.theme,
                                      context,
                                    );
                                  },
                                ),
                                title: Center(
                                  child: GestureDetector(
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.filter_alt,
                                          ),
                                          Text(
                                            store.client.orderAscDesc
                                                ? '${store.client.orderSelection} DESC'
                                                : '${store.client.orderSelection} ASC',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () => DialogButtom().showDialog(
                                      Observer(builder: (_) {
                                        return RadioOrderWidget(
                                          orderAscDesc:
                                              store.client.orderAscDesc,
                                          setOrderAscDesc:
                                              store.client.setOrderAscDesc,
                                          orderSelection:
                                              store.client.orderSelection,
                                          changeOrderList:
                                              store.changeOrderList,
                                          setOrderSelection:
                                              store.client.setOrderSelection,
                                        );
                                      }),
                                      store.client.theme,
                                      context,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  child: Icon(
                                    Icons.people,
                                    color: store.client.theme
                                        ? darkThemeData(context).iconTheme.color
                                        : lightThemeData(context)
                                            .iconTheme
                                            .color,
                                  ),
                                  onTap: () {
                                    if (store.client.perfilUserLogado.manager) {
                                      DialogButtom().showDialog(
                                        TeamsSelectionWidget(
                                          changeFilterUserList:
                                              store.changeFilterUserList,
                                          setImageUser: store.client.setImgUrl,
                                          setUserSelection:
                                              store.client.setUserSelection,
                                        ),
                                        store.client.theme,
                                        context,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const CardWidget(),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 3,
                      child: Center(
                        child: const LandscapeWidget(),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (!store.client.loading)
                            ListTile(
                              leading: GestureDetector(
                                child: store.client.icon != 0
                                    ? Icon(
                                        IconData(store.client.icon,
                                            fontFamily: 'MaterialIcons'),
                                        color: ConvertIcon()
                                            .convertColor(store.client.color),
                                      )
                                    : const Icon(
                                        Icons.bookmark,
                                      ),
                                onTap: () {
                                  DialogButtom().showDialog(
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: RadioEtiquetasFilterWidget(
                                        changeFilterEtiquetaList:
                                            store.changeFilterEtiquetaList,
                                        setColor: store.client.setColor,
                                        setIcon: store.client.setIcon,
                                        setEtiquetaSelection:
                                            store.client.setEtiquetaSelection,
                                      ),
                                    ),
                                    store.client.theme,
                                    context,
                                  );
                                },
                              ),
                              title: Center(
                                child: GestureDetector(
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.filter_alt,
                                        ),
                                        Text(
                                          store.client.orderAscDesc
                                              ? '${store.client.orderSelection} DESC'
                                              : '${store.client.orderSelection} ASC',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => DialogButtom().showDialog(
                                    Observer(builder: (_) {
                                      return RadioOrderWidget(
                                        orderAscDesc: store.client.orderAscDesc,
                                        setOrderAscDesc:
                                            store.client.setOrderAscDesc,
                                        orderSelection:
                                            store.client.orderSelection,
                                        changeOrderList: store.changeOrderList,
                                        setOrderSelection:
                                            store.client.setOrderSelection,
                                      );
                                    }),
                                    store.client.theme,
                                    context,
                                    width: MediaQuery.of(context).size.height *
                                        0.4,
                                  ),
                                ),
                              ),
                              trailing: GestureDetector(
                                child: CircleAvatarWidget(
                                  url: store.client.imgUrl,
                                ),
                                onTap: () {
                                  if (store.client.perfilUserLogado.manager) {
                                    DialogButtom().showDialog(
                                      TeamsSelectionWidget(
                                        changeFilterUserList:
                                            store.changeFilterUserList,
                                        setImageUser: store.client.setImgUrl,
                                        setUserSelection:
                                            store.client.setUserSelection,
                                      ),
                                      store.client.theme,
                                      context,
                                    );
                                  }
                                },
                              ),
                            ),
                          const CardWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
