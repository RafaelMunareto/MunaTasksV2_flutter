import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/shared/auth/auth_controller.dart';
import 'package:munatasks2/app/shared/utils/simple_button_widget.dart';
import 'package:munatasks2/app/shared/utils/themes/theme.dart';
import 'package:show_update_dialog/show_update_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class FunctionsUtils {
  HomeStore store = Modular.get();
  AuthController auth = Modular.get();

  dialogDelete(context, tarefa, store) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          height: 200,
          child: AlertDialog(
            key: Key(tarefa.id!),
            title: Text(
              'Excluir Tarefa',
              style: TextStyle(
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor),
            ),
            content: const Text(
              'Tem certeza que deseja excluír a tarefa ?',
              maxLines: 1,
            ),
            actions: [
              SimpleButtonWidget(
                theme: store.client.theme,
                buttonName: 'CANCELAR',
                popUp: true,
              ),
              SimpleButtonWidget(
                theme: store.client.theme,
                buttonName: 'EXCLUIR',
                popUp: true,
                function: store.deleteDioTasks,
                dataFunction: tarefa,
                scnack: true,
                msgSnack: 'Deletado com sucesso!',
                delete: true,
              ),
            ],
          ),
        );
      },
    );
  }

  verifyVersion(context) async {
    final versionCheck = ShowUpdateDialog(
        androidId: 'munacorp.munatasks2.br.munatasks2',
        iOSAppStoreCountry: 'BR');

    final VersionModel vs = await versionCheck.fetchVersionInfo();
    var _releaseNotes = vs.releaseNotes!.replaceAll("<br>", "\n");
    versionCheck.showCustomDialogUpdate(
      context: context,
      versionStatus: vs,
      buttonText: "Atualizar",
      buttonColor: store.client.theme
          ? darkThemeData(context).primaryColor
          : lightThemeData(context).primaryColor,
      bodyoverride: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.update,
                  size: 150,
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor,
                ),
              ],
            ),
            const Text(
              "Por favor atualize seu App.",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            Text(
              "Versão do aparelho: ${vs.localVersion}",
              style: const TextStyle(fontSize: 17),
            ),
            Text(
              "Versão da loja: ${vs.storeVersion}",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 30),
            Text(
              _releaseNotes,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  void sendNotification() {
    // ignore: unused_local_variable
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
  }

  checkUpdateDesktop(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 200,
          height: 200,
          child: AlertDialog(
            title: Text(
              'Atualizar versão',
              style: TextStyle(
                  color: store.client.theme
                      ? darkThemeData(context).primaryColor
                      : lightThemeData(context).primaryColor),
            ),
            content: Text(
              'Sua versão está desatualizada a nova versão é a ${store.client.versionBd}',
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text('Cancelar')),
              ElevatedButton(
                  onPressed: () => launchUrl(Uri.parse(
                      'https://github.com/RafaelMunareto/MunaTasksV2_flutter/raw/main/assets/exe/Output/munatask.exe')),
                  child: const Text('Atualizar')),
            ],
          ),
        );
      },
    );
  }

  showErrors(DioError error) {
    store.client.setMsgError(auth.globalError(error));
  }

  showErrorsReturn(DioError error) {
    return auth.globalError(error);
  }
}
