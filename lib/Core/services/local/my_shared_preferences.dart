import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum MySharedKeys { theme, language, apiToken }
class MySharedPref {
  late SharedPreferences _preferences;

  Future<SharedPreferences> initSP() async {
    printTest('initSP');
    return _preferences = await SharedPreferences.getInstance();
  }

  void putBoolean({
    required MySharedKeys key,
    required bool value,
  }) async {
    await _preferences.setBool(key.name, value);
  }

  bool? getBoolean({required MySharedKeys key}) {
    return _preferences.getBool(key.name);
  }

  void putString({
    required MySharedKeys key,
    required String? value,
  }) async {
    await _preferences.setString(key.name, value ?? "");
  }

  String getString({required MySharedKeys key}) {
    return _preferences.getString(key.name) ?? "";
  }

  Future<bool>? clearShared() {
    return _preferences.clear();
  }

  String getCurrentLanguage() {
    return _preferences.getString(MySharedKeys.language.name) ?? "en";
  }
}

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}