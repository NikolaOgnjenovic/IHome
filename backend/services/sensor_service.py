from models.sensor import Sensor
from repositories.sensor_repository import SensorRepository


class SensorService:
    def __init__(self, sensor_repository: SensorRepository):
        self.sensor_repository = sensor_repository

    def get_all_sensors(self) -> [Sensor]:
        return self.sensor_repository.get_all_sensors()

    def activate_by_id(self, uid: str) -> bool:
        sensor = self.sensor_repository.get_sensor_by_id(uid)
        if sensor:
            sensor.is_active = True
            self.sensor_repository.update_sensor(sensor)
            return True
        return False

    def deactivate_by_id(self, uid: str) -> bool:
        sensor = self.sensor_repository.get_sensor_by_id(uid)
        if sensor:
            sensor.is_active = False
            self.sensor_repository.update_sensor(sensor)
            return True
        return False
