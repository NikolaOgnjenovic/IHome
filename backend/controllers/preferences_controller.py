from flasgger import swag_from
from flask import Blueprint, request, jsonify
from services.preference_service import PreferenceService

preferences_controller = Blueprint('preferences_controller', __name__)


def preferences_controller_factory(preference_service: PreferenceService):
    @preferences_controller.route('/preferences', methods=['GET'])
    @swag_from({
        'responses': {
            200: {
                'description': 'A list of all preferences',
                'schema': {
                    'type': 'array',
                    'items': {
                        'type': 'object',
                        'properties': {
                            'uid': {'type': 'string'},
                            'name': {'type': 'string'},
                            'icon': {'type': 'string'},
                            'is_active': {'type': 'boolean'},
                            'extra_data': {'type': 'string', 'nullable': True},
                            'extra_data_hint': {'type': 'string', 'nullable': True}
                        }
                    }
                }
            }
        }
    })
    def get_all_preferences():
        preferences = preference_service.get_all_preferences()
        preference_dicts = [preference.to_dict() for preference in preferences]
        return jsonify(preference_dicts), 200

    @preferences_controller.route('/preferences/activate', methods=['PATCH'])
    @swag_from({
        'parameters': [
            {
                'name': 'body',
                'in': 'body',
                'required': True,
                'schema': {
                    'type': 'object',
                    'properties': {
                        'uid': {'type': 'string'}
                    },
                    'required': ['uid']
                }
            }
        ],
        'responses': {
            200: {
                'description': 'Preference activated successfully'
            },
            400: {
                'description': 'Preference ID not provided'
            },
            404: {
                'description': 'Preference not found'
            }
        }
    })
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
    @swag_from({
        'parameters': [
            {
                'name': 'body',
                'in': 'body',
                'required': True,
                'schema': {
                    'type': 'object',
                    'properties': {
                        'uid': {'type': 'string'}
                    },
                    'required': ['uid']
                }
            }
        ],
        'responses': {
            200: {
                'description': 'Preference deactivated successfully'
            },
            400: {
                'description': 'Preference ID not provided'
            },
            404: {
                'description': 'Preference not found'
            }
        }
    })
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

    @preferences_controller.route('/preferences/<uid>', methods=['PATCH'])
    @swag_from({
        'parameters': [
            {
                'name': 'body',
                'in': 'body',
                'required': True,
                'schema': {
                    'type': 'object',
                    'properties': {
                        'extra_data': {'type': 'string'}
                    },
                    'required': ['extra_data']
                }
            },
            {
                'name': 'uid',
                'in': 'path',
                'type': 'string',
                'required': True,
                'description': 'Preference ID'
            }
        ],
        'responses': {
            200: {
                'description': 'Preference extra data updated successfully'
            },
            400: {
                'description': 'Extra data not provided'
            },
            404: {
                'description': 'Preference not found'
            }
        }
    })
    def update_preference_extra_data(uid):
        data = request.json
        extra_data = data.get('extra_data')
        if not extra_data:
            return jsonify({'error': 'Extra data not provided'}), 400
        success = preference_service.update_preference_extra_data(uid, extra_data)
        if success:
            return jsonify({'message': 'Preference extra data updated successfully'}), 200
        else:
            return jsonify({'error': 'Preference not found'}), 404

    return preferences_controller
