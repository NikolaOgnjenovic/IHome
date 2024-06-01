from models.sensor import Sensor
from repositories.sensor_repository import SensorRepository


class SensorService:
    def __init__(self, sensor_repository: SensorRepository):
        self.sensor_repository = sensor_repository

    def get_all_sensors(self) -> [Sensor]:
        return self.sensorRepository.get_all_sensors()

    def activate_by_id(self, uid: str) -> bool:
        sensor = self.sensorRepository.get_sensor_by_id(uid)
        if sensor:
            sensor.is_active = True
            self.sensorRepository.update_sensor(sensor)
            return True
        return False

    def deactivate_by_id(self, uid: str) -> bool:
        sensor = self.sensorRepository.get_sensor_by_id(uid)
        if sensor:
            sensor.is_active = False
            self.sensorRepository.update_sensor(sensor)
            return True
        return False
