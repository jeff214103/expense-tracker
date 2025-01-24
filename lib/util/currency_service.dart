import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'google_sheet.dart';
import 'package:intl/intl.dart';

class CurrencyServiceCustom {
  static final CurrencyService _instance = CurrencyService();

  static bool _initialized = false;
  static final Map<String, double> _exchangeRates = {
    // Existing major currencies
    'USD': 1.0,
    'EUR': 0.92,
    'JPY': 151.37,
    'GBP': 0.79,
    'AUD': 1.52,
    'CAD': 1.35,
    'CHF': 0.90,
    'CNY': 7.23,
    'HKD': 7.82,
    'NZD': 1.66,
    'SEK': 10.42,
    'KRW': 1338.76,
    'SGD': 1.34,
    'NOK': 10.58,
    'MXN': 16.71,
    'INR': 83.34,
    'RUB': 92.50,
    'ZAR': 18.77,
    'TRY': 31.98,
    'BRL': 5.00,
    'TWD': 31.89,
    'DKK': 6.87,
    'PLN': 3.95,
    'THB': 35.97,
    'IDR': 15775.05,
    'HUF': 356.95,
    'CZK': 23.24,
    'ILS': 3.69,
    'CLP': 961.24,
    'PHP': 56.13,
    'AED': 3.67,
    'SAR': 3.75,
    'MYR': 4.77,
    'RON': 4.58,
    'BGN': 1.80,
    'ISK': 137.45,
    'MAD': 10.05,
    'QAR': 3.64,
    'VND': 24565.00,
    'EGP': 30.90,
    'COP': 0.0, // Colombian Peso
    'AFN': 0.0, // Afghan Afghani
    'ALL': 0.0, // Albanian Lek
    'DZD': 0.0, // Algerian Dinar
    'AOA': 0.0, // Angolan Kwanza
    'AMD': 0.0, // Armenian Dram
    'AZN': 0.0, // Azerbaijani Manat
    'BHD': 0.0, // Bahraini Dinar
    'BDT': 0.0, // Bangladeshi Taka
    'BBD': 0.0, // Barbadian Dollar
    'BYN': 0.0, // Belarusian Ruble
    'BZD': 0.0, // Belize Dollar
    'BMD': 0.0, // Bermudian Dollar
    'BTN': 0.0, // Bhutanese Ngultrum
    'BOB': 0.0, // Bolivian Boliviano
    'BAM': 0.0, // Bosnia-Herzegovina Convertible Mark
    'BWP': 0.0, // Botswana Pula
    'BND': 0.0, // Brunei Dollar
    'BIF': 0.0, // Burundian Franc
    'KHR': 0.0, // Cambodian Riel
    'KYD': 0.0, // Cayman Islands Dollar
    'XAF': 0.0, // Central African CFA Franc
    'XOF': 0.0, // West African CFA Franc
    'CDF': 0.0, // Congolese Franc
    'CRC': 0.0, // Costa Rican Colón
    'CUP': 0.0, // Cuban Peso
    'DOP': 0.0, // Dominican Peso
    'ETB': 0.0, // Ethiopian Birr
    'GMD': 0.0, // Gambian Dalasi
    'GEL': 0.0, // Georgian Lari
    'GHS': 0.0, // Ghanaian Cedi
    'GTQ': 0.0, // Guatemalan Quetzal
    'GYD': 0.0, // Guyanese Dollar
    'HTG': 0.0, // Haitian Gourde
    'IQD': 0.0, // Iraqi Dinar
    'JMD': 0.0, // Jamaican Dollar
    'JOD': 0.0, // Jordanian Dinar
    'KZT': 0.0, // Kazakhstani Tenge
    'KES': 0.0, // Kenyan Shilling
    'KWD': 0.0, // Kuwaiti Dinar
    'KGS': 0.0, // Kyrgystani Som
    'LAK': 0.0, // Laotian Kip
    'LBP': 0.0, // Lebanese Pound
    'LRD': 0.0, // Liberian Dollar
    'MKD': 0.0, // Macedonian Denar
    'MGA': 0.0, // Malagasy Ariary
    'MWK': 0.0, // Malawian Kwacha
    'MVR': 0.0, // Maldivian Rufiyaa
    'MUR': 0.0, // Mauritian Rupee
    'MDL': 0.0, // Moldovan Leu
    'MNT': 0.0, // Mongolian Tugrik
    'MZN': 0.0, // Mozambican Metical
    'MMK': 0.0, // Myanmar Kyat
    'NAD': 0.0, // Namibian Dollar
    'NPR': 0.0, // Nepalese Rupee
    'NIO': 0.0, // Nicaraguan Córdoba
    'NGN': 0.0, // Nigerian Naira
    'OMR': 0.0, // Omani Rial
    'PKR': 0.0, // Pakistani Rupee
    'PGK': 0.0, // Papua New Guinean Kina
    'PYG': 0.0, // Paraguayan Guarani
    'PEN': 0.0, // Peruvian Sol
    'RWF': 0.0, // Rwandan Franc
    'RSD': 0.0, // Serbian Dinar
    'SCR': 0.0, // Seychellois Rupee
    'SOS': 0.0, // Somali Shilling
    'LKR': 0.0, // Sri Lankan Rupee
    'SRD': 0.0, // Surinamese Dollar
    'SYP': 0.0, // Syrian Pound
    'TZS': 0.0, // Tanzanian Shilling
    'TOP': 0.0, // Tongan Paʻanga
    'TTD': 0.0, // Trinidad and Tobago Dollar
    'TND': 0.0, // Tunisian Dinar
    'UGX': 0.0, // Ugandan Shilling
    'UAH': 0.0, // Ukrainian Hryvnia
    'UYU': 0.0, // Uruguayan Peso
    'VEF': 0.0, // Venezuelan Bolívar
    'YER': 0.0, // Yemeni Rial
    'ZMW': 0.0, // Zambian Kwacha
    'ZWL': 0.0, // Zimbabwean Dollar
  };


  static Map<String, double> get exchangeRates => _exchangeRates;

  // Method to fetch and update exchange rates from Google Sheet
  static Future<void> updateExchangeRates() {
    if (_initialized) {
      return Future.value();
    }
    return GoogleSheetHelper.getExchangeRates().then((exchangeRates) {
      for (final entry in exchangeRates.entries) {
        _exchangeRates[entry.key] = entry.value;
      }
      _initialized = true;
      return;
    });
  }

  // Method to get exchange rate for a specific currency
  static double getExchangeRate(String currencyCode) {
    return _exchangeRates[currencyCode] ?? 1.0;
  }

  // Convert amount from one currency to another
  static double convertCurrency(
      double amount, String fromCurrency, String toCurrency) {
    final fromRate = getExchangeRate(fromCurrency);
    final toRate = getExchangeRate(toCurrency);

    // Convert through USD (base currency)
    return amount * (toRate / fromRate);
  }

  static List<String> getAllCurrencies() {
    return _instance.getAll().map((currency) => currency.code).toList();
  }

  static Currency? findByCode(String currencyCode) {
    return _instance.findByCode(currencyCode);
  }

  static String getCurrencySymbol(String currencyCode) {
    Currency? currency = _instance.findByCode(currencyCode);
    return currency?.symbol ?? currencyCode;
  }

  static String getCurrencyName(String currencyCode) {
    Currency? currency = _instance.findByCode(currencyCode);
    return currency?.name ?? currencyCode;
  }

  static double convert(
    double amount,
    String fromCurrency,
    String toCurrency,
  ) {
    if (fromCurrency == toCurrency) return amount;

    // If either currency is not in our database, return original amount
    if (!_exchangeRates.containsKey(fromCurrency) ||
        !_exchangeRates.containsKey(toCurrency)) {
      return amount;
    }

    // Convert to USD first, then to target currency
    double amountInUSD = amount / _exchangeRates[fromCurrency]!;
    return amountInUSD * _exchangeRates[toCurrency]!;
  }

  static String formatCurrency(double amount, String currencyCode) {
    String symbol = getCurrencySymbol(currencyCode);
    String formattedAmount = NumberFormat('#,##0.00').format(amount);
    return '$symbol $formattedAmount';
  }

  static void pickCurrency(BuildContext context,
      {required void Function(Currency) onSelect}) {
    showCurrencyPicker(
        context: context,
        theme: CurrencyPickerThemeData(
          flagSize: 25,
          titleTextStyle: const TextStyle(fontSize: 17),
          subtitleTextStyle:
              TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
          bottomSheetHeight: MediaQuery.of(context).size.height / 2,
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withValues(alpha: 0.2),
              ),
            ),
          ),
        ),
        onSelect: onSelect);
  }
}
