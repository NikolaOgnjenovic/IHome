from flask import current_app
from sqlalchemy import inspect
from models.db.sensor_db_model import SensorModel, db
from models.sensor import Sensor, SensorType


def _to_sensor(sensor_model: SensorModel) -> Sensor:
    return Sensor(
        uid=sensor_model.uid,
        name=sensor_model.name,
        icon=sensor_model.icon,
        is_active=sensor_model.is_active,
        entity_id=sensor_model.entity_id,
        type=sensor_model.type
    )


class SensorRepository:
    def __init__(self):
        self.db = db
        self.create_table_if_not_exists()

    def create_table_if_not_exists(self):
        with current_app.app_context():
            sensors_count = SensorModel.query.count()
            if sensors_count == 0:
                self.db.create_all()
                self.seed_data()

    def get_all_sensors(self) -> [Sensor]:
        with current_app.app_context():
            sensors = SensorModel.query.all()
            return [_to_sensor(s) for s in sensors]

    def get_sensor_by_id(self, uid: str) -> Sensor:
        with current_app.app_context():
            sensor = SensorModel.query.filter_by(uid=uid).first()
            if sensor:
                return _to_sensor(sensor)
            return None

    def update_sensor(self, sensor: Sensor) -> bool:
        with current_app.app_context():
            sensor_model = SensorModel.query.filter_by(uid=sensor.uid).first()
            if sensor_model:
                sensor_model.name = sensor.name
                sensor_model.icon = sensor.icon
                sensor_model.is_active = sensor.is_active
                self.db.session.commit()
                return True
            return False

    def seed_data(self):
        with current_app.app_context():
            sensors = [
                SensorModel(uid='a1', name='Temperature', icon=0xe42b, is_active=False,
                            entity_id='sensor.psoc6_micropython_sensornode_working_space_temperature',
                            type=SensorType.TEMPERATURE),
                SensorModel(uid='b2', name='Atmospheric pressure', icon=0xe536, is_active=False,
                            entity_id='sensor.psoc6_micropython_sensornode_open_space_atmospheric_pressure',
                            type=SensorType.ATMOSHPERIC_PRESSURE),
                SensorModel(uid='c3', name='Humidity', icon=0xe318, is_active=False,
                            entity_id='sensor.psoc6_micropython_sensornode_open_space_relative_humidity',
                            type=SensorType.RELATIVE_HUMIDITY),
                SensorModel(uid='d4', name='CO2', icon=0xe491, is_active=False,
                            entity_id='sensor.psoc6_micropython_sensornode_working_space_co2_ppm',
                            type=SensorType.CO2_PPM)
            ]
            for sensor in sensors:
                self.db.session.add(sensor)
            self.db.session.commit()
