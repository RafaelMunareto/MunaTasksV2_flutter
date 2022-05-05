import 'package:flutter/material.dart';
import "package:universal_html/html.dart" as html;

class DownloadsWidget extends StatefulWidget {
  final String title;
  const DownloadsWidget(
      {Key? key, this.title = " Clique aqui para Baixar versão Desktop!"})
      : super(key: key);

  @override
  State<DownloadsWidget> createState() => _DownloadsWidgetState();
}

class _DownloadsWidgetState extends State<DownloadsWidget> {
  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => downloadFile(
            'https://github.com/RafaelMunareto/MunaTasksV2_flutter/raw/main/assets/exe/Output/munatask.exe'),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Image(
              width: 50,
              height: 50,
              image: AssetImage('assets/icon/icon.png'),
            ),
            Text(
              widget.title,
            ),
          ],
        ),
      ),
    );
  }
}
