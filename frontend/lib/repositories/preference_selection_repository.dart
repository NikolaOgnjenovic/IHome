import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/preference.dart';

class PreferenceSelectionRepository {
  static const String _preferencesKey = 'user_preferences';

  Future<void> updatePreferences(List<Preference> preferences) async {
    final prefs = await SharedPreferences.getInstance();
    final preferencesJson = jsonEncode(preferences.map((item) => item.toJson()).toList());
    await prefs.setString(_preferencesKey, preferencesJson);
  }

  Future<List<Preference>> getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final preferencesJson = prefs.getString(_preferencesKey);
    if (preferencesJson != null) {
      final List<dynamic> jsonList = jsonDecode(preferencesJson);
      return jsonList.map((json) => Preference.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_preferencesKey);
  }
}
