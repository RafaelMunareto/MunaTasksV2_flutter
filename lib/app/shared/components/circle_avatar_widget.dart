import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final dynamic url;
  const CircleAvatarWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 10,
      maxRadius: 15,
      backgroundImage: NetworkImage(url == '' || url == null
          ? 'https://firebasestorage.googleapis.com/v0/b/munatasksv2.appspot.com/o/person_people_avatar_man_boy_glasses_icon_131369.png?alt=media&token=19343af9-36fa-422d-88c3-716b1ffdbb88'
          : url),
      backgroundColor: Colors.transparent,
    );
  }
}
