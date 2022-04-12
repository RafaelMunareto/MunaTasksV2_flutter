import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String? url;
  const CircleAvatarWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 10,
      maxRadius: 15,
      backgroundImage: NetworkImage(url ??
          'https://cdn.icon-icons.com/icons2/1603/PNG/512/computer-laptop-user-developer-programer_108610.png'),
      backgroundColor: Colors.transparent,
    );
  }
}
