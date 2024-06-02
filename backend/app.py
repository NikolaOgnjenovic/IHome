from utils.audio_utils import play_audio, stop_audio
from flask import Flask, request, Response
from apscheduler.schedulers.background import BackgroundScheduler

from controllers.preferences_controller import preferences_controller_factory
from controllers.sensor_controller import sensors_controller_factory
from models.db.preference_db_model import db
from repositories.preference_repository import PreferenceRepository
from repositories.sensor_repository import SensorRepository
from repositories.action_repository import ActionRepository
from services.preference_service import PreferenceService
from services.sensor_service import SensorService
from services.home_assitant_service import HomeAssistantService
from services.prompt_service import PromptService
from services.llama_service import LlamaApiService
from services.environment_service import EnvironmentService

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres@db/preferences_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

with app.app_context():
    db.create_all()
    preference_repository = PreferenceRepository()
    sensor_repository = SensorRepository()
    action_repository = ActionRepository()

preference_service = PreferenceService(preference_repository)
sensor_service = SensorService(sensor_repository)
home_assistant_service = HomeAssistantService(sensor_service)
prompt_service = PromptService(action_repository, preference_repository)
llama_service = LlamaApiService()
environment_service = EnvironmentService(home_assistant_service, prompt_service, llama_service)

def tmp_func():
    with app.app_context():
        environment_service.run_single()

scheduler = BackgroundScheduler()
scheduler.add_job(tmp_func, 'interval', seconds=10)
scheduler.start()

app.register_blueprint(preferences_controller_factory(preference_service))
app.register_blueprint(sensors_controller_factory(sensor_service))

@app.route('/play', methods=['GET'])
def play():
    video_url = request.args.get('video_name')
    if not video_url:
        return {'error': 'Please provide a video URL'}, 400

    play_audio(video_url)
    return Response(status=200)

@app.route('/stop', methods=['GET'])
def stop():
    stop_audio()
    return Response(status=200)

if __name__ == '__main__':
    app.run(debug=True, use_reloader=False)
