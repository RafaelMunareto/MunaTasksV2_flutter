
abstract class IBiometricRepository {
  Future checkBiometrics();
  Future getAvailableBiometrics();
  Future<String> authenticateWithBiometrics(bool faceOrFinger);
  Future<bool> cancelAuthentication();
}
