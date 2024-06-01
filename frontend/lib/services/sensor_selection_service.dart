import 'dart:convert';

import '../models/sensor.dart';
import '../repositories/sensor_selection_repository.dart';
import 'package:http/http.dart' as http;

class SensorSelectionService {
  final SensorSelectionRepository _repository = SensorSelectionRepository();
  final Uri baseUri = Uri.parse('http://127.0.0.1:5000/sensors');
  
  Future<void> updateSensors(List<Sensor> sensors) async {
    final sensorsJson = sensors.map((sensor) => sensor.toJson()).toList();
    final response = await http.put(
      baseUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'sensors': sensorsJson}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update sensors: ${response.statusCode}');
    }
  }

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
}