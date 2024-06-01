import 'package:shared_preferences/shared_preferences.dart';

class SensorSelectionRepository {
  static const String _hasSelectedSensorsKey = 'has_selected_sensors';

  Future<void> clearSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_hasSelectedSensorsKey);
  }

  Future<bool> hasSelectedSensors() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSelectedSensorsKey) == true;
  }
}
