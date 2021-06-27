// decimalbuilder.dart
// Money Copyright © 2021; Electric Bolt Limited.

import 'package:decimal/decimal.dart';

/// Internal class used to help build a Decimal amount when parsing a string.

class DecimalBuilder {
  final bool _negative;
  bool _fractional = false;
  final StringBuffer _numerator = StringBuffer();
  int _fractionalLength = 0;
  final int _fractionalPrecision;

  DecimalBuilder(int fractionalPrecision, bool negative)
      : _fractionalPrecision = fractionalPrecision,
        _negative = negative {
    if (fractionalPrecision < 0 || fractionalPrecision > 4) {
      throw FormatException('Too many fractional digits');
    }
  }

  void addDigit(String digit) {
    var codeUnit = digit.codeUnitAt(0);
    if (_numerator.length >= 15 + (_fractional ? 1 : 0)) {
      throw FormatException('Too many digits');
    }
    if (_fractional && _fractionalLength >= _fractionalPrecision) {
      throw FormatException('Too many fractional digits');
    }
    _numerator.writeCharCode(codeUnit);
    _fractionalLength += _fractional ? 1 : 0;
  }

  bool get isFractional => _fractional;

  void setFractional() {
    if (_fractionalPrecision == 0 || _fractional == true) {
      throw FormatException('Unexpected decimal separator character '
          '\'.\'');
    }
    _numerator.write('.');
    _fractional = true;
  }

  Decimal build() {
    if (_numerator.isEmpty) {
      throw FormatException('Digits expected, none found');
    }
    var value = _numerator.toString();
    if (_negative) {
      value = '-$value';
    }
    return Decimal.parse(value);
  }
}
