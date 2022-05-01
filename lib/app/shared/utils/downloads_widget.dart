import 'package:download_assets/download_assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DownloadsWidget extends StatefulWidget {
  const DownloadsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DownloadsWidget> createState() => _DownloadsWidgetState();
}

class _DownloadsWidgetState extends State<DownloadsWidget> {
  String message = " Clique aqui para Baixar versão Desktop!";
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  bool downloaded = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    await downloadAssetsController.init();
    downloaded = await downloadAssetsController.assetsDirAlreadyExists();
  }

  @override
  Widget build(BuildContext context) {
    return !kIsWeb
        ? Container()
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _downloadAssets(),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Image(
                    width: 50,
                    height: 50,
                    image: AssetImage('assets/icon/icon.png'),
                  ),
                  Text(
                    message,
                  ),
                ],
              ),
            ),
          );
  }

  Future _downloadAssets() async {
    bool assetsDownloaded =
        await downloadAssetsController.assetsDirAlreadyExists();

    if (assetsDownloaded) {
      setState(() {
        message = "Click in refresh button to force download";
        print(message);
      });
      return;
    }

    try {
      await downloadAssetsController.startDownload(
        assetsUrl:
            "https://github.com/edjostenes/download_assets/raw/master/assets.zip",
        onProgress: (progressValue) {
          downloaded = false;
          setState(() {
            if (progressValue < 100) {
              message = "Downloading - ${progressValue.toStringAsFixed(2)}";
              print(message);
            } else {
              message =
                  "Download completed\nClick in refresh button to force download";
              print(message);
              downloaded = true;
            }
          });
        },
      );
    } on DownloadAssetsException catch (e) {
      setState(() {
        downloaded = false;
        message = "Error: ${e.toString()}";
      });
    }
  }
}
