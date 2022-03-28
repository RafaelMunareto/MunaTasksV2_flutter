import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';

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
    return Observer(builder: (_) {
      return BubbleBottomBar(
        opacity: .2,
        tilesPadding:
            kIsWeb ? const EdgeInsets.all(18) : const EdgeInsets.all(0),
        currentIndex: widget.navigateBarSelection,
        onTap: (value) {
          widget.setNavigateBarSelection(value);
        },
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 13,
        backgroundColor:
            widget.theme ? const Color.fromARGB(255, 53, 53, 53) : Colors.white,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        iconSize: kIsWeb ? 48 : 20,
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            showBadge: true,
            badge: Text(
              store.client.badgetNavigate[0].toString(),
              style: const TextStyle(fontSize: kIsWeb ? 20 : 12),
            ),
            backgroundColor: Colors.amber,
            badgeColor: ThemeData().primaryColor,
            icon: Icon(
              Icons.pause_circle,
              color: widget.theme ? Colors.white : Colors.blueGrey,
            ),
            activeIcon: const Icon(
              Icons.pause_circle,
              color: Colors.amber,
            ),
            title: const Text("Backlog",
                style: TextStyle(fontSize: kIsWeb ? 20 : 12)),
          ),
          BubbleBottomBarItem(
            showBadge: true,
            badge: Text(store.client.badgetNavigate[1].toString(),
                style: const TextStyle(fontSize: kIsWeb ? 20 : 12)),
            badgeColor: ThemeData().primaryColor,
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.play_circle,
              color: widget.theme ? Colors.white : Colors.blueGrey,
            ),
            activeIcon: const Icon(
              Icons.play_circle,
              color: Colors.green,
            ),
            title: const Text("Fazendo",
                style: TextStyle(fontSize: kIsWeb ? 20 : 12)),
          ),
          BubbleBottomBarItem(
            showBadge: true,
            badge: Text(store.client.badgetNavigate[2].toString(),
                style: const TextStyle(fontSize: kIsWeb ? 20 : 12)),
            backgroundColor: Colors.blue,
            badgeColor: ThemeData().primaryColor,
            icon: Icon(
              Icons.check_circle,
              color: widget.theme ? Colors.white : Colors.blueGrey,
            ),
            activeIcon: const Icon(
              Icons.check_circle,
              color: Colors.blue,
            ),
            title: const Text("Feito",
                style: TextStyle(fontSize: kIsWeb ? 20 : 12)),
          ),
        ],
      );
    });
  }
}
