from services.home_assitant_service import HomeAssistantService
from services.prompt_service import PromptService
from services.llama_service import LlamaApiService


class EnvironmentService:
    def __init__(self, home_assistant_service: HomeAssistantService, prompt_service: PromptService, llama_service: LlamaApiService) -> None:
        self.home_assitant_service = home_assistant_service
        self.prompt_service = prompt_service
        self.llama_service = llama_service

    def run_single(self):
        data = self.home_assitant_service.get_sensor_data()

        # from models.sensor import Sensor, SensorType
        # data = {
        #     'c3': {
        #         'sensor': Sensor(uid='c3', name='Humidity', icon=0xe318, is_active=False, entity_id='sensor.psoc6_micropython_sensornode_open_space_relative_humidity', type=SensorType.RELATIVE_HUMIDITY, room="bathroom"),
        #         'values': [37.58,37.75,38.10,38.50,39.00,40.50,42.00,45.00,48.50,52.00,56.50,61.00,65.50,70.00,75.00,80.00,85.00,90.00,95.00,99.00]
        #         }
        # }

        prompt = self.prompt_service.get_data_parsing_prompt(data)
        res = self.llama_service.send(prompt)['choices'][0]['message']['content']

        prompt = self.prompt_service.get_task_prompt_descriptive(res)
        print(prompt)
        res = self.llama_service.send(prompt)#['choices'][0]['message']['content']

        # prompt = self.prompt_service.get_task_id_prompt(res)
        # res = self.llama_service.send(prompt)

        print(res)

