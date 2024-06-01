from flask import Blueprint, request, jsonify
from services.sensor_service import SensorService

sensors_controller = Blueprint('sensors_controller', __name__)


def sensors_controller_factory(sensor_service: SensorService):
    @sensors_controller.route('/sensors', methods=['GET'])
    def get_all_sensors():
        sensors = sensor_service.get_all_sensors()
        sensor_dicts = [sensor.to_dict() for sensor in sensors]
        return jsonify(sensor_dicts), 200

    @sensors_controller.route('/sensors/activate', methods=['PATCH'])
    def activate_sensor_by_id():
        data = request.json
        uid = data.get('uid')
        if not uid:
            return jsonify({'error': 'Sensor ID not provided'}), 400
        success = sensor_service.activate_by_id(uid)
        if success:
            return jsonify({'message': 'Sensor activated successfully'}), 200
        else:
            return jsonify({'error': 'Sensor not found'}), 404

    @sensors_controller.route('/sensors/deactivate', methods=['PATCH'])
    def deactivate_sensor_by_id():
        data = request.json
        uid = data.get('uid')
        if not uid:
            return jsonify({'error': 'Sensor ID not provided'}), 400
        success = sensor_service.deactivate_by_id(uid)
        if success:
            return jsonify({'message': 'Sensor deactivated successfully'}), 200
        else:
            return jsonify({'error': 'Sensor not found'}), 404

    return sensors_controller
