from flask import Flask
from controllers.preferences_controller import preferences_controller
from controllers.sensor_controller import sensors_controller
from models.db.preference_db_model import db
from repositories.preference_repository import PreferenceRepository
from repositories.sensor_repository import SensorRepository
from services.preference_service import PreferenceService
from services.sensor_service import SensorService

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres@db/preferences_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)


with app.app_context():
    db.create_all()

with app.app_context():
    preference_repository = PreferenceRepository()
    preference_service = PreferenceService(preference_repository)
    app.register_blueprint(preferences_controller)

    sensor_repository = SensorRepository()
    sensor_service = SensorService(sensor_repository)
    app.register_blueprint(sensors_controller)


if __name__ == '__main__':
    app.run(debug=True)
