// moneyformatter.dart
// Money Copyright © 2021; Electric Bolt Limited.

import 'package:decimal/decimal.dart';
import 'package:money/src/decimalbuilder.dart';
import 'package:money/src/stringutil.dart';
import 'package:money/src/currency.dart';
import 'package:money/src/currencymanager.dart';

/// MoneyParseException is thrown on errors when parsing String amounts into
/// Decimal values using the parse(String) method.

class MoneyParseException implements Exception {
  final Object? _nested;
  final String? _message;

  MoneyParseException(String message)
      : _nested = null,
        _message = message;

  MoneyParseException.nested(Object nested)
      : _nested = nested,
        _message = null;

  @override
  String toString() {
    if (_nested != null) {
      return '$_nested';
    } else {
      return '$_message';
    }
  }
}

/// A concrete implementation of a NSFormatter that creates, interprets, and
/// validates the textual representation of money amounts.
///
/// NZD formatting examples:      Parsing examples:
///    nan      -> ''             '', 'abc', '￥0' -> nan
///    0        -> '$0.00'        '$0.00' -> 0.00
///    1234.56  -> '$1,234.56'    '1234.56' -> 1234.56
///    -1234.56 -> '-$1,234.56'   '-$1,234.56' -> -1234.56
///
/// JPY Formatting examples:      Parsing examples:
///    nan      -> ''             '', 'abc', '$0.00' -> nan
///    0        -> '￥0'          '￥0' -> 0
///    1234     -> '￥1,234'      '1234' -> 1234
///    -1234    -> '￥1,234'      '-￥1,234' -> -1234
///
/// Formatted textual representations of money amounts are optimized for
/// english locales, and for UX reasons, thousands grouping characters are
/// always represented with a comma character ',' and decimal place separators
/// are always represented with a full stop character '.' (regardless of
/// currency).

class MoneyFormatter {
  final Currency _currency;

  /// By default, all accessibility text output from accessibilityText
  /// (amount, negative) will have the currencies accessibility prefix
  /// prepended. If the currencies accessibility prefix is equal to the
  /// defaultAccessibilityCurrency's prefix, then the prefix will not be
  /// appended. Most financial apps have the notion of domestic currency and
  /// foreign currencies, it is useful in this situation to only append the
  /// prefix for foreign currencies, not to the domestic currency. The
  /// default defaultAccessibilityCurrency is set to NZD.

  static Currency defaultAccessibilityCurrency = CurrencyManager().get('NZD')!;

  MoneyFormatter(Currency currency) : _currency = currency;

  /// Parses the string for an [amount] using the currency object attached to
  /// the MoneyFormatter instance. If the string was parsed correctly, then a
  /// Decimal is returned with the amount set correctly. If the string failed to
  /// be parsed, then a [MoneyParseException] is thrown, with the message of the
  /// string set to one of the following:
  /// - Unexpected grouping separator character ',' for input string '...'
  /// - Invalid character '?' for input string '...'
  /// - Too many fractional digits for input string '...'
  /// - Too many digits for input string '...'
  /// - Unexpected decimal separator character '.' for input string '...'
  /// - Digits expected, none found for input string '...'

  Decimal parse(String amount) {
    var s = amount;
    var builder = DecimalBuilder(_currency.exponent, s.startsWith('-'));
    s = s.removePrefix('-');
    s = s.removePrefix(_currency.symbolPrefix);
    s = s.removeSuffix(_currency.symbolSuffix);

    try {
      for (var i = 0; i < s.length; i++) {
        var c = s[i];
        var codeUnit = c.codeUnitAt(0);
        if (codeUnit >= 0x30 && codeUnit <= 0x39) {
          builder.addDigit(c);
        } else {
          switch (c) {
            case ',':
              if (builder.isFractional) {
                throw FormatException('Unexpected grouping separator '
                    'character \',\'');
              }
              break;
            case '.':
              builder.setFractional();
              break;
            default:
              throw FormatException('Invalid character \'$c\'');
          }
        }
      }
      return builder.build();
    } on FormatException catch (e) {
      throw MoneyParseException(e.message + ' for input string \'$amount\'');
    }
  }

  /// Formats the decimal [amount] using the currency object attached to the
  /// MoneyFormatter instance and returns the textual representation or '' if
  /// the amount is unavailable.
  /// [amount] for which a textual representation is returned.
  /// [symbols] specify true to prepend any symbol prefix or append any symbol
  /// suffix as specified by the currency object's symbolPrefix and
  /// symbolSuffix properties.
  /// [grouping] specify true to separate groups of digits using ',' character.
  /// [negative] specify true to prepend a negative sign if the amount is
  /// negative.

  String format(Decimal? amount,
      {bool symbols = true, bool grouping = true, bool negative = true}) {
    if (amount == null) {
      return '';
    }
    var s = amount.toStringAsFixed(_currency.exponent);
    var amountNegative = s.startsWith('-');
    if (grouping) {
      var whole = amountNegative ? s.substring(1) : s;
      var fractional = '';
      if (_currency.exponent > 0) {
        fractional = whole.substring(whole.length - _currency.exponent - 1);
        whole = whole.substring(0, whole.length - (_currency.exponent + 1));
      }
      if (whole.length > 3) {
        var buf = StringBuffer();
        var i = whole.length - 1;
        var count = 1;
        while (i >= 0) {
          var c = whole[i];
          buf.write(c);
          if (count % 3 == 0 && i != 0) {
            buf.write(',');
          }
          i--;
          count++;
        }
        whole = buf.toString().reverse();
      }
      s = (amountNegative ? '-' : '') + whole + fractional;
    }
    if (symbols) {
      s = s.insert(_currency.symbolPrefix, amountNegative ? 1 : 0);
      s = s + _currency.symbolSuffix;
    }
    if (!negative) {
      s = s.removePrefix('-');
    }
    return s;
  }
}

extension MoneyFormatterAccessibility on MoneyFormatter {

  /// Returns the textual string used for voiceover of an [amount]. e.g.
  /// '-$523.84 NZD' is returned as 'new zealand negative five hundred and
  /// twenty three dollars and eighty four cents'. Zero whole and fractional
  /// amounts return optimized text as follows:
  /// 0.00 is returned as 'zero dollars' instead of 'zero dollars and zero
  /// cents'. 1.00 is returned as 'one dollar' instead of 'one dollar and
  /// zero cents'. 0.15 is returned as 'fifteen cents' instead of 'zero
  /// dollars and fifteen cents'. [negative] specify true to prepend a
  /// 'negative' text if the amount is negative. [prefix] specify true to
  /// append the currencies accessibility suffix if the currency is not the
  /// defaultAccessibilityCurrency. Specify false to never include the prefix.
  /// Returns '' if there was an error formatting the string, or if an
  /// unavailable amount.

  String accessibilityText(Decimal? amount, {negative = true, prefix = true}) {
    var s = format(amount, symbols: false, grouping: false, negative:
      false);
    if (s.isEmpty) {
      return '';
    }

    var result = (prefix && _currency != MoneyFormatter
        .defaultAccessibilityCurrency) ? _currency.prefix : '';
    result += ' ' + (negative && amount!.isNegative ? 'negative ' : '');

    var whole = int.parse(_currency.exponent > 0 ? s.substring(0, (s.length -
        _currency.exponent) - 1) : s);
    var fractional = int.parse(_currency.exponent > 0 ? s.substring(s.length -
        _currency.exponent) : '0');

    if (whole == 0 && fractional == 0) {
      result += 'zero ' + _currency.units;
    } else if (whole > 0 && fractional == 0) {
      result += _accessibilityText(whole) + ' ' + (whole == 1 ? _currency
          .unit : _currency.units);
    } else if (whole == 0 && fractional > 0) {
      result += _accessibilityText(fractional) + ' ' + (fractional == 1 ?
      _currency.subunit : _currency.subunits);
    } else {
      result += _accessibilityText(whole) + ' ' + (whole == 1 ? _currency.unit :
      _currency.units) + ' and ' +
          _accessibilityText(fractional) + ' ' + (fractional == 1 ? _currency
          .subunit : _currency.subunits);
    }
    return result.trim();
  }

  /// Recursively constructs a voice over string of the provided integer.

  String _accessibilityText(int amount) {
    final text1To19 = [
      '', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight',
      'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen',
      'sixteen', 'seventeen', 'eighteen', 'nineteen'];
    final text20To99 = ['', '', 'twenty', 'thirty', 'fourty',
      'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];
    final divisorScale = [100, 10, 1000, 1000, 1000, 1000];
    final divisorText = ['', 'hundred', 'thousand', 'million', 'billion',
      'trillion'];

    if (amount == 0) {
      return 'zero';
    }

    var result = '';
    var divisorIndex = 0;
    while (amount > 0) {
      final val = amount % divisorScale[divisorIndex];
      amount = amount ~/ divisorScale[divisorIndex];
      if (val > 0) {
        var number = '';
        if (val >= 0 && val <= 19) {
          number = text1To19[val];
        } else if (val >= 20 && val <= 99) {
          number = text20To99[val ~/ 10] + (val % 10 > 0 ? ' ' +
              text1To19[val % 10] : '');
        } else {
          number = _accessibilityText(val);
        }
        result = (amount > 0 && divisorIndex == 0 ? 'and ' : '') + number + ' '
            + divisorText[divisorIndex] + ' ' + result;
      }
      divisorIndex++;
    }

    return result.trim();
  }

}