from flask import Flask
from controllers.preferences_controller import preferences_bp


app = Flask(__name__)

app.register_blueprint(preferences_bp)


if __name__ == "__main__":
    app.run(debug=True)