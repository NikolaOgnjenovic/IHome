from models.sensor import Sensor, SensorType


class SensorRepository:
    def __init__(self):
        self.sensors = [
            Sensor(uid='a1', name='Temperature', icon=0xe42b, is_active=False, entity_id='sensor.psoc6_micropython_sensornode_working_space_temperature', type=SensorType.TEMPERATURE),
            Sensor(uid='b2', name='Atmospheric pressure', icon=0xe536, is_active=False, entity_id='sensor.psoc6_micropython_sensornode_open_space_atmospheric_pressure', type=SensorType.ATMOSHPERIC_PRESSURE),
            Sensor(uid='c3', name='Humidity', icon=0xe318, is_active=False, entity_id='sensor.psoc6_micropython_sensornode_open_space_relative_humidity', type=SensorType.RELATIVE_HUMIDITY),
            Sensor(uid='d4', name='CO2', icon=0xe491, is_active=False, entity_id='sensor.psoc6_micropython_sensornode_working_space_co2_ppm', type=SensorType.CO2_PPM)
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