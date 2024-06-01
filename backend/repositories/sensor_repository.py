from flask import current_app
from sqlalchemy import inspect
from models.db.sensor_db_model import SensorModel, db
from models.sensor import Sensor


def _to_sensor(sensor_model: SensorModel) -> Sensor:
    return Sensor(
        uid=sensor_model.uid,
        name=sensor_model.name,
        icon=sensor_model.icon,
        is_active=sensor_model.is_active
    )


class SensorRepository:
    def __init__(self):
        self.db = db
        self.create_table_if_not_exists()

    def create_table_if_not_exists(self):
        with current_app.app_context():
            inspector = inspect(self.db.engine)
            if 'sensors' not in inspector.get_table_names():
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
                SensorModel(uid='a1', name='Temperature', icon=0xe42b, is_active=False),
                SensorModel(uid='b2', name='Motion', icon=0xe536, is_active=False),
                SensorModel(uid='c3', name='Humidity', icon=0xe318, is_active=False),
                SensorModel(uid='d4', name='CO2', icon=0xe491, is_active=False)
            ]
            for sensor in sensors:
                self.db.session.add(sensor)
            self.db.session.commit()
