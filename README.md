## Money and Currency value objects for Dart

A Money is a value object that represents an amount and an associated currency. Amounts either represent a real value 
(e.g. -$1927.10, ￥10, £1.56, 0.00kr.) or are unavailable (e.g. have no numerical value).

☞ In many financial applications, host systems can be unavailable throughout the day due to batch jobs running etc, 
and for this reason, amounts have notion of being unavailable.

This library is open source (BSD-2). Development occurs on [GitHub](https://github.com/electricbolt/dart-money).
Package is hosted on dart [packages](https://pub.dev/packages/money).

Looking for an Swift [implementation](https://github.com/electricbolt/corekit)?.

### Features

`Money` objects can be compared, hashed, added and subtracted. Using a `MoneyFormatter` class, `Money` objects can be 
converted to and from strings.

### Distribution

* Minimum Dart version 2.12 (null safety)
* Friendly BSD-2 license

### Installation

Import the library into your Dart code using:

```dart
import 'package:money/money.dart';
```

#### Money example

```dart
var NZD = CurrencyManager().get('NZD')!;
var amount1 = Money.string('4.51', NZD);
var amount2 = Money.string('1020.04', NZD);
var total = amount1 + amount2; // 1024.55
print(total.toString(symbols: true, grouping: true)); // $1,024.55
```
