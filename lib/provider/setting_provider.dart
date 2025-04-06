import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker_web/util/google_sheet.dart';

class SettingProvider with ChangeNotifier {
  SettingProvider() {
    SharedPreferences.getInstance().then((prefs) {
      _language = prefs.getString('language');
      notifyListeners();
    });
  }
  static const String _currencyKey = 'currency';
  static const String _incomeKey = 'income';
  static const String _regularCostKey = 'regularCost';
  static const String _geminiApiKey = 'geminiApiKey';
  static const String _geminiModelKey = 'geminiModel';
  static const String _uploadToGDriveKey = 'uploadToGDrive';
  static const String _currencyCalculationSourceKey =
      'currencyCalculationSource';
  static const List<String> _settingKeysToSheet = [
    _currencyKey,
    _incomeKey,
    _regularCostKey,
    _geminiApiKey,
    _geminiModelKey,
  ];
  static const List<String> _availableModels = [
    'gemini-1.5-flash',
    'gemini-2.0-flash',
  ];

  List<String> get availableModels => _availableModels;

  bool _initialized = false;
  void reset() {
    _initialized = false;
    notifyListeners();
  }

  Set<String> get sheetKeys => Set.unmodifiable(_settingKeysToSheet);

  String? _currency;
  double _income = 0.0;
  double _regularCost = 0.0;
  String _geminiKey = '';
  String _geminiModel = '';
  bool _uploadToGDrive = false; // default to false
  String? _currencyCalculationSource;
  String? _language;

  String? get currency => _currency;
  double get income => _income;
  double get regularCost => _regularCost;
  String get geminiKey => _geminiKey;
  String get geminiModel => _geminiModel;
  bool get uploadToGDrive => _uploadToGDrive;
  String? get currencyCalculationSource => _currencyCalculationSource;
  String? get language => _language;

  Future<void> init() async {
    if (_initialized) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    _uploadToGDrive = prefs.getBool(_uploadToGDriveKey) ?? true;
    _currencyCalculationSource =
        prefs.getString(_currencyCalculationSourceKey) ?? 'USD';

    // First, initialize settings and get row indices
    await GoogleSheetHelper.initializeSettings(sheetKeys);

    // Get settings from the manager
    Map<String, dynamic> settings =
        GoogleSheetHelper.settingsManager.getAllSettings();

    bool unsynced = false;
    // If no settings exist, migrate from SharedPreferences
    for (final key in sheetKeys) {
      if (!settings.containsKey(key)) {
        try {
          settings[key] = prefs.getString(key);
        } catch (e) {
          settings[key] = prefs.getDouble(key);
        }
        unsynced = true;
      }
    }

    // Update local state from settings
    _currency = settings[_currencyKey];
    _income = double.tryParse(settings[_incomeKey]?.toString() ?? '0.0') ?? 0.0;
    _regularCost =
        double.tryParse(settings[_regularCostKey]?.toString() ?? '0.0') ?? 0.0;
    _geminiKey = settings[_geminiApiKey] ?? '';
    _geminiModel = settings[_geminiModelKey] ?? '';

    if (_geminiModel != '' && !_availableModels.contains(_geminiModel)) {
      _geminiModel = availableModels.first;
    }

    if (unsynced) {
      if (kDebugMode) {
        print("Sync the settings with Google Sheets");
      }
      // Migrate existing settings to Google Sheets
      await GoogleSheetHelper.migrateSettings(settings);
    }

    _initialized = true;
    notifyListeners();
  }

  Future<void> updateCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_currencyKey, currency),
      GoogleSheetHelper.updateSetting(_currencyKey, currency)
    ]);
    _currency = currency;
    notifyListeners();
  }

  Future<void> updateIncome(double income) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_incomeKey, income.toString()),
      GoogleSheetHelper.updateSetting(_incomeKey, income)
    ]);
    _income = income;
    notifyListeners();
  }

  Future<void> updateRegularCost(double cost) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_regularCostKey, cost.toString()),
      GoogleSheetHelper.updateSetting(_regularCostKey, cost)
    ]);
    _regularCost = cost;
    notifyListeners();
  }

  Future<void> updateGeminiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_geminiApiKey, key),
      GoogleSheetHelper.updateSetting(_geminiApiKey, key)
    ]);
    _geminiKey = key;
    notifyListeners();
  }

  Future<void> updateGeminiModel(String model) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_geminiModelKey, model),
      GoogleSheetHelper.updateSetting(_geminiModelKey, model)
    ]);
    _geminiModel = model;
    notifyListeners();
  }

  Future<void> updateUploadToGDrive(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_uploadToGDriveKey, value);
    _uploadToGDrive = value;
    notifyListeners();
  }

  Future<void> updateCurrencyCalculationSource(String source) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyCalculationSourceKey, source);
    _currencyCalculationSource = source;
    notifyListeners();
  }

  Future<void> updateLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    _language = language;
    notifyListeners();
  }
}
