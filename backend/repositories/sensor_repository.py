from models.sensor import Sensor


class SensorRepository:
    def __init__(self):
        self.sensors = []

    def update_all_sensors(self, sensors: [Sensor]):
        self.sensors.clear()
        for sensor_data in sensors:
            self.sensors.append(sensor_data)

    def get_all_sensors(self) -> [Sensor]:
        return self.sensors
