import 'package:badges/badges.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class NavigationBarWidget extends StatefulWidget {
  final int navigateBarSelection;
  final Function setNavigateBarSelection;
  final List<int> badgets;
  const NavigationBarWidget(
      {Key? key,
      required this.navigateBarSelection,
      required this.setNavigateBarSelection,
      required this.badgets})
      : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: widget.navigateBarSelection,
      onTap: (value) {
        widget.setNavigateBarSelection(value);
      },
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
      fabLocation: BubbleBottomBarFabLocation.end, //new
      hasNotch: true, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12, //optional, uses theme color if not specified
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          showBadge: true,
          badge: Text(widget.badgets[0].toString()),
          backgroundColor: Colors.amber,
          badgeColor: ThemeData().primaryColor,
          icon: const Icon(
            Icons.pause_circle,
          ),
          activeIcon: const Icon(
            Icons.pause_circle,
          ),
          title: const Text("Backlog"),
        ),
        BubbleBottomBarItem(
          showBadge: true,
          badge: Text(widget.badgets[1].toString()),
          badgeColor: ThemeData().primaryColor,
          backgroundColor: Colors.green,
          icon: const Icon(
            Icons.play_circle,
          ),
          activeIcon: const Icon(
            Icons.play_circle,
          ),
          title: const Text("Fazendo"),
        ),
        BubbleBottomBarItem(
          showBadge: true,
          badge: Text(widget.badgets[2].toString()),
          backgroundColor: Colors.blue,
          badgeColor: ThemeData().primaryColor,
          icon: const Icon(
            Icons.check_circle,
          ),
          activeIcon: const Icon(
            Icons.check_circle,
          ),
          title: const Text("Feito"),
        ),
      ],
    );
  }
}
