// stringutil.dart
// Money Copyright © 2021; Electric Bolt Limited.

/// Internal class used during parsing and formatting Decimal amounts.

extension StringUtil on String {

  /// Reverses the characters in the string. e.g. 'abcd' -> 'dcba'.

  String reverse() {
    var buf = StringBuffer();
    for (var i = length - 1; i >= 0; i--) {
      buf.write(this[i]);
    }
    return buf.toString();
  }

  /// Inserts the string [insert] at the [index] specified.

  String insert(String insert, int index) {
    if (index == 0) {
      return '$insert${this}';
    } else if (index >= length) {
      return '${this}$insert';
    } else {
      var beginning = substring(0, index);
      var end = substring(index);
      return '$beginning$insert$end';
    }
  }

  /// If the string starts with [prefix], then the [prefix] is removed from
  /// the string, otherwise the string is returned unchanged.

  String removePrefix(String prefix) {
    if (startsWith(prefix)) {
      if (length == prefix.length) {
        return '';
      } else {
        return substring(prefix.length);
      }
    }
    return this;
  }

  /// If the string ends with [suffix], then the [suffix] is removed from
  /// the string, otherwise the string is returned unchanged.

  String removeSuffix(String suffix) {
    if (endsWith(suffix)) {
      if (length == suffix.length) {
        return '';
      } else {
        return substring(0, length - suffix.length);
      }
    }
    return this;
  }

}