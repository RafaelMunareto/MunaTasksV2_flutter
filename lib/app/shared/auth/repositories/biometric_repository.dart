import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/shared/auth/repositories/biometric_repository_interface.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BiometricRepository implements IBiometricRepository {
  final LocalAuthentication auth = Modular.get();

  @override
  Future<String> authenticateWithBiometrics(faceOrFinger) async {
    String authorized = '';
    bool authenticated = false;
    try {

      authenticated = await auth.authenticate(
          localizedReason:
          faceOrFinger ? 'Aponte para seu rosto' : 'Coloque sua digital',
          useErrorDialogs: true,
          androidAuthStrings: const AndroidAuthMessages(
            cancelButton: 'Cancelar',
            signInTitle: 'Requer autenticação',
            biometricHint: 'Verifica identidade',
          ),
          stickyAuth: true,
          biometricOnly: true);

    } on PlatformException catch (e) {
      //print(e);
      authorized = "Error - ${e.message}";
      return authorized;
    }
    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    authorized = message;

    return authorized;
  }

  @override
  Future<bool> cancelAuthentication() async {
    await auth.stopAuthentication();
    return false;
  }

  @override
  Future checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      return e;
    }
      return canCheckBiometrics;
  }

  @override
  Future getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
     return e;
    }
      return availableBiometrics;
  }

}