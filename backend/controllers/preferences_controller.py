from flask import Blueprint, request, jsonify
from services.preference_service import PreferenceService

preferences_controller = Blueprint('preferences_controller', __name__)


def preferences_controller_factory(preference_service: PreferenceService):
    @preferences_controller.route('/preferences', methods=['GET'])
    def get_all_preferences():
        preferences = preference_service.get_all_preferences()
        preference_dicts = [preference.to_dict() for preference in preferences]
        return jsonify(preference_dicts), 200

    @preferences_controller.route('/preferences/activate', methods=['PATCH'])
    def activate_preference_by_id():
        data = request.json
        uid = data.get('uid')
        if not uid:
            return jsonify({'error': 'Preference ID not provided'}), 400
        success = preference_service.activate_by_id(uid)
        if success:
            return jsonify({'message': 'Preference activated successfully'}), 200
        else:
            return jsonify({'error': 'Preference not found'}), 404

    @preferences_controller.route('/preferences/deactivate', methods=['PATCH'])
    def deactivate_preference_by_id():
        data = request.json
        uid = data.get('uid')
        if not uid:
            return jsonify({'error': 'Preference ID not provided'}), 400
        success = preference_service.deactivate_by_id(uid)
        if success:
            return jsonify({'message': 'Preference deactivated successfully'}), 200
        else:
            return jsonify({'error': 'Preference not found'}), 404

    return preferences_controller
