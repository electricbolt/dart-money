// moneyformatterparsing_test.dart
// Money Copyright © 2021; Electric Bolt Limited.

import 'package:decimal/decimal.dart';
import 'package:moneycurrency/src/currency.dart';
import 'package:moneycurrency/src/currencymanager.dart';
import 'package:moneycurrency/src/moneyformatter.dart';
import 'package:test/test.dart';

late MoneyFormatter formatter;

void expectParseError(String value, String error) {
  expect(() => formatter.parse(value),
      throwsA(predicate((e) => e is MoneyParseException && e.toString() ==
          error)));
}

void expectParse(String value, String expected) {
  try {
    var d = formatter.parse(value);
    var expectedDecimal = Decimal.parse(expected);
    if (d != expectedDecimal) {
      fail('\'$value\' did not match expected \'$expected\'');
    }
  } catch (e, s) {
    fail('$e, $s, \'$value\' did not match expected \'$expected\'');
  }
}

void main() {
  test('parseAmounts0DP', () {
    formatter = MoneyFormatter(CurrencyManager().get('JPY')!);
    expectParseError('', 'Digits expected, none found for input string \'\'');
    expectParseError('1.2',
        'Unexpected decimal separator character \'.\' for input string \'1.2\'');
    expectParseError('-1.2',
        'Unexpected decimal separator character \'.\' for input string \'-1.2\'');
    expectParseError('.1',
        'Unexpected decimal separator character \'.\' for input string \'.1\'');
    expectParseError('1.',
        'Unexpected decimal separator character \'.\' for input string \'1.\'');
    expectParseError('-.1',
        'Unexpected decimal separator character \'.\' for input string \'-.1\'');
    expectParseError('-1.',
        'Unexpected decimal separator character \'.\' for input string \'-1.\'');

    expectParseError('1abc', 'Invalid character \'a\' for input string \'1abc\'');
    expectParseError('abc1', 'Invalid character \'a\' for input string \'abc1\'');

    expectParse('1', '1');
    expectParse('12', '12');
    expectParse('123', '123');
    expectParse('1234', '1234');
    expectParse('12345', '12345');
    expectParse('123456', '123456');
    expectParse('1234567', '1234567');
    expectParse('12345678', '12345678');
    expectParse('123456789', '123456789');
    expectParse('1234567890', '1234567890');
    expectParse('12345678901', '12345678901');
    expectParse('123456789012', '123456789012');
    expectParse('1234567890123', '1234567890123');
    expectParse('12345678901234', '12345678901234');
    expectParse('123456789012345', '123456789012345');

    expectParse('-1', '-1');
    expectParse('-12', '-12');
    expectParse('-123', '-123');
    expectParse('-1234', '-1234');
    expectParse('-12345', '-12345');
    expectParse('-123456', '-123456');
    expectParse('-1234567', '-1234567');
    expectParse('-12345678', '-12345678');
    expectParse('-123456789', '-123456789');
    expectParse('-1234567890', '-1234567890');
    expectParse('-12345678901', '-12345678901');
    expectParse('-123456789012', '-123456789012');
    expectParse('-1234567890123', '-1234567890123');
    expectParse('-12345678901234', '-12345678901234');
    expectParse('-123456789012345', '-123456789012345');

    expectParse('1,234', '1234');
    expectParse('12,345', '12345');
    expectParse('123,456', '123456');
    expectParse('1,234,567', '1234567');
    expectParse('12,345,678', '12345678');
    expectParse('123,456,789', '123456789');
    expectParse('1,234,567,890', '1234567890');
    expectParse('12,345,678,901', '12345678901');
    expectParse('123,456,789,012', '123456789012');
    expectParse('1,234,567,890,123', '1234567890123');
    expectParse('12,345,678,901,234', '12345678901234');
    expectParse('123,456,789,012,345', '123456789012345');

    expectParse('-1,234', '-1234');
    expectParse('-12,345', '-12345');
    expectParse('-123,456', '-123456');
    expectParse('-1,234,567', '-1234567');
    expectParse('-12,345,678', '-12345678');
    expectParse('-123,456,789', '-123456789');
    expectParse('-1,234,567,890', '-1234567890');
    expectParse('-12,345,678,901', '-12345678901');
    expectParse('-123,456,789,012', '-123456789012');
    expectParse('-1,234,567,890,123', '-1234567890123');
    expectParse('-12,345,678,901,234', '-12345678901234');
    expectParse('-123,456,789,012,345', '-123456789012345');

    expectParseError('\$1', 'Invalid character \'\$\' for input string \'\$1\'');
    expectParse('￥1', '1');
    expectParseError(
        '￥1.2',
        'Unexpected decimal separator character \'.\' for input string \'￥1.2'
            '\'');
    expectParse('￥12', '12');
    expectParse('￥123', '123');
    expectParse('￥1234', '1234');
    expectParse('￥1,234', '1234');

    expectParse('-￥1', '-1');
    expectParseError(
        '-￥1.2',
        'Unexpected decimal separator character \'.\' for input string \'-￥1'
            '.2\'');
    expectParse('-￥12', '-12');
    expectParse('-￥123', '-123');
    expectParse('-￥1234', '-1234');
    expectParse('-￥1,234', '-1234');
  });

  test('parseAmounts2DP', () {
    formatter = MoneyFormatter(CurrencyManager().get('NZD')!);

    expectParseError('', 'Digits expected, none found for input string \'\'');
    expectParse('1.2', '1.20');
    expectParse('1.23', '1.23');
    expectParseError(
        '1.234',
        'Too many fractional digits for input string \'1.234'
            '\'');
    expectParse('-1.2', '-1.20');
    expectParse('-1.23', '-1.23');
    expectParse('.1', '0.10');
    expectParse('1.', '1.00');
    expectParse('-.1', '-0.10');
    expectParse('-1.', '-1.00');

    expectParseError('1abc', 'Invalid character \'a\' for input string \'1abc\'');
    expectParseError('abc1', 'Invalid character \'a\' for input string \'abc1\'');

    expectParse('1', '1.00');
    expectParse('12', '12.00');
    expectParse('123', '123.00');
    expectParse('1234', '1234.00');
    expectParse('12345', '12345.00');
    expectParse('123456', '123456.00');
    expectParse('1234567', '1234567.00');
    expectParse('12345678', '12345678.00');
    expectParse('123456789', '123456789.00');
    expectParse('1234567890', '1234567890.00');
    expectParse('12345678901', '12345678901.00');
    expectParse('123456789012', '123456789012.00');
    expectParse('1234567890123', '1234567890123.00');
    expectParse('12345678901234', '12345678901234.00');
    expectParse('123456789012345', '123456789012345.00');

    expectParse('-1', '-1.00');
    expectParse('-12', '-12.00');
    expectParse('-123', '-123.00');
    expectParse('-1234', '-1234.00');
    expectParse('-12345', '-12345.00');
    expectParse('-123456', '-123456.00');
    expectParse('-1234567', '-1234567.00');
    expectParse('-12345678', '-12345678.00');
    expectParse('-123456789', '-123456789.00');
    expectParse('-1234567890', '-1234567890.00');
    expectParse('-12345678901', '-12345678901.00');
    expectParse('-123456789012', '-123456789012.00');
    expectParse('-1234567890123', '-1234567890123.00');
    expectParse('-12345678901234', '-12345678901234.00');
    expectParse('-123456789012345', '-123456789012345.00');

    expectParse('1,234', '1234.00');
    expectParse('12,345', '12345.00');
    expectParse('123,456', '123456.00');
    expectParse('1,234,567', '1234567.00');
    expectParse('12,345,678', '12345678.00');
    expectParse('123,456,789', '123456789.00');
    expectParse('1,234,567,890', '1234567890.00');
    expectParse('12,345,678,901', '12345678901.00');
    expectParse('123,456,789,012', '123456789012.00');
    expectParse('1,234,567,890,123', '1234567890123.00');
    expectParse('12,345,678,901,234', '12345678901234.00');
    expectParse('123,456,789,012,345', '123456789012345.00');

    expectParse('-1,234', '-1234.00');
    expectParse('-12,345', '-12345.00');
    expectParse('-123,456', '-123456.00');
    expectParse('-1,234,567', '-1234567.00');
    expectParse('-12,345,678', '-12345678.00');
    expectParse('-123,456,789', '-123456789.00');
    expectParse('-1,234,567,890', '-1234567890.00');
    expectParse('-12,345,678,901', '-12345678901.00');
    expectParse('-123,456,789,012', '-123456789012.00');
    expectParse('-1,234,567,890,123', '-1234567890123.00');
    expectParse('-12,345,678,901,234', '-12345678901234.00');
    expectParse('-123,456,789,012,345', '-123456789012345.00');

    expectParse('\$1', '1.00');
    expectParse('\$1.2', '1.20');
    expectParse('\$1.23', '1.23');
    expectParse('\$12.34', '12.34');
    expectParse('\$123.45', '123.45');
    expectParse('\$1,234.56', '1234.56');

    expectParse('-\$1', '-1.00');
    expectParse('-\$1.2', '-1.20');
    expectParse('-\$1.23', '-1.23');
    expectParse('-\$12.34', '-12.34');
    expectParse('-\$123.45', '-123.45');
    expectParse('-\$1,234.56', '-1234.56');

    expectParseError(
        '1.23.4',
        'Unexpected decimal separator character \'.\' for '
            'input string \'1.23.4\'');
  });

  test('parseAmounts3DPAndSuffixUnicode', () {
    // Unicode characters. 1f496=sparkling heart (💖)
    formatter = MoneyFormatter(Currency(
        'BST', 'BST bs', ' ', '', '\u{1f496}bs', 3, '', '', '', '', ''));

    expectParse('1.2', '1.200');
    expectParse('1.23', '1.230');
    expectParse('1.234', '1.234');
    expectParseError(
        '1.2345',
        'Too many fractional digits for input string '
            '\'1.2345\'');

    expectParse('12.345', '12.345');
    expectParse('123.456', '123.456');
    expectParse('1,234.567', '1234.567');

    expectParse('-1,234.567', '-1234.567');
    expectParse('-1,234.567\u{1f496}bs', '-1234.567');
  });
}
