// currencymanager_test.dart
// Money Copyright © 2021; Electric Bolt Limited.

import 'package:test/test.dart';
import 'package:money/src/currencymanager.dart';

void main() {
  test('singleton', () {
    expect(CurrencyManager(), equals(CurrencyManager()));
  });

  test('init', () {
    expect(CurrencyManager().list().length, equals(43));
  });

  test('removePopulate', () {
    CurrencyManager().remove('NZD');
    expect(CurrencyManager().get('NZD'), equals(null));
    expect(CurrencyManager().list().length, equals(42));

    CurrencyManager().removeAll();
    expect(CurrencyManager().list().length, equals(0));

    CurrencyManager().populateWithStaticList();
    expect(CurrencyManager().list().length, equals(43));
    var list = CurrencyManager().list();
    expect(list[0].code, equals('AED'));
    expect(list[42].code, equals('ZAR'));
  });

  test('get', () {
    expect(CurrencyManager().get('BOB'), equals(null));
    expect(CurrencyManager().get(''), equals(null));
    expect(CurrencyManager().get('NZD')!.code, equals('NZD'));
  });
}