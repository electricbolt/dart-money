// moneycurrency.dart
// MoneyCurrency Copyright © 2021; Electric Bolt Limited.

import 'package:decimal/decimal.dart';
import 'moneyformatter.dart';
import 'currency.dart';

/// A Money is a value object that represents an amount and an associated
/// currency. Amounts either represent a real value (e.g. -$1927.10, ￥10,
/// £1.56, 0.00kr.) or are unavailable (e.g. have no numerical value).
///
///  ☞ In many financial applications, host systems can be unavailable
/// throughout the day due to batch jobs running etc, and for this reason,
/// amounts have notion of being unavailable.
///
/// Money objects can be compared, hashed, added and subtracted. Using a
/// MoneyFormatter class, Money objects can be converted to and from strings.

class Money implements Comparable {
  late Decimal? _amount;

  late Currency _currency;

  /// Initializes a Money object with an unavailable amount.

  Money.unavailable(Currency currency)
      : _amount = null,
        _currency = currency;

  /// Initializes a Money object with an [amount] represented by a double
  /// (double.nan indicates an unavailable amount). Due to binary approximation
  /// errors, this constructor should be used sparingly, and the Decimal or
  /// String constructors preferred. [currency] metadata is used to format,
  /// parse and operate upon an amount.

  Money.double(double amount, Currency currency) {
    var m = (amount.isNaN)
        ? Money.unavailable(currency)
        : Money.string(amount.toStringAsFixed(currency.exponent), currency);
    _amount = m._amount;
    _currency = m._currency;
  }

  /// Initializes a Money object with an [amount] represented by a Decimal.
  /// [currency] metadata is used to format, parse and operate upon an amount.

  Money.decimal(Decimal amount, Currency currency) {
    _amount = amount;
    _currency = currency;
  }

  /// Initializes a Money object with an amount represented by a String. If the
  /// amount cannot be converted to a string, then the Money object will be
  /// represented as unavailable. See MoneyFormatter for string formats of Money
  /// amounts. [amount] represented as a String, whitespace is removed from
  /// the beginning and end of the string before parsing. [currency] metadata
  /// is used to format, parse and operate upon an amount.

  Money.string(String amount, Currency currency) {
    _currency = currency;
    try {
      var f = MoneyFormatter(_currency);
      _amount = f.parse(amount.trim());
    } catch (e) {
      _amount = null;
    }
  }

  /// Returns true if the money amount is negative. Unavailable amounts
  /// always return false.

  bool get isNegative => _amount != null && _amount!.isNegative;

  /// Money objects can either be real or unavailable. This property returns
  /// true if the amount is unavailable.

  bool get isUnavailable => _amount == null;

  /// The metadata used to format, parse and operate upon an amount.

  Currency get currency => _currency;

  /// The amount of the Money object represented as a double or double.nan if
  /// unavailable. Due to binary approximation errors, this method should be
  /// used sparingly, and the toDecimal() or toString() methods preferred.

  double toDouble() {
    if (_amount == null) {
      return double.nan;
    } else {
      return _amount!.toDouble();
    }
  }

  /// The amount of the Money object represented as a Decimal or null if
  /// unavailable.

  Decimal? toDecimal() {
    return _amount;
  }

  /// The amount of the Money object represented as a String. By default the
  /// returned string is formatted without prefix or suffix or grouping
  /// separators. e.g. '-2402.19'.

  @override
  String toString(
      {bool symbols = false, bool grouping = false, bool negative = true}) {
    var f = MoneyFormatter(_currency);
    return f.format(_amount,
        symbols: symbols, grouping: grouping, negative: negative);
  }

  /// Returns the textual string used for voiceover of an amount or '' if
  /// unavailable. e.g. '-$523.84 NZD' is returned as 'new zealand negative
  /// five hundred and twenty three dollars and eighty four cents'. See
  /// MoneyFormatter accessibilityText(amount, negative, prefix) for more
  /// details.

  String accessibilityText() {
    var f = MoneyFormatter(_currency);
    return f.accessibilityText(_amount);
  }

  // Hashing and comparing extensions

  /// Hashes the essential components of this Money object.

  @override
  int get hashCode {
    if (_amount == null) {
      return _currency.hashCode;
    } else {
      return _currency.hashCode ^ _amount.hashCode;
    }
  }

  /// Checks for equality between the two Money objects. The currency and
  /// amounts must match exactly.

  @override
  bool operator ==(Object other) {
    if (!(other is Money)) {
      return false;
    }
    if (_currency != other._currency) {
      return false;
    }
    return _amount == other._amount;
  }

  /// Compares two Money objects for order using the currency and amount.
  /// Currencies are compared first in ascending order e.g. (AUD < NZD),
  /// followed by amounts. If result is 0, then the currency and amounts match.

  @override
  int compareTo(other) {
    if (!(other is Money)) {
      return -1;
    }
    var r = _currency.compareTo(other._currency);
    if (r != 0) {
      return r;
    } else {
      if (_amount == null) {
        if (other._amount == null) {
          return 0;
        } else {
          return -1;
        }
      } else {
        if (other._amount == null) {
          return 1;
        } else {
          return _amount!.compareTo(other._amount!);
        }
      }
    }
  }
}

// Arithmetic extensions

extension MoneyArithmetic on Money {
  /// Adds [other] money to this money and returns the result. Money objects
  /// with differing currencies return an unavailable amount. Example:
  /// var a = Money(5.00, NZD)
  /// var b = Money(10.00, NZD)
  /// var c = a + b // value of c is 15.00

  Money operator +(Money other) {
    if (other._currency != _currency ||
        _amount == null ||
        other._amount == null) {
      return Money.unavailable(_currency);
    } else {
      return Money.decimal(_amount! + other._amount!, _currency);
    }
  }

  /// Subtracts [other] money from this money and returns the result. Money
  /// objects with differing currencies return an unavailable amount. Example:
  /// var a = Money(5.00, NZD)
  /// var b = Money(10.00, NZD)
  /// var c = a - b // value of c is -5.00

  Money operator -(Money other) {
    if (other._currency != _currency ||
        _amount == null ||
        other._amount == null) {
      return Money.unavailable(_currency);
    } else {
      return Money.decimal(_amount! - other._amount!, _currency);
    }
  }

  /// Negates this object's amount and returns the result. Unavailable amounts
  /// are returned unchanged. Example:
  /// var a = Money(5.00, NZD)
  /// var b = -a // value of b is -5.00

  Money operator -() {
    if (_amount == null) {
      return this;
    } else {
      return Money.decimal(-_amount!, _currency);
    }
  }

  /// Less than operator.

  bool operator <(Money other) {
    if (other._currency != _currency ||
        _amount == null ||
        other._amount == null) {
      return false;
    }
    return _amount! < other._amount!;
  }

  /// Less than or equal operator.

  bool operator <=(Money other) {
    if (other._currency != _currency) {
      return false;
    }
    if (_amount == null && other._amount == null) {
      return true;
    }
    if (_amount == null || other._amount == null) {
      return false;
    }
    return _amount! <= other._amount!;
  }

  /// Greater than operator.

  bool operator >(Money other) {
    if (other._currency != _currency ||
        _amount == null ||
        other._amount == null) {
      return false;
    }
    return _amount! > other._amount!;
  }

  /// Greater than or equal operator.

  bool operator >=(Money other) {
    if (other._currency != _currency) {
      return false;
    }
    if (_amount == null && other._amount == null) {
      return true;
    }
    if (_amount == null || other._amount == null) {
      return false;
    }
    return _amount! >= other._amount!;
  }
}
