import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';

class NavigationBarWidget extends StatefulWidget {
  final int navigateBarSelection;
  final Function setNavigateBarSelection;
  final bool theme;
  const NavigationBarWidget({
    Key? key,
    this.navigateBarSelection = 0,
    required this.setNavigateBarSelection,
    required this.theme,
  }) : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Observer(builder: (_) {
        return Wrap(
          children: [
            BubbleBottomBar(
              backgroundColor:
                  widget.theme ? Colors.blueGrey.shade800 : Colors.white,
              opacity: .2,
              tilesPadding: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                  ? const EdgeInsets.all(18)
                  : const EdgeInsets.all(0),
              currentIndex: widget.navigateBarSelection,
              onTap: (value) {
                widget.setNavigateBarSelection(value);
              },
              borderRadius: BorderRadius.circular(5),
              elevation: 24,
              fabLocation: BubbleBottomBarFabLocation.end,
              hasNotch: true,
              hasInk: true,
              iconSize: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                  ? 48
                  : 20,
              items: <BubbleBottomBarItem>[
                BubbleBottomBarItem(
                  showBadge: true,
                  badgeColor: widget.theme
                      ? darkThemeData(context).secondaryHeaderColor
                      : lightThemeData(context).secondaryHeaderColor,
                  badge: Text(
                    store.client.badgets[0].toString(),
                    style: TextStyle(
                        fontSize:
                            constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                                ? 20
                                : 12,
                        color: Colors.white),
                  ),
                  backgroundColor: Colors.amber,
                  icon: Icon(
                    Icons.pause_circle,
                    color: widget.theme
                        ? darkThemeData(context).secondaryHeaderColor
                        : lightThemeData(context).secondaryHeaderColor,
                  ),
                  activeIcon: const Icon(
                    Icons.pause_circle,
                    color: Colors.amber,
                  ),
                  title: AutoSizeText("Backlog",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: constraint.maxWidth >=
                                  LarguraLayoutBuilder().telaPc
                              ? 20
                              : 12)),
                ),
                BubbleBottomBarItem(
                  showBadge: true,
                  badgeColor: widget.theme
                      ? darkThemeData(context).secondaryHeaderColor
                      : lightThemeData(context).secondaryHeaderColor,
                  badge: Text(store.client.badgets[1].toString(),
                      style: TextStyle(
                          fontSize: constraint.maxWidth >=
                                  LarguraLayoutBuilder().telaPc
                              ? 20
                              : 12,
                          color: Colors.white)),
                  backgroundColor: Colors.green,
                  icon: Icon(
                    Icons.play_circle,
                    color: widget.theme
                        ? darkThemeData(context).secondaryHeaderColor
                        : lightThemeData(context).secondaryHeaderColor,
                  ),
                  activeIcon: const Icon(
                    Icons.play_circle,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Fazendo",
                    style: TextStyle(
                        fontSize:
                            constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                                ? 20
                                : 12),
                  ),
                ),
                BubbleBottomBarItem(
                  showBadge: true,
                  badgeColor: widget.theme
                      ? darkThemeData(context).secondaryHeaderColor
                      : lightThemeData(context).secondaryHeaderColor,
                  badge: Text(store.client.badgets[2].toString(),
                      style: TextStyle(
                          fontSize: constraint.maxWidth >=
                                  LarguraLayoutBuilder().telaPc
                              ? 20
                              : 12,
                          color: Colors.white)),
                  backgroundColor: Colors.blue,
                  icon: Icon(
                    Icons.check_circle,
                    color: widget.theme
                        ? darkThemeData(context).secondaryHeaderColor
                        : lightThemeData(context).secondaryHeaderColor,
                  ),
                  activeIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Feito",
                    style: TextStyle(
                        fontSize:
                            constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                                ? 20
                                : 12),
                  ),
                ),
              ],
            ),
          ],
        );
      });
    });
  }
}
