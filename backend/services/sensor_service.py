from models.sensor import Sensor
from repositories.sensor_repository import SensorRepository


class SensorService:
    def __init__(self):
        self.sensorRepository = SensorRepository()

    def update_all_sensors(self, sensors: [Sensor]):
        self.sensorRepository.update_all_sensors(sensors)

    def get_all_sensors(self) -> [Sensor]:
        return self.sensorRepository.get_all_sensors()