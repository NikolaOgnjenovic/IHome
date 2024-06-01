import '../models/sensor.dart';
import '../repositories/sensor_selection_repository.dart';

class SensorSelectionService {
  final SensorSelectionRepository _repository = SensorSelectionRepository();

  Future<void> updateSensors(List<Sensor> sensors) async {
    await _repository.updateSensors(sensors);
  }

  Future<List<Sensor>> getSensors() async {
    final sensors = await _repository.getSensors();
    return sensors;
  }

  Future<void> clearSharedPrefs() async {
    await _repository.clearSharedPrefs();
  }

  Future<bool> hasSelectedSensors() async {
    return await _repository.hasSelectedSensors();
  }
}