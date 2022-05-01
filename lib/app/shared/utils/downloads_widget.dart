import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/dio_struture.dart';

class DownloadsWidget extends StatefulWidget {
  final String title;
  const DownloadsWidget(
      {Key? key, this.title = " Clique aqui para Baixar versão Desktop!"})
      : super(key: key);

  @override
  State<DownloadsWidget> createState() => _DownloadsWidgetState();
}

class _DownloadsWidgetState extends State<DownloadsWidget> {
  @override
  Widget build(BuildContext context) {
    return !kIsWeb
        ? Container()
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                Response response;
                var dio = Dio(
                  BaseOptions(
                    baseUrl: DioStruture().baseUrlMunatasks,
                  ),
                );
                response = await dio.download(
                  'https://github.com/RafaelMunareto/MunaTasksV2_flutter/blob/main/assets/exe/Output/munatasksSetup.exe',
                  Options(
                      responseType: ResponseType.bytes,
                      followRedirects: false,
                      validateStatus: (status) {
                        return status! < 500;
                      }),
                );
                DioStruture().statusRequest(response);
              },
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
