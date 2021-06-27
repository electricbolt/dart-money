// example.dart
// Money Copyright © 2021; Electric Bolt Limited.

import 'package:moneycurrency/moneycurrency.dart';

void main() {
  var NZD = CurrencyManager().get('NZD')!;
  var amount1 = Money.string('4.51', NZD);
  var amount2 = Money.string('1020.04', NZD);
  var total = amount1 + amount2; // 1024.55

  // prints '$1,024.55'
  print(total.toString(symbols: true, grouping: true));

  // prints 'one thousand and twenty four dollars and fifty five cents'
  print(total.accessibilityText());
}
