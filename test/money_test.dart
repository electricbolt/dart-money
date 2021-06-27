// money_test.dart
// MoneyCurrency Copyright © 2021; Electric Bolt Limited.

import 'package:decimal/decimal.dart';
import 'package:moneycurrency/src/currencymanager.dart';
import 'package:moneycurrency/src/money.dart';
import 'package:test/test.dart';

void main() {
  var NZD = CurrencyManager().get('NZD')!;
  var AUD = CurrencyManager().get('AUD')!;
  var JPY = CurrencyManager().get('JPY')!;

  test('currency', () {
    var m = Money.decimal(Decimal.zero, NZD);
    expect(m.currency.code, equals('NZD'));
  });

  test('double0dp', () {
    var m = Money.double(0.0, JPY);
    expect(m.toDouble(), equals(0.0));
    expect(m.toDecimal(), equals(Decimal.zero));
    expect(m.toString(), equals('0'));

    m = Money.double(1.0, JPY);
    expect(m.toDouble(), equals(1.0));
    expect(m.toDecimal(), equals(Decimal.one));
    expect(m.toString(), equals('1'));

    m = Money.double(12248, JPY);
    expect(m.toDouble(), equals(12248.0));
    expect(m.toDecimal(), equals(Decimal.parse('12248')));
    expect(m.toString(), equals('12248'));

    m = Money.double(-12248, JPY);
    expect(m.toDouble(), equals(-12248.0));
    expect(m.toDecimal(), equals(Decimal.parse('-12248')));
    expect(m.toString(), equals('-12248'));

    m = Money.unavailable(JPY);
    expect(m.toDouble().isNaN, equals(true));
    expect(m.toDecimal(), equals(null));
    expect(m.toString(), equals(''));
  });

  test('double2dp', () {
    var m = Money.double(0.0, NZD);
    expect(m.toDouble(), equals(0.0));
    expect(m.toDecimal(), equals(Decimal.zero));
    expect(m.toString(), equals('0.00'));

    m = Money.double(1.54, NZD);
    expect(m.toDouble(), equals(1.54));
    expect(m.toDecimal(), equals(Decimal.parse('1.54')));
    expect(m.toString(), equals('1.54'));

    m = Money.double(12248.39, NZD);
    expect(m.toDouble(), equals(12248.39));
    expect(m.toDecimal(), equals(Decimal.parse('12248.39')));
    expect(m.toString(), equals('12248.39'));

    m = Money.double(-12248.39, NZD);
    expect(m.toDouble(), equals(-12248.39));
    expect(m.toDecimal(), equals(Decimal.parse('-12248.39')));
    expect(m.toString(), equals('-12248.39'));

    m = Money.unavailable(NZD);
    expect(m.toDouble().isNaN, equals(true));
    expect(m.toDecimal(), equals(null));
    expect(m.toString(), equals(''));
  });

  test('decimal0dp', () {
    var m = Money.decimal(Decimal.zero, JPY);
    expect(m.toDouble(), equals(0.0));
    expect(m.toDecimal(), equals(Decimal.zero));
    expect(m.toString(), equals('0'));

    m = Money.decimal(Decimal.fromInt(1), JPY);
    expect(m.toDouble(), equals(1.0));
    expect(m.toDecimal(), equals(Decimal.one));
    expect(m.toString(), equals('1'));

    m = Money.decimal(Decimal.fromInt(12248), JPY);
    expect(m.toDouble(), equals(12248.0));
    expect(m.toDecimal(), equals(Decimal.parse('12248')));
    expect(m.toString(), equals('12248'));

    m = Money.decimal(Decimal.fromInt(-12248), JPY);
    expect(m.toDouble(), equals(-12248.0));
    expect(m.toDecimal(), equals(Decimal.parse('-12248')));
    expect(m.toString(), equals('-12248'));
  });

  test('decimal2dp', () {
    var m = Money.decimal(Decimal.zero, NZD);
    expect(m.toDouble(), equals(0.0));
    expect(m.toDecimal(), equals(Decimal.zero));
    expect(m.toString(), equals('0.00'));

    m = Money.decimal(Decimal.parse('1.54'), NZD);
    expect(m.toDouble(), equals(1.54));
    expect(m.toDecimal(), equals(Decimal.parse('1.54')));
    expect(m.toString(), equals('1.54'));

    m = Money.decimal(Decimal.parse('12248.39'), NZD);
    expect(m.toDouble(), equals(12248.39));
    expect(m.toDecimal(), equals(Decimal.parse('12248.39')));
    expect(m.toString(), equals('12248.39'));

    m = Money.decimal(Decimal.parse('-12248.39'), NZD);
    expect(m.toDouble(), equals(-12248.39));
    expect(m.toDecimal(), equals(Decimal.parse('-12248.39')));
    expect(m.toString(), equals('-12248.39'));
  });

  test('string0dp', () {
    var m = Money.string('0', JPY);
    expect(m.toDouble(), equals(0.0));
    expect(m.toDecimal(), equals(Decimal.zero));
    expect(m.toString(), equals('0'));

    m = Money.string('1', JPY);
    expect(m.toDouble(), equals(1.0));
    expect(m.toDecimal(), equals(Decimal.one));
    expect(m.toString(), equals('1'));

    m = Money.string('12248', JPY);
    expect(m.toDouble(), equals(12248.0));
    expect(m.toDecimal(), equals(Decimal.parse('12248')));
    expect(m.toString(), equals('12248'));

    m = Money.string('-12248', JPY);
    expect(m.toDouble(), equals(-12248.0));
    expect(m.toDecimal(), equals(Decimal.parse('-12248')));
    expect(m.toString(), equals('-12248'));

    m = Money.string(' -12248\t', JPY);
    expect(m.toDouble(), equals(-12248.0));
    expect(m.toDecimal(), equals(Decimal.parse('-12248')));
    expect(m.toString(), equals('-12248'));
  });

  test('decimal2dp', () {
    var m = Money.string('0.00', NZD);
    expect(m.toDouble(), equals(0.0));
    expect(m.toDecimal(), equals(Decimal.zero));
    expect(m.toString(), equals('0.00'));

    m = Money.string('1.54', NZD);
    expect(m.toDouble(), equals(1.54));
    expect(m.toDecimal(), equals(Decimal.parse('1.54')));
    expect(m.toString(), equals('1.54'));

    m = Money.string('12248.39', NZD);
    expect(m.toDouble(), equals(12248.39));
    expect(m.toDecimal(), equals(Decimal.parse('12248.39')));
    expect(m.toString(), equals('12248.39'));

    m = Money.string('-12248.39', NZD);
    expect(m.toDouble(), equals(-12248.39));
    expect(m.toDecimal(), equals(Decimal.parse('-12248.39')));
    expect(m.toString(), equals('-12248.39'));

    m = Money.string('\t-12248.39 ', NZD);
    expect(m.toDouble(), equals(-12248.39));
    expect(m.toDecimal(), equals(Decimal.parse('-12248.39')));
    expect(m.toString(), equals('-12248.39'));
  });

  group('comparable', () {
    test('==equality', () {
      expect(Money.string('0.00', NZD), equals(Money.string('0.00', NZD)));
      expect(
          Money.string('0.00', NZD), isNot(equals(Money.string('0.01', NZD))));

      expect(Money.string('1.54', NZD), equals(Money.string('1.54', NZD)));
      expect(
          Money.string('1.53', NZD), isNot(equals(Money.string('1.54', NZD))));

      expect(
          Money.string('12248.39', NZD), equals(Money.string('12248.39', NZD)));
      expect(Money.string('12248.38', NZD),
          isNot(equals(Money.string('12248.39', NZD))));

      expect(Money.string('-12248.39', NZD),
          equals(Money.string('-12248.39', NZD)));
      expect(Money.string('-12248.38', NZD),
          isNot(equals(Money.string('-12248.39', NZD))));

      expect(Money.unavailable(NZD), equals(Money.unavailable(NZD)));
      expect(Money.unavailable(NZD),
          isNot(equals(Money.string('-12248.39', NZD))));
      expect(Money.unavailable(NZD),
          isNot(equals(Money.string('-12248.39', JPY))));
      expect(Money.unavailable(NZD), isNot(equals(Money.unavailable(JPY))));
    });

    test('<lessthan', () {
      expect(Money.string('0.00', NZD) < Money.string('0.00', NZD), isFalse);
      expect(Money.string('0.00', NZD) < Money.string('0.01', NZD), isTrue);

      expect(Money.string('1.54', NZD) < Money.string('1.54', NZD), isFalse);
      expect(Money.string('1.53', NZD) < Money.string('1.54', NZD), isTrue);

      expect(Money.string('12248.39', NZD) < Money.string('12248.39', NZD),
          isFalse);
      expect(Money.string('12248.38', NZD) < Money.string('12248.39', NZD),
          isTrue);

      expect(Money.string('-12248.39', NZD) < Money.string('-12248.39', NZD),
          isFalse);
      expect(Money.string('-12248.39', NZD) < Money.string('-12248.38', NZD),
          isTrue);

      expect(Money.unavailable(NZD) < Money.unavailable(NZD), isFalse);
      expect(Money.unavailable(NZD) < Money.string('-12248.39', NZD), isFalse);
      expect(Money.string('-12248.39', NZD) < Money.unavailable(NZD), isFalse);

      expect(Money.string('0', JPY) < Money.string('0', JPY), isFalse);
      expect(Money.string('162', JPY) < Money.string('163', JPY), isTrue);
      expect(Money.string('163', JPY) < Money.string('162', JPY), isFalse);
    });

    test('<=lessthanequal', () {
      expect(Money.string('0.00', NZD) <= Money.string('0.00', NZD), isTrue);
      expect(Money.string('0.00', NZD) <= Money.string('0.01', NZD), isTrue);
      expect(Money.string('0.01', NZD) <= Money.string('0.01', NZD), isTrue);
      expect(Money.string('0.02', NZD) <= Money.string('0.01', NZD), isFalse);

      expect(Money.string('1.54', NZD) <= Money.string('1.54', NZD), isTrue);
      expect(Money.string('1.53', NZD) <= Money.string('1.54', NZD), isTrue);
      expect(Money.string('1.55', NZD) <= Money.string('1.54', NZD), isFalse);

      expect(Money.string('12248.39', NZD) <= Money.string('12248.39', NZD),
          isTrue);
      expect(Money.string('12248.40', NZD) <= Money.string('12248.39', NZD),
          isFalse);
      expect(Money.string('12248.38', NZD) <= Money.string('12248.39', NZD),
          isTrue);

      expect(Money.string('-12248.39', NZD) <= Money.string('-12248.39', NZD),
          isTrue);
      expect(Money.string('-12248.40', NZD) <= Money.string('-12248.39', NZD),
          isTrue);
      expect(Money.string('-12248.39', NZD) <= Money.string('-12248.38', NZD),
          isTrue);
      expect(Money.string('-12248.37', NZD) <= Money.string('-12248.38', NZD),
          isFalse);

      expect(Money.unavailable(NZD) <= Money.unavailable(NZD), isTrue);
      expect(Money.unavailable(NZD) <= Money.string('-12248.39', NZD), isFalse);
      expect(Money.string('-12248.39', NZD) <= Money.unavailable(NZD), isFalse);
    });

    test('>greaterthan', () {
      expect(Money.string('0.00', NZD) > Money.string('0.00', NZD), isFalse);
      expect(Money.string('0.01', NZD) > Money.string('0.00', NZD), isTrue);

      expect(Money.string('1.54', NZD) > Money.string('1.54', NZD), isFalse);
      expect(Money.string('1.55', NZD) > Money.string('1.54', NZD), isTrue);

      expect(Money.string('12248.39', NZD) > Money.string('12248.39', NZD),
          isFalse);
      expect(Money.string('12248.40', NZD) > Money.string('12248.39', NZD),
          isTrue);

      expect(Money.string('-12248.39', NZD) > Money.string('-12248.39', NZD),
          isFalse);
      expect(Money.string('-12248.37', NZD) > Money.string('-12248.38', NZD),
          isTrue);

      expect(Money.unavailable(NZD) > Money.unavailable(NZD), isFalse);
      expect(Money.unavailable(NZD) > Money.string('-12248.39', NZD), isFalse);
      expect(Money.string('-12248.39', NZD) > Money.unavailable(NZD), isFalse);

      expect(Money.string('0', JPY) > Money.string('0', JPY), isFalse);
      expect(Money.string('163', JPY) > Money.string('162', JPY), isTrue);
      expect(Money.string('162', JPY) > Money.string('163', JPY), isFalse);
    });

    test('>=greaterthanequal', () {
      expect(Money.string('0.00', NZD) >= Money.string('0.00', NZD), isTrue);
      expect(Money.string('0.00', NZD) >= Money.string('0.01', NZD), isFalse);
      expect(Money.string('0.01', NZD) >= Money.string('0.01', NZD), isTrue);
      expect(Money.string('0.00', NZD) >= Money.string('0.01', NZD), isFalse);

      expect(Money.string('1.54', NZD) >= Money.string('1.54', NZD), isTrue);
      expect(Money.string('1.53', NZD) >= Money.string('1.54', NZD), isFalse);
      expect(Money.string('1.55', NZD) >= Money.string('1.54', NZD), isTrue);

      expect(Money.string('12248.39', NZD) >= Money.string('12248.39', NZD),
          isTrue);
      expect(Money.string('12248.40', NZD) >= Money.string('12248.39', NZD),
          isTrue);
      expect(Money.string('12248.38', NZD) >= Money.string('12248.39', NZD),
          isFalse);

      expect(Money.string('-12248.39', NZD) >= Money.string('-12248.39', NZD),
          isTrue);
      expect(Money.string('-12248.40', NZD) >= Money.string('-12248.39', NZD),
          isFalse);
      expect(Money.string('-12248.37', NZD) >= Money.string('-12248.38', NZD),
          isTrue);

      expect(Money.unavailable(NZD) >= Money.unavailable(NZD), isTrue);
      expect(Money.unavailable(NZD) >= Money.string('-12248.39', NZD), isFalse);
      expect(Money.string('-12248.39', NZD) <= Money.unavailable(NZD), isFalse);
    });

    test('compareTo', () {
      expect(Money.string('0.00', NZD).compareTo(Money.string('0.00', NZD)),
          equals(0));
      expect(Money.string('0.00', AUD).compareTo(Money.string('0.00', NZD)),
          equals(-1));
      expect(Money.string('0.00', NZD).compareTo(Money.string('0.00', AUD)),
          equals(1));
      expect(Money.string('0.05', NZD).compareTo(Money.string('0.10', NZD)),
          equals(-10));
      expect(Money.string('0.10', NZD).compareTo(Money.string('0.05', NZD)),
          equals(10));
      expect(Money.unavailable(NZD).compareTo(Money.string('0.05', NZD)),
          equals(-1));
      expect(Money.string('0.10', NZD).compareTo(Money.unavailable(NZD)),
          equals(1));
      expect(Money.unavailable(AUD).compareTo(Money.string('0.05', NZD)),
          equals(-1));
      expect(Money.string('0.10', NZD).compareTo(Money.unavailable(AUD)),
          equals(1));
      expect(Money.unavailable(AUD).compareTo(Money.unavailable(AUD)), equals
        (0));
      expect(Money.unavailable(AUD).compareTo(Money.unavailable(NZD)), equals
        (-1));
      expect(Money.unavailable(NZD).compareTo(Money.unavailable(AUD)), equals
        (1));
    });
  });

  test('hashable', () {
    expect(Money.string('94.19', NZD).hashCode, equals(200368497));
    expect(Money.string('94', JPY).hashCode, equals(980361367));
    expect(Money.string('-95.58', NZD).hashCode, equals(92094744));
    expect(Money.string('-95', JPY).hashCode, equals(611092710));
    expect(Money.unavailable(NZD).hashCode, equals(410130625));
    expect(Money.unavailable(JPY).hashCode, equals(585415327));
  });

  test('negate', () {
    expect(-Money.string('94.19', NZD), equals(Money.string('-94.19', NZD)));
    expect(-Money.string('-94.19', NZD), equals(Money.string('94.19', NZD)));
    expect(-Money.string('0.00', NZD), equals(Money.string('0.00', NZD)));
    expect(-Money.string('-0.00', NZD), equals(Money.string('0.00', NZD)));
  });

  test('add2dp', () {
    expect(Money.string('0.00', NZD) + Money.string('0.00', NZD),
        equals(Money.string('0.00', NZD)));
    expect(Money.string('0.01', NZD) + Money.string('0.02', NZD),
        equals(Money.string('0.03', NZD)));
    expect(Money.string('150.29', NZD) + Money.string('-294.19', NZD),
        equals(Money.string('-143.90', NZD)));

    // Adding a real amount and an unavailable amount always equals an unavailable amount
    expect(Money.string('150.29', NZD) + Money.unavailable(NZD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) + Money.string('150.29', NZD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) + Money.unavailable(NZD),
        equals(Money.unavailable(NZD)));
    expect(Money.string('150.29', NZD) + Money.unavailable(AUD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) + Money.string('150.29', AUD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) + Money.unavailable(AUD),
        equals(Money.unavailable(NZD)));
  });

  test('minus2dp', () {
    expect(Money.string('0.00', NZD) - Money.string('0.00', NZD),
        equals(Money.string('0.00', NZD)));
    expect(Money.string('0.01', NZD) - Money.string('0.02', NZD),
        equals(Money.string('-0.01', NZD)));
    expect(Money.string('150.29', NZD) - Money.string('-294.19', NZD),
        equals(Money.string('444.48', NZD)));

    // Adding a real amount and an unavailable amount always equals an unavailable amount
    expect(Money.string('150.29', NZD) - Money.unavailable(NZD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) - Money.string('150.29', NZD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) - Money.unavailable(NZD),
        equals(Money.unavailable(NZD)));
    expect(Money.string('150.29', NZD) - Money.unavailable(AUD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) - Money.string('150.29', AUD),
        equals(Money.unavailable(NZD)));
    expect(Money.unavailable(NZD) - Money.unavailable(AUD),
        equals(Money.unavailable(NZD)));
  });
}
