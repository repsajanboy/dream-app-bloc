import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  readObj(String key) async {
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

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
