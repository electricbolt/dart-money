// currency.dart
// Money Copyright © 2021; Electric Bolt Limited.

class Currency implements Comparable {
  /// 3 character ISO-4217 currency code. e.g. "NZD"

  String get code => _code;

  /// Name of the currency used for display purposes. e.g. "New Zealand dollar"

  String get name => _name;

  /// Flag of currencies country. Unicode compatible. e.g. "🇳🇿"

  String get flag => _flag;

  /// Formatted money amount symbol prefix. Currencies have a symbolPrefix or
  /// symbolSuffix, but not both. Unicode compatible. e.g. "$"

  String get symbolPrefix => _symbolPrefix;

  /// Formatted money amount symbol suffix. Currencies have a symbolPrefix or
  /// symbolSuffix, but not both. Unicode compatible. e.g. "kr".

  String get symbolSuffix => _symbolSuffix;

  /// Number of fractional digits of the subunit. Range is 0..4. e.g. Most
  /// currencies have 2. JPY has 0, KWR has 3.

  int get exponent => _exponent;

  /// Name of the unit used for accessibility purposes. e.g. "dollar"

  String get unit => _unit;

  /// Plural name of the unit used for accessibility purposes. e.g. "dollars"

  String get units => _units;

  /// Name of the subunit used for accessibility purposes. e.g. "cent"

  String get subunit => _subunit;

  /// Plural name of the subunit used for accessibility purposes. e.g. "cents"

  String get subunits => _subunits;

  /// Currency country to prepend as a prefix for accessibility purposes. e.g.
  /// "australian"
  String get prefix => _prefix;

  final String _code;
  final String _name;
  final String _flag;
  final String _symbolPrefix;
  final String _symbolSuffix;
  final int _exponent;
  final String _unit;
  final String _units;
  final String _subunit;
  final String _subunits;
  final String _prefix;

  Currency(
      this._code,
      this._name,
      this._flag,
      this._symbolPrefix,
      this._symbolSuffix,
      this._exponent,
      this._unit,
      this._units,
      this._subunit,
      this._subunits,
      this._prefix);

  /// Returns a Boolean value indicating whether two Currency objects are equal.

  @override
  bool operator ==(Object other) {
    if (!(other is Currency)) {
      return false;
    }
    return _code == other._code;
  }

  @override
  int get hashCode => _code.hashCode;

  /// A textual representation of this instance, suitable for debugging.
  /// Returns string in the following format: 'NZD,$,New Zealand dollar,2DP'

  @override
  String toString() {
    var prefixSuffix = _symbolPrefix.isNotEmpty ? _symbolPrefix : _symbolSuffix;
    return '$_code,$prefixSuffix,$_name,${_exponent}DP';
  }

  @override
  int compareTo(dynamic other) {
    if (!(other is Currency)) {
      return -1;
    }
    return _code.compareTo(other._code);
  }

}
