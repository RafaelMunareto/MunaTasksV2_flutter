import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class PrivacyPage extends StatefulWidget {
  final String title;
  const PrivacyPage({Key? key, this.title = 'Privacy'}) : super(key: key);
  @override
  PrivacyPageState createState() => PrivacyPageState();
}

class PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double withDevice = constraint.maxWidth;

      if (withDevice < 600) {
        withDevice = withDevice * 1;
      } else if (withDevice < 960) {
        withDevice = withDevice * 0.7;
      } else if (withDevice < 1025) {
        withDevice = withDevice * 0.5;
      } else {
        withDevice = withDevice * 0.5;
      }
      return Scaffold(
          appBar: AppBarWidget(
              title: widget.title,
              icon: Icons.privacy_tip,
              context: context,
              settings: true,
              rota: '/home/'),
          body: Container());
    });
  }
}
