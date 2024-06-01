from models.sensor import Sensor


class SensorRepository:
    def __init__(self):
        self.sensors = [
            Sensor(uid='a1', name='Temperature', icon=0xe42b, is_active=False),
            Sensor(uid='b2', name='Motion', icon=0xe536, is_active=False),
            Sensor(uid='c3', name='Humidity', icon=0xe318, is_active=False),
            Sensor(uid='d4', name='CO2', icon=0xe491, is_active=False),
        ]

    def get_all_sensors(self) -> [Sensor]:
        return self.sensors

    def get_sensor_by_id(self, uid: str) -> Sensor | None:
        for sensor in self.sensors:
            if sensor.uid == uid:
                return sensor
        return None

    def update_sensor(self, sensor: Sensor) -> bool:
        for idx, s in enumerate(self.sensors):
            if s.uid == sensor.uid:
                self.sensors[idx] = sensor
                return True
        return False