// ignore_for_file: unrelated_type_equality_checks

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/utils/notification_service.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  if (defaultTargetPlatform == TargetPlatform.windows) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.alignment = Alignment.center;
      win.title = "Munatask";
      win.show();
    });
  }
}
