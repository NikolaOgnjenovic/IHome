import 'dart:convert';

import '../models/sensor.dart';
import '../repositories/sensor_selection_repository.dart';
import 'package:http/http.dart' as http;

class SensorSelectionService {
  final SensorSelectionRepository _repository = SensorSelectionRepository();
  final Uri baseUri = Uri.parse('http://127.0.0.1:5000/sensors');
  final Uri activateUri = Uri.parse('http://127.0.0.1:5000/sensors');
  final Uri deactivateUri = Uri.parse('http://127.0.0.1:5000/sensors/deactivate');

  Future<List<Sensor>> getSensors() async {
    final response = await http.get(baseUri);

    if (response.statusCode == 200) {
      final List<dynamic> sensorsJson = jsonDecode(response.body);
      return sensorsJson.map((sensorJson) => Sensor.fromJson(sensorJson)).toList();
    } else {
      throw Exception('Failed to load sensors: ${response.statusCode}');
    }
  }

  Future<void> clearSharedPrefs() async {
    await _repository.clearSharedPrefs();
  }

  Future<bool> hasSelectedSensors() async {
    return await _repository.hasSelectedSensors();
  }

  Future<void> setHasSelectedSensors(bool value) async {
    return await _repository.setHasSelectedSensors(value);
  }

  Future<void> activateSensor(String uid) async {
    final response = await http.post(
      activateUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uid': uid}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to activate sensor: ${response.statusCode}');
    }
  }

  Future<void> deactivateSensor(String uid) async {
    final response = await http.post(
      deactivateUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uid': uid}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to deactivate sensor: ${response.statusCode}');
    }
  }
}
