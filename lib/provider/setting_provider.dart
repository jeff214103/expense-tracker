import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider with ChangeNotifier {
  static const String _currencyKey = 'currency';
  static const String _incomeKey = 'income';
  static const String _regularCostKey = 'regularCost';
  static const String _geminiApiKey = 'geminiApiKey';
  static const String _geminiModelKey = 'geminiModel';
  static const String _uploadToGDriveKey = 'uploadToGDrive';

  String? _currency;
  double _income = 0.0;
  double _regularCost = 0.0;
  String _geminiKey = '';
  String _geminiModel = '';
  bool _uploadToGDrive = true;  // default to true

  String? get currency => _currency;
  double get income => _income;
  double get regularCost => _regularCost;
  String get geminiKey => _geminiKey;
  String get geminiModel => _geminiModel;
  bool get uploadToGDrive => _uploadToGDrive;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _currency = prefs.getString(_currencyKey);
    _income = prefs.getDouble(_incomeKey) ?? 0.0;
    _regularCost = prefs.getDouble(_regularCostKey) ?? 0.0;
    _geminiKey = prefs.getString(_geminiApiKey) ?? '';
    _geminiModel = prefs.getString(_geminiModelKey) ?? '';
    _uploadToGDrive = prefs.getBool(_uploadToGDriveKey) ?? true;
    notifyListeners();
  }

  Future<void> updateCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyKey, currency);
    _currency = currency;
    notifyListeners();
  }

  Future<void> updateIncome(double income) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_incomeKey, income);
    _income = income;
    notifyListeners();
  }

  Future<void> updateRegularCost(double cost) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_regularCostKey, cost);
    _regularCost = cost;
    notifyListeners();
  }

  Future<void> updateGeminiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_geminiApiKey, key);
    _geminiKey = key;
    notifyListeners();
  }

  Future<void> updateGeminiModel(String model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_geminiModelKey, model);
    _geminiModel = model;
    notifyListeners();
  }

  Future<void> updateUploadToGDrive(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_uploadToGDriveKey, value);
    _uploadToGDrive = value;
    notifyListeners();
  }
}
