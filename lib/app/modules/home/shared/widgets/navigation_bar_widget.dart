import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
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
      return BubbleBottomBar(
        backgroundColor: widget.theme ? Colors.blueGrey.shade800 : Colors.white,
        opacity: .2,
        tilesPadding: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
            ? const EdgeInsets.all(18)
            : const EdgeInsets.all(0),
        currentIndex: widget.navigateBarSelection,
        onTap: (value) {
          widget.setNavigateBarSelection(value);
        },
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 24,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        iconSize:
            constraint.maxWidth >= LarguraLayoutBuilder().telaPc ? 48 : 20,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            showBadge: true,
            badgeColor: widget.theme
                ? darkThemeData(context).secondaryHeaderColor
                : lightThemeData(context).secondaryHeaderColor,
            badge: Text(
              store.client.badgetNavigate[0].toString(),
              style: TextStyle(
                  fontSize: constraint.maxWidth >= LarguraLayoutBuilder().telaPc
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
            title: Text("Backlog",
                style: TextStyle(
                    fontSize:
                        constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                            ? 20
                            : 12)),
          ),
          BubbleBottomBarItem(
            showBadge: true,
            badgeColor: widget.theme
                ? darkThemeData(context).secondaryHeaderColor
                : lightThemeData(context).secondaryHeaderColor,
            badge: Text(store.client.badgetNavigate[1].toString(),
                style: TextStyle(
                    fontSize:
                        constraint.maxWidth >= LarguraLayoutBuilder().telaPc
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
            title: Text("Fazendo",
                style: TextStyle(
                    fontSize:
                        constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                            ? 20
                            : 12)),
          ),
          BubbleBottomBarItem(
            showBadge: true,
            badgeColor: widget.theme
                ? darkThemeData(context).secondaryHeaderColor
                : lightThemeData(context).secondaryHeaderColor,
            badge: Text(store.client.badgetNavigate[2].toString(),
                style: TextStyle(
                    fontSize:
                        constraint.maxWidth >= LarguraLayoutBuilder().telaPc
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
            title: Text("Feito",
                style: TextStyle(
                    fontSize:
                        constraint.maxWidth >= LarguraLayoutBuilder().telaPc
                            ? 20
                            : 12)),
          ),
        ],
      );
    });
  }
}
