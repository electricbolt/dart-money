// currencymanager.dart
// MoneyCurrency Copyright © 2021; Electric Bolt Limited.

import 'currency.dart';

class CurrencyManager {
  static final CurrencyManager _instance = CurrencyManager._internal();
  late Map<String, Currency> _storage;

  /// Returns the singleton instance of [CurrencyManager].

  factory CurrencyManager() {
    return _instance;
  }

  CurrencyManager._internal() {
    _storage = {};
    populateWithStaticList();
  }

  /// Returns the currency with the given code. If the given code does not
  /// exist, then nil is returned.

  Currency? get(String code) {
    return _storage[code];
  }

  /// Adds a currency into the list of known currencies. If the currency with
  /// the given code already exists, it is replaced with the given currency.

  void add(Currency currency) {
    _storage[currency.code] = currency;
  }

  /// Removes a currency from the list of known currencies. If the currency with
  /// the given code does not exist, no error is raised.

  void remove(String code) {
    _storage.remove(code);
  }

  /// Removes all known currencies.

  void removeAll() {
    _storage.clear();
  }

  /// Returns a list of all known currencies sorted by currency code.

  List<Currency> list() {
    return _storage.values.toList()..sort();
  }

  /// Populates the currency manager with a hardcoded list of well known
  /// currencies. The list was compiled from the 5 major banks in New Zealand:
  /// - Westpac https://www.westpac.co.nz/fx-travel-migrant/foreign-exchange-and-international/foreign-exchange-rates/
  /// - ANZ https://tools.anz.co.nz/foreign-exchange/fx-rates
  /// - BNZ https://www.bnz.co.nz/personal-banking/international/exchange-rates
  /// - ASB https://www.asb.co.nz/foreign-exchange/foreign-exchange-rates.html
  /// - Kiwibank https://www.kiwibank.co.nz/personal-banking/rates-and-fees/fx-rates/

  void populateWithStaticList() {
    add(Currency('NZD', 'New Zealand dollar', '🇳🇿', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'new zealand'));
    add(Currency('USD', 'United States dollar', '🇺🇸', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'american'));
    add(Currency('GBP', 'Pound sterling', '🇬🇧', '£', '', 2, 'pound', 'pounds',
        'pence', 'pence', 'british'));
    add(Currency('AUD', 'Australian dollar', '🇦🇺', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'australian'));
    add(Currency('EUR', 'Euro', '🇪🇺', '€', '', 2, 'euro', 'euros', 'cent',
        'cents', 'euro'));
    add(Currency('JPY', 'Japanese yen', '🇯🇵', '￥', '', 0, 'yen', 'yen', '',
        '', 'japanese'));
    add(Currency('CAD', 'Canadian dollar', '🇨🇦', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'canadian'));
    add(Currency('CHF', 'Swiss franc', '🇨🇭', 'Fr', '', 2, 'franc', 'francs',
        'centime', 'centimes', 'swiss'));
    add(Currency('XPF', 'French Polynesia franc', '🇵🇫', '₣', '', 2, 'franc',
        'francs', 'centime', 'centimes', 'polynesian'));
    add(Currency('DKK', 'Danish krone', '🇩🇰', '', 'kr.', 2, 'krone', 'kroner',
        'øre', 'øre', 'danish'));
    add(Currency('FJD', 'Fijian dollar', '🇫🇯', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'fijian'));
    add(Currency('HKD', 'Hong Kong dollar', '🇭🇰', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'hong kong'));
    add(Currency('INR', 'Indian rupee', '🇮🇳', '₹', '', 2, 'rupee', 'rupees',
        'paise', 'paise', 'indian'));
    add(Currency('NOK', 'Norwegian krone', '🇳🇴', '', 'kr.', 2, 'krone',
        'kroner', 'øre', 'øre', 'norwegian'));
    add(Currency('PKR', 'Pakistan rupee', '🇵🇰', '₨', '', 2, 'rupee', 'rupees',
        'paisa', 'paisa', 'pakistan'));
    add(Currency('PGK', 'Papua New Guinean kina', '🇵🇬', 'K', '', 2, 'kina',
        'kina', 'toea', 'toea', 'papua new guinean'));
    add(Currency('PHP', 'Philippine peso', '🇵🇭', '₱', '', 2, 'peso', 'pesos',
        'sentimo', 'sentimo', 'philippine'));
    add(Currency('SGD', 'Singapore dollar', '🇸🇬', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'singaporean'));
    add(Currency('SBD', 'Solomon Islands dollar', '🇸🇧', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'solomon islands'));
    add(Currency('ZAR', 'South African rand', '🇿🇦', 'R', '', 2, 'rand',
        'rand', 'cent', 'cents', 'south african'));
    add(Currency('LKR', 'Sri Lankan rupee', '🇱🇰', 'රු.', '', 2, 'rupee',
        'rupees', 'cent', 'cents', 'sri lankan'));
    add(Currency('SEK', 'Swedish krona', '🇸🇪', '', 'kr', 2, 'krona', 'kronor',
        'øre', 'øre', 'swedish'));
    add(Currency('THB', 'Thai baht', '🇹🇭', '฿', '', 2, 'baht', 'baht',
        'satang', 'satang', 'thai'));
    add(Currency('TOP', 'Tongan paʻanga', '🇹🇴', 'T\$', '', 2, 'paʻanga',
        'paʻanga', 'seniti', 'seniti', 'tongan'));
    add(Currency('VUV', 'Vanuatu vatu', '🇻🇺', '', 'VT', 0, 'vatu', 'vatu', '',
        '', 'vanuatu'));
    add(Currency('WST', 'Samoan tālā', '🇼🇸', '\$', ' tālā', 2, 'tala', 'tala',
        'sene', 'sene', 'samoan'));
    add(Currency('BHD', 'Bahrain dinar', '🇧🇭', 'BD', '', 3, 'dinar', 'dinars',
        'fils', 'fils', 'bahrainian'));
    add(Currency('CNY', 'Chinese yuán', '🇨🇳', '￥', '', 2, 'yuán', 'yuán',
        'fēn', 'fēn', 'chinese'));
    add(Currency('KWD', 'Kuwait dinar', '🇰🇼', 'KD', '', 2, 'dinar', 'dinars',
        'fils', 'fils', 'kuwaiti'));
    add(Currency('MXN', 'Mexican peso', '🇲🇽', '\$', '', 2, 'peso', 'pesos',
        'cent', 'cents', 'mexican'));
    add(Currency('MYR', 'Malaysian ringgit', '🇲🇽', 'RM', '', 2, 'ringgit',
        'ringgit', 'sen', 'sen', 'malaysian'));
    add(Currency('KRW', 'South Korean won', '🇰🇷', '₩', '', 0, 'won', 'won',
        '', '', 'korean'));
    add(Currency('AED', 'United Arab Emirates dirham', '🇦🇪', '', 'د.إ', 2,
        'dirham', 'dirhams', 'fil', 'fils', 'emirates'));
    add(Currency('CZK', 'Czech Republic koruna', '🇨🇿', '', 'Kč', 2, 'koruna',
        'koruny', 'haler', 'haleru', 'czech'));
    add(Currency('HUF', 'Hungarian forint', '🇭🇺', '', 'Ft', 2, 'forint',
        'forint', 'filler', 'filler', 'hungarian'));
    add(Currency('IDR', 'Indonesian rupiah', '🇮🇩', 'Rp', '', 2, 'rupiah',
        'rupiahs', 'sen', 'sen', 'indonesian'));
    add(Currency('ILS', 'Israel new shekel', '🇮🇱', '₪', '', 2, 'shekel',
        'shekels', 'agora', 'agoras', 'israeli'));
    add(Currency('KES', 'Kenyan shilling', '🇰🇪', 'K', '', 2, 'shilling',
        'shillings', 'cent', 'cents', 'kenyan'));
    add(Currency('PLN', 'Polish zloty', '🇵🇱', '', 'zł', 2, 'zloty', 'zloty',
        'grosz', 'groszy', 'polish'));
    add(Currency('SAR', 'Saudi Arabian riyal', '🇸🇦', '', 'SR', 2, 'riyal',
        'riyals', 'halala', 'halalas', 'saudi'));
    add(Currency('TRY', 'Turkish lira', '🇹🇷', '₺', '', 2, 'lira', 'lira',
        'kurus', 'kurus', 'turkish'));
    add(Currency('TWD', 'Taiwanese new dollar', '🇹🇼', '\$', '', 2, 'dollar',
        'dollars', 'cent', 'cents', 'taiwanese'));
    add(Currency('VND', 'Vietnamese dong', '🇻🇳', '', '₫', 2, 'dong', 'dong',
        'xu', 'xu', 'vietnamese'));
  }
}
