import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> readObj(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }
  Future<String?> readStr(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> isExisting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final exist = prefs.containsKey(key);
    return exist;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
