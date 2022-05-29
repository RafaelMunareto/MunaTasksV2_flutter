import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/utils/largura_layout_builder.dart';

class NameWidget extends StatelessWidget {
  final dynamic store;
  final double constraint;
  const NameWidget({Key? key, required this.store, required this.constraint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Wrap(
        direction: constraint <= LarguraLayoutBuilder().larguraModal
            ? Axis.vertical
            : Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          Container(
            width: 70.0,
            height: 70.0,
            decoration: store.client.perfilUserLogado.urlImage != ''
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        store.client.perfilUserLogado.urlImage,
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
          ),
          const Text(
            " Olá",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Text(
            ' ' + store.client.perfilUserLogado.name.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
