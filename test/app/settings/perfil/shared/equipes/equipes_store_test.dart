import 'package:flutter_test/flutter_test.dart';
import 'package:munatasks2/app/settings/perfil/shared/equipes/equipes_store.dart';
 
void main() {
  late EquipesStore store;

  setUpAll(() {
    store = EquipesStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}