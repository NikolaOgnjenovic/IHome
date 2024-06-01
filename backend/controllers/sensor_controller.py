from flask import Blueprint, request, jsonify

from services.sensor_service import SensorService

sensors_controller = Blueprint('sensors_controller', __name__)
sensor_service = SensorService()


@sensors_controller.route('/sensors', methods=['PUT'])
def update_all_sensors():
    sensors_data = request.json.get('sensors', [])
    sensor_service.update_all_sensors(sensors_data)
    return jsonify({'message': 'Sensors updated successfully'}), 200


@sensors_controller.route('/sensors', methods=['GET'])
def get_all_sensors():
    sensors = sensor_service.get_all_sensors()
    return jsonify(sensors), 200
