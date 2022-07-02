import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final dynamic url;
  final String nameUser;
  const CircleAvatarWidget(
      {Key? key, required this.url, required this.nameUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: nameUser,
      child: CircleAvatar(
        minRadius: 8,
        maxRadius: 12,
        backgroundImage: CachedNetworkImageProvider(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
