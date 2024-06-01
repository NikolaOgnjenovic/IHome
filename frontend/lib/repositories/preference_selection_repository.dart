import 'package:shared_preferences/shared_preferences.dart';

class PreferenceSelectionRepository {
  static const String _hasSelectedPreferencesKey = 'has_selected_preferences';

  Future<void> clearSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_hasSelectedPreferencesKey);
  }

  Future<bool> hasSelectedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSelectedPreferencesKey) == true;
  }
}
