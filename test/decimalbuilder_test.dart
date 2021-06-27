// decimalbuilder_test.dart
// MoneyCurrency Copyright © 2021; Electric Bolt Limited.

import 'package:decimal/decimal.dart';
import 'package:moneycurrency/src/decimalbuilder.dart';
import 'package:test/test.dart';

void expectAmount(String expectedAmount, Decimal actualAmount) {
  expect(actualAmount, equals(Decimal.parse(expectedAmount)));
}

void main() {
  test('builder0DP', () {
    var builder = DecimalBuilder(0, false);
    builder.addDigit('1');
    expectAmount('1', builder.build());
    builder.addDigit('2');
    expectAmount('12', builder.build());
    builder.addDigit('3');
    expectAmount('123', builder.build());
    builder.addDigit('4');
    expectAmount('1234', builder.build());

    expect(
        () => builder.setFractional(),
        throwsA((e) =>
            e is FormatException &&
            e.message == 'Unexpected decimal separator character \'.\''));
  });

  test('builder1DP', () {
    var builder = DecimalBuilder(1, false);
    builder.addDigit('1');
    expectAmount('1.0', builder.build());
    builder.addDigit('2');
    expectAmount('12.0', builder.build());
    builder.addDigit('3');
    expectAmount('123.0', builder.build());
    builder.addDigit('4');
    expectAmount('1234.0', builder.build());
    builder.setFractional();
    builder.addDigit('5');
    expectAmount('1234.5', builder.build());

    expect(
        () => builder.addDigit('6'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Too many fractional digits')));
  });

  test('builder2DP', () {
    var builder = DecimalBuilder(2, false);
    builder.addDigit('1');
    expectAmount('1.00', builder.build());
    builder.addDigit('2');
    expectAmount('12.00', builder.build());
    builder.addDigit('3');
    expectAmount('123.00', builder.build());
    builder.addDigit('4');
    expectAmount('1234.00', builder.build());
    builder.setFractional();
    builder.addDigit('5');
    expectAmount('1234.50', builder.build());
    builder.addDigit('6');
    expectAmount('1234.56', builder.build());

    expect(
        () => builder.addDigit('7'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Too many fractional digits')));
  });

  test('builder3DP', () {
    var builder = DecimalBuilder(3, false);
    builder.addDigit('1');
    expectAmount('1.000', builder.build());
    builder.addDigit('2');
    expectAmount('12.000', builder.build());
    builder.addDigit('3');
    expectAmount('123.000', builder.build());
    builder.addDigit('4');
    expectAmount('1234.000', builder.build());
    builder.setFractional();
    builder.addDigit('5');
    expectAmount('1234.500', builder.build());
    builder.addDigit('6');
    expectAmount('1234.560', builder.build());
    builder.addDigit('7');
    expectAmount('1234.567', builder.build());

    expect(
        () => builder.addDigit('8'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Too many fractional digits')));
  });

  test('builder4DP', () {
    var builder = DecimalBuilder(4, true);
    builder.addDigit('1');
    expectAmount('-1.0000', builder.build());
    builder.addDigit('2');
    expectAmount('-12.0000', builder.build());
    builder.addDigit('3');
    expectAmount('-123.0000', builder.build());
    builder.addDigit('4');
    expectAmount('-1234.0000', builder.build());
    builder.setFractional();
    builder.addDigit('5');
    expectAmount('-1234.5000', builder.build());
    builder.addDigit('6');
    expectAmount('-1234.5600', builder.build());
    builder.addDigit('7');
    expectAmount('-1234.5670', builder.build());
    builder.addDigit('8');
    expectAmount('-1234.5678', builder.build());

    expect(
        () => builder.addDigit('9'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Too many fractional digits')));
  });

  test('builder5DP', () {
    expect(
        () => DecimalBuilder(-1, false),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Too many fractional digits')));

    expect(
        () => DecimalBuilder(5, false),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Too many fractional digits')));
  });

  test('builderTooManyDigits0DP', () {
    var builder = DecimalBuilder(0, false);
    builder.addDigit('1');
    builder.addDigit('2');
    builder.addDigit('3');
    builder.addDigit('4');
    builder.addDigit('5');
    builder.addDigit('6');
    builder.addDigit('7');
    builder.addDigit('8');
    builder.addDigit('9');
    builder.addDigit('0');
    builder.addDigit('1');
    builder.addDigit('2');
    builder.addDigit('3');
    builder.addDigit('4');
    builder.addDigit('5');
    expect(
        () => builder.addDigit('6'),
        throwsA(predicate(
            (e) => e is FormatException && e.message == 'Too many digits')));
  });

  test('builderTooManyDigits1DP', () {
    var builder = DecimalBuilder(1, false);
    builder.addDigit('1');
    builder.addDigit('2');
    builder.addDigit('3');
    builder.addDigit('4');
    builder.addDigit('5');
    builder.addDigit('6');
    builder.addDigit('7');
    builder.addDigit('8');
    builder.addDigit('9');
    builder.addDigit('0');
    builder.addDigit('1');
    builder.addDigit('2');
    builder.addDigit('3');
    builder.addDigit('4');
    builder.setFractional();
    builder.addDigit('5');
    expect(
        () => builder.addDigit('6'),
        throwsA(predicate(
            (e) => e is FormatException && e.message == 'Too many digits')));
  });

  test('builderTooManyDigits2DP', () {
    var builder = DecimalBuilder(2, false);
    builder.addDigit('1');
    builder.addDigit('2');
    builder.addDigit('3');
    builder.addDigit('4');
    builder.addDigit('5');
    builder.addDigit('6');
    builder.addDigit('7');
    builder.addDigit('8');
    builder.addDigit('9');
    builder.addDigit('0');
    builder.addDigit('1');
    builder.addDigit('2');
    builder.addDigit('3');
    builder.setFractional();
    builder.addDigit('4');
    builder.addDigit('5');
    expect(
        () => builder.addDigit('6'),
        throwsA(predicate(
            (e) => e is FormatException && e.message == 'Too many digits')));
  });
}
