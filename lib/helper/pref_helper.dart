import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static SharedPreferences? _prefs;

  // -------------------------
  // Initialize (Call once)
  // -------------------------
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // -------------------------
  // SAVE methods
  // -------------------------
  static Future saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static Future saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static Future saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static Future saveDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  // -------------------------
  // GET methods
  // -------------------------
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  // -------------------------
  // REMOVE & CLEAR
  // -------------------------
  static Future remove(String key) async {
    await _prefs?.remove(key);
  }

  static Future clear() async {
    await _prefs?.clear();
  }
}
