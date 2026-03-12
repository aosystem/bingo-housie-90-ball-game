import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bingogamehousie/const_value.dart';
import 'package:bingogamehousie/l10n/app_localizations.dart';

class Model {
  Model._();

  static const String _prefBallHistory = 'ballHistory';
  static const String _prefCardState1 = 'cardState1';
  static const String _prefCardState2 = 'cardState2';
  static const String _prefCardState3 = 'cardState3';
  static const String _prefCardState4 = 'cardState4';
  static const String _prefCardState5 = 'cardState5';
  static const String _prefCardState6 = 'cardState6';
  static const String _prefCardSubject1 = 'cardSubject1';
  static const String _prefCardSubject2 = 'cardSubject2';
  static const String _prefCardSubject3 = 'cardSubject3';
  static const String _prefCardSubject4 = 'cardSubject4';
  static const String _prefCardSubject5 = 'cardSubject5';
  static const String _prefCardSubject6 = 'cardSubject6';
  static const String _prefTtsEnabled = 'ttsEnabled';
  static const String _prefTtsVolume = 'ttsVolume';
  static const String _prefTtsVoiceId = 'ttsVoiceId';
  static const String _prefMachineVolume = 'machineVolume';
  static const String _prefQuickDraw = 'quickDraw';
  static const String _prefAutomaticDrawInterval = 'automaticDrawInterval';
  static const String _prefTextSizeRatioBall = 'textSizeRatioBall';
  static const String _prefTextSizeTable = 'textSizeTable';
  static const String _prefTextSizeCard = 'textSizeCard';
  static const String _prefColorScheme = 'colorScheme';
  static const String _prefThemeNumber = 'themeNumber';
  static const String _prefLanguageCode = 'languageCode';

  static bool _ready = false;
  static String _ballHistory = '';
  static String _cardState1 = '';
  static String _cardState2 = '';
  static String _cardState3 = '';
  static String _cardState4 = '';
  static String _cardState5 = '';
  static String _cardState6 = '';
  static String _cardSubject1 = 'A';
  static String _cardSubject2 = 'B';
  static String _cardSubject3 = 'C';
  static String _cardSubject4 = 'D';
  static String _cardSubject5 = 'E';
  static String _cardSubject6 = 'F';
  static bool _ttsEnabled = true;
  static String _ttsVoiceId = '';
  static double _ttsVolume = 1.0;
  static double _machineVolume = 1.0;
  static int _quickDraw = ConstValue.defaultQuickDraw;
  static int _automaticDrawInterval = ConstValue.defaultAutomaticDrawInterval;
  static double _textSizeRatioBall = ConstValue.defaultTextSizeRatioBall;
  static int _textSizeTable = ConstValue.defaultTextSizeTable;
  static int _textSizeCard = ConstValue.defaultTextSizeCard;
  static int _colorScheme = 0;
  static int _themeNumber = 0;
  static String _languageCode = '';

  static String get ballHistory => _ballHistory;
  static String get cardState1 => _cardState1;
  static String get cardState2 => _cardState2;
  static String get cardState3 => _cardState3;
  static String get cardState4 => _cardState4;
  static String get cardState5 => _cardState5;
  static String get cardState6 => _cardState6;
  static String get cardSubject1 => _cardSubject1;
  static String get cardSubject2 => _cardSubject2;
  static String get cardSubject3 => _cardSubject3;
  static String get cardSubject4 => _cardSubject4;
  static String get cardSubject5 => _cardSubject5;
  static String get cardSubject6 => _cardSubject6;
  static bool get ttsEnabled => _ttsEnabled;
  static String get ttsVoiceId => _ttsVoiceId;
  static double get ttsVolume => _ttsVolume;
  static double get machineVolume => _machineVolume;
  static int get quickDraw => _quickDraw;
  static int get automaticDrawInterval => _automaticDrawInterval;
  static double get textSizeRatioBall => _textSizeRatioBall;
  static int get textSizeTable => _textSizeTable;
  static int get textSizeCard => _textSizeCard;
  static int get colorScheme => _colorScheme;
  static int get themeNumber => _themeNumber;
  static String get languageCode => _languageCode;

  static Future<void> ensureReady() async {
    if (_ready) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    _ballHistory = prefs.getString(_prefBallHistory) ?? '';
    _cardState1 = prefs.getString(_prefCardState1) ?? '';
    _cardState2 = prefs.getString(_prefCardState2) ?? '';
    _cardState3 = prefs.getString(_prefCardState3) ?? '';
    _cardState4 = prefs.getString(_prefCardState4) ?? '';
    _cardState5 = prefs.getString(_prefCardState5) ?? '';
    _cardState6 = prefs.getString(_prefCardState6) ?? '';
    _cardSubject1 = prefs.getString(_prefCardSubject1) ?? 'A';
    _cardSubject2 = prefs.getString(_prefCardSubject2) ?? 'B';
    _cardSubject3 = prefs.getString(_prefCardSubject3) ?? 'C';
    _cardSubject4 = prefs.getString(_prefCardSubject4) ?? 'D';
    _cardSubject5 = prefs.getString(_prefCardSubject5) ?? 'E';
    _cardSubject6 = prefs.getString(_prefCardSubject6) ?? 'F';
    _ttsEnabled = prefs.getBool(_prefTtsEnabled) ?? true;
    _ttsVoiceId = prefs.getString(_prefTtsVoiceId) ?? '';
    _ttsVolume = (prefs.getDouble(_prefTtsVolume) ?? 1.0).clamp(0.0,1.0);
    _machineVolume = (prefs.getDouble(_prefMachineVolume) ?? 1.0).clamp(0.0,1.0);
    _quickDraw = (prefs.getInt(_prefQuickDraw) ?? ConstValue.defaultQuickDraw).clamp(
      ConstValue.minQuickDraw,
      ConstValue.maxQuickDraw,
    );
    _automaticDrawInterval = (prefs.getInt(_prefAutomaticDrawInterval) ?? ConstValue.defaultAutomaticDrawInterval).clamp(
      ConstValue.minAutomaticDrawInterval,
      ConstValue.maxAutomaticDrawInterval,
    );
    _textSizeRatioBall = (prefs.getDouble(_prefTextSizeRatioBall) ?? ConstValue.defaultTextSizeRatioBall).clamp(
      ConstValue.minTextSizeRatioBall,
      ConstValue.maxTextSizeRatioBall,
    );
    _textSizeTable = (prefs.getInt(_prefTextSizeTable) ?? ConstValue.defaultTextSizeTable).clamp(
      ConstValue.minTextSizeTable,
      ConstValue.maxTextSizeTable,
    );
    _textSizeCard = (prefs.getInt(_prefTextSizeCard) ?? ConstValue.defaultTextSizeCard).clamp(
      ConstValue.minTextSizeCard,
      ConstValue.maxTextSizeCard,
    );
    _colorScheme = (prefs.getInt(_prefColorScheme) ?? 0).clamp(0, 1);
    _themeNumber = (prefs.getInt(_prefThemeNumber) ?? 0).clamp(0, 2);
    _languageCode = prefs.getString(_prefLanguageCode) ?? ui.PlatformDispatcher.instance.locale.languageCode;
    _languageCode = _resolveLanguageCode(_languageCode);
    _ready = true;
  }

  static String _resolveLanguageCode(String code) {
    final supported = AppLocalizations.supportedLocales;
    if (supported.any((l) => l.languageCode == code)) {
      return code;
    } else {
      return '';
    }
  }

  static Future<void> resetMachine() async {
    _ballHistory = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefBallHistory);
  }

  static Future<void> resetCard(int number) async {
    final prefs = await SharedPreferences.getInstance();
    if (number == 1) {
      _cardState1 = '';
      await prefs.remove(_prefCardState1);
    } else if (number == 2) {
      _cardState2 = '';
      await prefs.remove(_prefCardState2);
    } else if (number == 3) {
      _cardState3 = '';
      await prefs.remove(_prefCardState3);
    } else if (number == 4) {
      _cardState4 = '';
      await prefs.remove(_prefCardState4);
    } else if (number == 5) {
      _cardState5 = '';
      await prefs.remove(_prefCardState5);
    } else if (number == 6) {
      _cardState6 = '';
      await prefs.remove(_prefCardState6);
    }
  }

  static Future<void> setCardSubject1(String value) async {
    _cardSubject1 = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefCardSubject1, value);
  }

  static Future<void> setCardSubject2(String value) async {
    _cardSubject2 = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefCardSubject2, value);
  }

  static Future<void> setCardSubject3(String value) async {
    _cardSubject3 = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefCardSubject3, value);
  }

  static Future<void> setCardSubject4(String value) async {
    _cardSubject4 = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefCardSubject4, value);
  }

  static Future<void> setCardSubject5(String value) async {
    _cardSubject5 = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefCardSubject5, value);
  }

  static Future<void> setCardSubject6(String value) async {
    _cardSubject6 = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefCardSubject6, value);
  }

  static Future<void> setTtsEnabled(bool flag) async {
    _ttsEnabled = flag;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefTtsEnabled, flag);
  }

  static Future<void> setTtsVoiceId(String value) async {
    _ttsVoiceId = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefTtsVoiceId, value);
  }

  static Future<void> setTtsVolume(double value) async {
    _ttsVolume = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_prefTtsVolume, value);
  }

  static Future<void> setMachineVolume(double value) async {
    _machineVolume = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_prefMachineVolume, value);
  }

  static Future<void> setQuickDraw(int value) async {
    _quickDraw = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefQuickDraw, value);
  }

  static Future<void> setAutomaticDrawInterval(int value) async {
    _automaticDrawInterval = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefAutomaticDrawInterval, value);
  }

  static Future<void> setTextSizeRatioBall(double value) async {
    _textSizeRatioBall = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_prefTextSizeRatioBall, value);
  }

  static Future<void> setTextSizeTable(int value) async {
    _textSizeTable = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefTextSizeTable, value);
  }

  static Future<void> setTextSizeCard(int value) async {
    _textSizeCard = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefTextSizeCard, value);
  }

  static Future<void> setBallHistory(String value) async {
    _ballHistory = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefBallHistory, value);
  }

  static Future<void> setCardState(int number, String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (number == 1) {
      _cardState1 = value;
      if (value.isEmpty) {
        await prefs.remove(_prefCardState1);
      } else {
        await prefs.setString(_prefCardState1, value);
      }
    } else if (number == 2) {
      _cardState2 = value;
      if (value.isEmpty) {
        await prefs.remove(_prefCardState2);
      } else {
        await prefs.setString(_prefCardState2, value);
      }
    } else if (number == 3) {
      _cardState3 = value;
      if (value.isEmpty) {
        await prefs.remove(_prefCardState3);
      } else {
        await prefs.setString(_prefCardState3, value);
      }
    } else if (number == 4) {
      _cardState4 = value;
      if (value.isEmpty) {
        await prefs.remove(_prefCardState4);
      } else {
        await prefs.setString(_prefCardState4, value);
      }
    } else if (number == 5) {
      _cardState5 = value;
      if (value.isEmpty) {
        await prefs.remove(_prefCardState5);
      } else {
        await prefs.setString(_prefCardState5, value);
      }
    } else if (number == 6) {
      _cardState6 = value;
      if (value.isEmpty) {
        await prefs.remove(_prefCardState6);
      } else {
        await prefs.setString(_prefCardState6, value);
      }
    }
  }

  static Future<void> setColorScheme(int value) async {
    _colorScheme = value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefColorScheme, value);
  }

  static Future<void> setThemeNumber(int value) async {
    _themeNumber = value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefThemeNumber, value);
  }

  static Future<void> setLanguageCode(String value) async {
    _languageCode = value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefLanguageCode, value);
  }

}
