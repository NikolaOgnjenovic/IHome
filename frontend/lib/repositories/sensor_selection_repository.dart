import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/sensor.dart';

class SensorSelectionRepository {
  static const String _sensorsKey = 'active_sensors';
  static const String _hasSelectedSensorsKey = 'has_selected_sensors';

  Future<void> updateSensors(List<Sensor> sensors) async {
    final prefs = await SharedPreferences.getInstance();
    final sensorsJson = jsonEncode(sensors.map((item) => item.toJson()).toList());
    await prefs.setString(_sensorsKey, sensorsJson);
    await prefs.setBool(_hasSelectedSensorsKey, true);
  }

  Future<List<Sensor>> getSensors() async {
    final prefs = await SharedPreferences.getInstance();
    final sensorsJson = prefs.getString(_sensorsKey);
    if (sensorsJson != null) {
      final List<dynamic> jsonList = jsonDecode(sensorsJson);
      return jsonList.map((json) => Sensor.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> clearSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sensorsKey);
  }

  Future<bool> hasSelectedSensors() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSelectedSensorsKey) == true;
  }
}
