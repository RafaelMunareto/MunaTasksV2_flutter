import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/shared/utils/themes/constants.dart';

class NavigationBarWidget extends StatefulWidget {
  final int navigateBarSelection;
  final Function setNavigateBarSelection;
  const NavigationBarWidget(
      {Key? key,
      required this.navigateBarSelection,
      required this.setNavigateBarSelection})
      : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      backgroundColor: Colors.blueGrey.shade300,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: widget.navigateBarSelection,
      onTap: (value) {
        setState(() {
          widget.setNavigateBarSelection(value);
        });
      },
      items: [
        BottomNavigationBarItem(
          label: 'Backlog',
          icon: Badge(
            badgeColor: kPrimaryColor,
            badgeContent: const Text('3'),
            child: const Icon(Icons.pause_circle),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Fazendo',
          icon: Badge(
            badgeColor: kPrimaryColor,
            badgeContent: const Text('3'),
            child: const Icon(Icons.play_circle_filled),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Feito',
          icon: Badge(
            badgeColor: kPrimaryColor,
            badgeContent: const Text('3'),
            child: const Icon(Icons.check_circle),
          ),
        ),
      ],
    );
  }
}
