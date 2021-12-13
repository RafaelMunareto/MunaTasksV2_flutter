import 'package:flutter_test/flutter_test.dart';
import 'package:munatasks2/app/modules/settings/principal/principal_store.dart';
 
void main() {
  late PrincipalStore store;

  setUpAll(() {
    store = PrincipalStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}