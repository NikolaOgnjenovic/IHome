from datetime import datetime, timedelta
from homeassistant_api import Client
from config import HA_ENDPOINT, HA_ACCESS_TOKEN
from repositories.sensor_repository import SensorRepository
from services.sensor_service import SensorService


MINUTES_DELTA = 5


class HomeAssistantService:
    def __init__(self, sensor_service: SensorService) -> None:
        self.sensor_service = sensor_service

    def get_sensor_data(self) -> dict:
        with Client(HA_ENDPOINT, HA_ACCESS_TOKEN) as client:
            data = {}
            for sensor in self.sensor_service.get_all_sensors():
                entity = client.get_entity(entity_id=sensor.entity_id)

                start = datetime.now() - timedelta(minutes=MINUTES_DELTA)
                history = client.get_entity_histories(entities=[entity], start_timestamp=start)
                for entry in history:
                    values = [float(x.state) for x in entry.states]
                data[sensor.uid] = {
                    'sensor': sensor,
                    'values': values
                }

            return data


if __name__ == "__main__":
    service = HomeAssistantService(SensorService(SensorRepository()))
    print(service.get_sensor_data())
