import 'package:flutter_test/flutter_test.dart';
import 'package:munatasks2/app/modules/settings/perfil/perfil_store.dart';
 
void main() {
  late PerfilStore store;

  setUpAll(() {
    store = PerfilStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}