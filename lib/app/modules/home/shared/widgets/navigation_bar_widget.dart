import 'dart:async';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class NavigationBarWidget extends StatefulWidget {
  final int navigateBarSelection;
  final Function setNavigateBarSelection;
  final List<int> badgets;
  final AnimationController controller;
  final bool theme;
  const NavigationBarWidget(
      {Key? key,
      this.navigateBarSelection = 0,
      required this.setNavigateBarSelection,
      required this.badgets,
      required this.controller,
      required this.theme})
      : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      key: UniqueKey(),
      opacity: .2,
      currentIndex: widget.navigateBarSelection,
      onTap: (value) {
        if (widget.navigateBarSelection != value) {
          widget.controller.forward();
        }
        widget.setNavigateBarSelection(value);
      },
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 10,
      backgroundColor: widget.theme ? Colors.black : Colors.white,
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
          icon: Icon(
            Icons.pause_circle,
            color: widget.theme ? Colors.white : Colors.blueGrey,
          ),
          activeIcon: const Icon(
            Icons.pause_circle,
            color: Colors.amber,
          ),
          title: const Text("Backlog"),
        ),
        BubbleBottomBarItem(
          showBadge: true,
          badge: Text(widget.badgets[1].toString()),
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
          title: const Text("Fazendo"),
        ),
        BubbleBottomBarItem(
          showBadge: true,
          badge: Text(widget.badgets[2].toString()),
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
          title: const Text("Feito"),
        ),
      ],
    );
  }
}
