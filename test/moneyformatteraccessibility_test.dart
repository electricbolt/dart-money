// moneyformatteraccessibility_test.dart
// Money Copyright © 2021; Electric Bolt Limited.

import 'package:decimal/decimal.dart';
import 'package:money/money.dart';
import 'package:money/src/currency.dart';
import 'package:money/src/currencymanager.dart';
import 'package:money/src/moneyformatter.dart';
import 'package:test/test.dart';

late Currency currency;
late MoneyFormatter formatter;

void expectText(String amount, String expectedText, {bool negative = true}) {
  var decimal = Decimal.parse(amount);
  var accessibilityText =
      formatter.accessibilityText(decimal, negative: negative);
  expect(accessibilityText, equals(expectedText));
}

void main() {
  currency = CurrencyManager().get('NZD')!;
  formatter = MoneyFormatter(currency);

  test('0_To_99', () {
    expectText('0', 'zero dollars');
    expectText('1', 'one dollar');
    expectText('2', 'two dollars');
    expectText('3', 'three dollars');
    expectText('4', 'four dollars');
    expectText('5', 'five dollars');
    expectText('6', 'six dollars');
    expectText('7', 'seven dollars');
    expectText('8', 'eight dollars');
    expectText('9', 'nine dollars');
    expectText('10', 'ten dollars');
    expectText('11', 'eleven dollars');
    expectText('12', 'twelve dollars');
    expectText('13', 'thirteen dollars');
    expectText('14', 'fourteen dollars');
    expectText('15', 'fifteen dollars');
    expectText('16', 'sixteen dollars');
    expectText('17', 'seventeen dollars');
    expectText('18', 'eighteen dollars');
    expectText('19', 'nineteen dollars');
    expectText('20', 'twenty dollars');
    expectText('21', 'twenty one dollars');
    expectText('29', 'twenty nine dollars');
    expectText('30', 'thirty dollars');
    expectText('31', 'thirty one dollars');
    expectText('39', 'thirty nine dollars');
    expectText('40', 'fourty dollars');
    expectText('41', 'fourty one dollars');
    expectText('49', 'fourty nine dollars');
    expectText('50', 'fifty dollars');
    expectText('51', 'fifty one dollars');
    expectText('59', 'fifty nine dollars');
    expectText('60', 'sixty dollars');
    expectText('61', 'sixty one dollars');
    expectText('69', 'sixty nine dollars');
    expectText('70', 'seventy dollars');
    expectText('71', 'seventy one dollars');
    expectText('79', 'seventy nine dollars');
    expectText('80', 'eighty dollars');
    expectText('81', 'eighty one dollars');
    expectText('89', 'eighty nine dollars');
    expectText('90', 'ninety dollars');
    expectText('91', 'ninety one dollars');
    expectText('99', 'ninety nine dollars');
  });

  test('100_to_999', () {
    expectText('100', 'one hundred dollars');
    expectText('101', 'one hundred and one dollars');
    expectText('102', 'one hundred and two dollars');
    expectText('109', 'one hundred and nine dollars');
    expectText('110', 'one hundred and ten dollars');
    expectText('111', 'one hundred and eleven dollars');
    expectText('119', 'one hundred and nineteen dollars');
    expectText('120', 'one hundred and twenty dollars');
    expectText('121', 'one hundred and twenty one dollars');
    expectText('129', 'one hundred and twenty nine dollars');
    expectText('130', 'one hundred and thirty dollars');
    expectText('131', 'one hundred and thirty one dollars');
    expectText('139', 'one hundred and thirty nine dollars');
    expectText('140', 'one hundred and fourty dollars');
    expectText('141', 'one hundred and fourty one dollars');
    expectText('149', 'one hundred and fourty nine dollars');
    expectText('150', 'one hundred and fifty dollars');
    expectText('151', 'one hundred and fifty one dollars');
    expectText('159', 'one hundred and fifty nine dollars');
    expectText('160', 'one hundred and sixty dollars');
    expectText('161', 'one hundred and sixty one dollars');
    expectText('169', 'one hundred and sixty nine dollars');
    expectText('170', 'one hundred and seventy dollars');
    expectText('171', 'one hundred and seventy one dollars');
    expectText('179', 'one hundred and seventy nine dollars');
    expectText('180', 'one hundred and eighty dollars');
    expectText('181', 'one hundred and eighty one dollars');
    expectText('189', 'one hundred and eighty nine dollars');
    expectText('190', 'one hundred and ninety dollars');
    expectText('191', 'one hundred and ninety one dollars');
    expectText('199', 'one hundred and ninety nine dollars');
    expectText('200', 'two hundred dollars');
    expectText('201', 'two hundred and one dollars');
    expectText('210', 'two hundred and ten dollars');
    expectText('219', 'two hundred and nineteen dollars');
    expectText('220', 'two hundred and twenty dollars');
    expectText('230', 'two hundred and thirty dollars');
    expectText('231', 'two hundred and thirty one dollars');
    expectText('240', 'two hundred and fourty dollars');
    expectText('250', 'two hundred and fifty dollars');
    expectText('260', 'two hundred and sixty dollars');
    expectText('270', 'two hundred and seventy dollars');
    expectText('280', 'two hundred and eighty dollars');
    expectText('290', 'two hundred and ninety dollars');
    expectText('299', 'two hundred and ninety nine dollars');
    expectText('300', 'three hundred dollars');
    expectText('326', 'three hundred and twenty six dollars');
    expectText('352', 'three hundred and fifty two dollars');
    expectText('571', 'five hundred and seventy one dollars');
    expectText('600', 'six hundred dollars');
    expectText('700', 'seven hundred dollars');
    expectText('800', 'eight hundred dollars');
    expectText('900', 'nine hundred dollars');
    expectText('999', 'nine hundred and ninety nine dollars');
  });

  test('1,000_to_1,999', () {
    expectText('1000', 'one thousand dollars');
    expectText('1001', 'one thousand and one dollars');
    expectText('1194', 'one thousand one hundred and ninety four dollars');
    expectText('2365', 'two thousand three hundred and sixty five dollars');
    expectText('3401', 'three thousand four hundred and one dollars');
    expectText('4010', 'four thousand and ten dollars');
    expectText('5602', 'five thousand six hundred and two dollars');
    expectText('6099', 'six thousand and ninety nine dollars');
    expectText('7150', 'seven thousand one hundred and fifty dollars');
    expectText('8000', 'eight thousand dollars');
    expectText('9998', 'nine thousand nine hundred and ninety eight dollars');
  });

  test('10,000_to_99,999', () {
    expectText('10000', 'ten thousand dollars');
    expectText('11451', 'eleven thousand four hundred and fifty one dollars');
    expectText('12002', 'twelve thousand and two dollars');
    expectText(
        '19999', 'nineteen thousand nine hundred and ninety nine dollars');
    expectText('20000', 'twenty thousand dollars');
    expectText('20001', 'twenty thousand and one dollars');
    expectText('21001', 'twenty one thousand and one dollars');
    expectText(
        '22875', 'twenty two thousand eight hundred and seventy five dollars');
    expectText('30156', 'thirty thousand one hundred and fifty six dollars');
    expectText('90010', 'ninety thousand and ten dollars');
    expectText(
        '99999', 'ninety nine thousand nine hundred and ninety nine dollars');
  });

  test('100,000_to_999,999', () {
    expectText('100000', 'one hundred thousand dollars');
    expectText(
        '109605', 'one hundred and nine thousand six hundred and five dollars');
    expectText('112415',
        'one hundred and twelve thousand four hundred and fifteen dollars');
    expectText('120003', 'one hundred and twenty thousand and three dollars');
    expectText(
        '122007', 'one hundred and twenty two thousand and seven dollars');
    expectText(
        '198634',
        'one hundred and ninety eight thousand six hundred and thirty four '
            'dollars');
    expectText('200000', 'two hundred thousand dollars');
    expectText('200002', 'two hundred thousand and two dollars');
    expectText(
        '215709',
        'two hundred and fifteen thousand seven hundred and '
            'nine dollars');
    expectText(
        '999999',
        'nine hundred and ninety nine thousand nine hundred '
            'and ninety nine dollars');
  });

  test('1,000,000_to_99,999,999', () {
    expectText('1000000', 'one million dollars');
    expectText('1000009', 'one million and nine dollars');
    expectText(
        '1109605',
        'one million one hundred and nine thousand six'
            ' hundred and five dollars');
    expectText(
        '2112415',
        'two million one hundred and twelve thousand four '
            'hundred and fifteen dollars');
    expectText(
        '5120003',
        'five million one hundred and twenty thousand and '
            'three dollars');
    expectText(
        '8122007',
        'eight million one hundred and twenty two thousand '
            'and seven dollars');
    expectText(
        '9198634',
        'nine million one hundred and ninety eight thousand '
            'six hundred and thirty four dollars');
    expectText('10100000', 'ten million one hundred thousand dollars');
    expectText(
        '11600152',
        'eleven million six hundred thousand one hundred and '
            'fifty two dollars');
    expectText(
        '20915709',
        'twenty million nine hundred and fifteen thousand '
            'seven hundred and nine dollars');
    expectText(
        '35499999',
        'thirty five million four hundred and ninety nine '
            'thousand nine hundred and ninety nine dollars');
    expectText('99006000', 'ninety nine million six thousand dollars');
  });

  test('100,000,000_to_999,999,999', () {
    expectText('100000000', 'one hundred million dollars');
    expectText('100000009', 'one hundred million and nine dollars');
    expectText(
        '115109605',
        'one hundred and fifteen million one hundred and '
            'nine thousand six hundred and five dollars');
    expectText(
        '277112415',
        'two hundred and seventy seven million one hundred'
            ' and twelve thousand four hundred and fifteen dollars');
    expectText(
        '999999999',
        'nine hundred and ninety nine million nine hundred'
            ' and ninety nine thousand nine hundred and ninety nine dollars');
  });

  test('1,000,000,000_To_999,999,999,999', () {
    expectText('1000000000', 'one billion dollars');
    expectText(
        '1111111111',
        'one billion one hundred and eleven million one '
            'hundred and eleven thousand one hundred and eleven dollars');
    expectText('19000000001', 'nineteen billion and one dollars');
    expectText(
        '99757000038',
        'ninety nine billion seven hundred and fifty '
            'seven million and thirty eight dollars');
    expectText(
        '486757968262',
        'four hundred and eighty six billion seven '
            'hundred and fifty seven million nine hundred and sixty eight '
            'thousand two hundred and sixty two dollars');
  });

  test('1,000,000,000,000_To_9,999,999,999,999', () {
    expectText('1000000000000', 'one trillion dollars');
    expectText(
        '8401111111111',
        'eight trillion four hundred and one billion '
            'one hundred and eleven million one hundred and eleven thousand one '
            'hundred and eleven dollars');
  });

  test('nan', () {
    var accessibilityText = formatter.accessibilityText(null);
    expect(accessibilityText, equals(''));
  });

  test('NZD', () {
    // no negative
    expectText('-1.01', 'one dollar and one cent', negative: false);
    expectText(
        '-249.33',
        'two hundred and fourty nine dollars and thirty '
            'three cents',
        negative: false);

    // negative
    expectText('-1.01', 'negative one dollar and one cent');
    expectText(
        '-249.33',
        'negative two hundred and fourty nine dollars and '
            'thirty three cents');

    // singular
    expectText('-1.01', 'negative one dollar and one cent');
    expectText('1.01', 'one dollar and one cent');

    // plural
    expectText('2.02', 'two dollars and two cents');
    expectText(
        '493.58',
        'four hundred and ninety three dollars and fifty '
            'eight cents');
    expectText(
        '1391.29',
        'one thousand three hundred and ninety one dollars '
            'and twenty nine cents');

    // whole and fractional optimizations
    expectText('0.00', 'zero dollars');
    expectText('1.00', 'one dollar');
    expectText('2.00', 'two dollars');
    expectText('5192.00', 'five thousand one hundred and ninety two dollars');
    expectText('0.01', 'one cent');
    expectText('0.02', 'two cents');
    expectText('0.98', 'ninety eight cents');
  });

  test('JPY', () {
    formatter = MoneyFormatter(CurrencyManager().get('JPY')!);

    // no negative
    expectText('-1', 'japanese one yen', negative: false);
    expectText('-249', 'japanese two hundred and fourty nine yen',
        negative: false);

    // negative
    expectText('-1', 'japanese negative one yen');
    expectText('-249', 'japanese negative two hundred and fourty nine yen');

    // singular
    expectText('-1', 'japanese negative one yen');
    expectText('1', 'japanese one yen');

    // plural
    expectText('2', 'japanese two yen');
    expectText('493', 'japanese four hundred and ninety three yen');
    expectText(
        '1391', 'japanese one thousand three hundred and ninety one yen');
  });

  test('Money', () {
    var money = Money.string('-523.84', CurrencyManager().get('NZD')!);
    expect('negative five hundred and twenty three dollars and eighty four '
        'cents', money.accessibilityText());
  });

  test('defaultAccessibilityCurrency', () {
    MoneyFormatter.defaultAccessibilityCurrency = CurrencyManager().get('AUD')!;
    var money = Money.string('-523.84', CurrencyManager().get('NZD')!);
    expect('new zealand negative five hundred and twenty three dollars and '
        'eighty four cents', money.accessibilityText());
  });
}
