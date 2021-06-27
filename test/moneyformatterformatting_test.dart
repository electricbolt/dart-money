// moneyformatterformatting_test.dart
// Money Copyright © 2021; Electric Bolt Limited.

import 'package:money/src/currency.dart';
import 'package:money/src/currencymanager.dart';
import 'package:money/src/moneyformatter.dart';
import 'package:test/test.dart';

late MoneyFormatter formatter;

void expectFormat(String value, String expected,
    {bool symbols = true, bool grouping = true, bool negative = true}) {
  var d = formatter.parse(value);
  var valueString = formatter.format(d,
      symbols: symbols, grouping: grouping, negative: negative);
  if (valueString != expected) {
    fail('\'$value\' (\'$valueString\') did not match expected \'$expected\'');
  }
}

void main() {
  test('format0DP', () {
    formatter = MoneyFormatter(CurrencyManager().get('JPY')!);
    expectFormat('0', '￥0');
    expectFormat('1', '￥1');
    expectFormat('12', '￥12');
    expectFormat('123', '￥123');
    expectFormat('1234', '￥1,234');
    expectFormat('12345', '￥12,345');
    expectFormat('123456', '￥123,456');
    expectFormat('1234567', '￥1,234,567');
    expectFormat('12345678', '￥12,345,678');
    expectFormat('123456789', '￥123,456,789');
    expectFormat('1234567890', '￥1,234,567,890');

    expectFormat('-1', '-￥1');
    expectFormat('-12', '-￥12');
    expectFormat('-123', '-￥123');
    expectFormat('-1234', '-￥1,234');
    expectFormat('-12345', '-￥12,345');
    expectFormat('-123456', '-￥123,456');
    expectFormat('-1234567', '-￥1,234,567');
    expectFormat('-12345678', '-￥12,345,678');
    expectFormat('-123456789', '-￥123,456,789');
    expectFormat('-1234567890', '-￥1,234,567,890');

    expectFormat('1', '1', symbols: false);
    expectFormat('-1', '-1', symbols: false);

    expectFormat('1234', '￥1234', grouping: false);
    expectFormat('-1234', '-￥1234', grouping: false);

    expectFormat('1234', '￥1,234', negative: false);
    expectFormat('-1234', '￥1,234', negative: false);

    expectFormat('1234', '￥1,234');
    expectFormat('-1234', '-￥1,234');

    expectFormat('1234', '1,234', symbols: false);
    expectFormat('-1234', '-1,234', symbols: false);

    expectFormat('1234', '1234', symbols: false, grouping: false);
    expectFormat('-1234', '-1234', symbols: false, grouping: false);

    expectFormat('1234', '1234',
        symbols: false, grouping: false, negative: false);
    expectFormat('-1234', '1234',
        symbols: false, grouping: false, negative: false);
  });

  test('format2DP', () {
    formatter = MoneyFormatter(CurrencyManager().get('NZD')!);

    expectFormat('0.12', '\$0.12');
    expectFormat('1.23', '\$1.23');
    expectFormat('12.34', '\$12.34');
    expectFormat('123.45', '\$123.45');
    expectFormat('1234.56', '\$1,234.56');
    expectFormat('12345.67', '\$12,345.67');
    expectFormat('123456.78', '\$123,456.78');
    expectFormat('1234567.89', '\$1,234,567.89');
    expectFormat('12345678.90', '\$12,345,678.90');
    expectFormat('123456789.01', '\$123,456,789.01');
    expectFormat('1234567890.12', '\$1,234,567,890.12');

    expectFormat('-0.12', '-\$0.12');
    expectFormat('-1.23', '-\$1.23');
    expectFormat('-12.34', '-\$12.34');
    expectFormat('-123.45', '-\$123.45');
    expectFormat('-1234.56', '-\$1,234.56');
    expectFormat('-12345.67', '-\$12,345.67');
    expectFormat('-123456.78', '-\$123,456.78');
    expectFormat('-1234567.89', '-\$1,234,567.89');
    expectFormat('-12345678.90', '-\$12,345,678.90');
    expectFormat('-123456789.01', '-\$123,456,789.01');
    expectFormat('-1234567890.12', '-\$1,234,567,890.12');

    expectFormat('1.23', '1.23', symbols: false);
    expectFormat('-1.23', '-1.23', symbols: false);

    expectFormat('1234.56', '\$1234.56', grouping: false);
    expectFormat('-1234.56', '-\$1234.56', grouping: false);

    expectFormat('1234.56', '\$1,234.56', negative: false);
    expectFormat('-1234.56', '\$1,234.56', negative: false);

    expectFormat('1234.56', '1234.56',
        symbols: false, grouping: false, negative: false);
    expectFormat('-1234.56', '1234.56',
        symbols: false, grouping: false, negative: false);
  });

  test('test3DPAndSuffixUnicode', () {
    // Unicode characters. 1f496=sparkling heart (💖)
    formatter = MoneyFormatter(Currency(
        'BST', 'BST bs', ' ', '', '\u{1f496}bs', 3, '', '', '', '', ''));

    expectFormat('0.123', '0.123\u{1f496}bs');
    expectFormat('1.234', '1.234\u{1f496}bs');
    expectFormat('12.345', '12.345\u{1f496}bs');
    expectFormat('123.456', '123.456\u{1f496}bs');
    expectFormat('1234.567', '1,234.567\u{1f496}bs');
    expectFormat('12345.678', '12,345.678\u{1f496}bs');
    expectFormat('123456.789', '123,456.789\u{1f496}bs');
    expectFormat('1234567.890', '1,234,567.890\u{1f496}bs');
    expectFormat('12345678.901', '12,345,678.901\u{1f496}bs');
    expectFormat('123456789.012', '123,456,789.012\u{1f496}bs');
    expectFormat('1234567890.123', '1,234,567,890.123\u{1f496}bs');

    expectFormat('-0.123', '-0.123\u{1f496}bs');
    expectFormat('-1.234', '-1.234\u{1f496}bs');
    expectFormat('-12.345', '-12.345\u{1f496}bs');
    expectFormat('-123.456', '-123.456\u{1f496}bs');
    expectFormat('-1234.567', '-1,234.567\u{1f496}bs');
    expectFormat('-12345.678', '-12,345.678\u{1f496}bs');
    expectFormat('-123456.789', '-123,456.789\u{1f496}bs');
    expectFormat('-1234567.890', '-1,234,567.890\u{1f496}bs');
    expectFormat('-12345678.901', '-12,345,678.901\u{1f496}bs');
    expectFormat('-123456789.012', '-123,456,789.012\u{1f496}bs');
    expectFormat('-1234567890.123', '-1,234,567,890.123\u{1f496}bs');

    expectFormat('1.234', '1.234', symbols: false);
    expectFormat('-1.234', '-1.234', symbols: false);

    expectFormat('1234.567', '1234.567\u{1f496}bs', grouping: false);
    expectFormat('-1234.567', '-1234.567\u{1f496}bs', grouping: false);

    expectFormat('1234.567', '1,234.567\u{1f496}bs', negative: false);
    expectFormat('-1234.567', '1,234.567\u{1f496}bs', negative: false);

    expectFormat('1234.567', '1,234.567', symbols: false);
    expectFormat('-1234.567', '-1,234.567', symbols: false);

    expectFormat('1234.567', '1234.567',
        symbols: false, grouping: false, negative: false);
    expectFormat('-1234.567', '1234.567',
        symbols: false, grouping: false, negative: false);
  });
}
