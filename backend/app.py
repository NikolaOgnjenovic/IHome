from flask import Flask

from controllers.preferences_controller import preferences_controller
from controllers.sensor_controller import sensors_controller

app = Flask(__name__)

app.register_blueprint(preferences_controller)
app.register_blueprint(sensors_controller)

if __name__ == '__main__':
    app.run(debug=True)
