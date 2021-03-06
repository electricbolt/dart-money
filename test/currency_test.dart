// currency_test.dart
// MoneyCurrency Copyright © 2021; Electric Bolt Limited.

import 'package:test/test.dart';
import 'package:moneycurrency/src/currency.dart';

void main() {
  test('currency', () {
    var NZD = Currency('NZD', 'New Zealand dollar', '🇳🇿', '\$', '', 2,
        'dollar', 'dollars', 'cent', 'cents', 'new zealand');
    expect(NZD.toString(), equals('NZD,\$,New Zealand dollar,2DP'));
  });
}
