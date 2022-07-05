import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';

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
      child: GFAvatar(
        radius: 12,
        shape: GFAvatarShape.standard,
        backgroundImage: CachedNetworkImageProvider(url),
      ),
    );
  }
}
