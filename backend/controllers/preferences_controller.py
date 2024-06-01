from flask import Blueprint, request, jsonify

from services.preference_service import PreferenceService

preferences_controller = Blueprint('preferences_controller', __name__)
preference_service = PreferenceService()


@preferences_controller.route('/preferences', methods=['PUT'])
def update_all_preferences():
    preferences_data = request.json.get('preferences', [])
    preference_service.update_all_preferences(preferences_data)
    return jsonify({'message': 'Preferences updated successfully'}), 200


@preferences_controller.route('/preferences', methods=['GET'])
def get_all_preferences():
    preferences = preference_service.get_all_preferences()
    return jsonify(preferences), 200
