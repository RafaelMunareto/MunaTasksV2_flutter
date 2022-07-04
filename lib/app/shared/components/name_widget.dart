import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class NameWidget extends StatelessWidget {
  final dynamic client;
  final double constraint;
  const NameWidget({Key? key, required this.client, required this.constraint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80),
        child: Wrap(
          direction: constraint <= LarguraLayoutBuilder().larguraModal
              ? Axis.vertical
              : Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            client.perfilUserLogado.urlImage != ''
                ? Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: client.perfilUserLogado.urlImage != ''
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                client.perfilUserLogado.urlImage,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/img/person.png'),
                            ),
                          ),
                  )
                : const CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: client.perfilUserLogado.urlImage == ''
                  ? const Text('')
                  : AutoSizeText(
                      'Olá, ' + client.perfilUserLogado.name.name,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            )
          ],
        ),
      );
    });
  }
}
