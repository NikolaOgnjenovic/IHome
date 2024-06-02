from models.sensor import SensorType
from repositories.action_repository import ActionRepository
from repositories.preference_repository import PreferenceRepository


def last_k_elements(lst: list, k: int) -> list:
    return lst[-k:] if k < len(lst) else lst


class PromptService:
    def __init__(self, action_repostiory: ActionRepository, preference_repository: PreferenceRepository) -> None:
        self.action_repostiory = action_repostiory
        self.preference_repository = preference_repository

    def get_data_parsing_prompt(self, data: dict) -> dict:
        messages = [{"role": "system", "content": "You are a helpful and knowledgable assitant. You provide user with the SHORT feedback about event in their home based on available sensor data in the last 5 minutes. Try to predict what is happening (if anything), not just describe the data. Keep your replies short."}]
        for key in data:
            if data[key]['sensor'].type.value == SensorType.ATMOSHPERIC_PRESSURE.value:
                messages.append({
                    "role": "user",
                    "content": f"Athmospheric pressure values in room {str(data[key]['sensor'].room)}: {last_k_elements(str(data[key]['values'], 20))}"
                })
            elif data[key]['sensor'].type.value == SensorType.RELATIVE_HUMIDITY.value:
                messages.append({
                    "role": "user",
                    "content": f"Relative humidity values in room {str(data[key]['sensor'].room)}: {last_k_elements(str(data[key]['values'], 20))}."
                })
            elif data[key]['sensor'].type.value == SensorType.TEMPERATURE.value:
                messages.append({
                    "role": "user",
                    "content": f"Temperature values in room {str(data[key]['sensor'].room)}: {last_k_elements(str(data[key]['values'], 20))}"
                })
            elif data[key]['sensor'].type.value == SensorType.CO2_PPM.value:
                messages.append({
                    "role": "user",
                    "content": f"C02 PPM level values in room {str(data[key]['sensor'].room)}: {last_k_elements(str(data[key]['values'], 20))}"
                })
            elif data[key]['sensor'].type.value == SensorType.LIGHT.value:
                messages.append({
                    "role": "user",
                    "content": f"Light intensity values in room {str(data[key]['sensor'].room)}: {last_k_elements(str(data[key]['values'], 20))}"
                })
        return {
            "model": "llama-13b-chat",
            "messages": messages
        }


    def get_task_prompt_descriptive(self, sensor_context: str) -> dict:
        actions_list = "\n".join([str(action) for action in  self.action_repostiory.get_all_actions()])
        preferences_list = "\n".join([preference.name for preference in self.preference_repository.get_all_preferences()])

        messages = [
            {'role': 'system', 'content': 'You are a helpful assistant that chooses which automated home action should be taken based on data parsed from the sensors. You do not like ventilation'},
            # {'role': 'system', 'content': 'The function parameters must EXACTLY match those of the available actions (commands). The available actions are: ' + actions_list},
            {'role': 'system', 'content': 'User preferences are: ' + preferences_list},
            {'role': 'system', 'content': "I'll send you the list of available actions, choose the number of the one that fits the situation the most."},
            {'role': 'system', 'content': 'Please respond ONLY with the ID of the appropriate command.'},
            {'role': 'user', 'content': sensor_context},
            # {'role': 'system', 'content': 'Please respond ONLY with the ID of the appropriate command.'}
            {'role': 'system', 'content': 'Keep the reply short.'}
        ]

        return {
            'model': 'llama-13b-chat',
            # 'functions': [{
            #     'name': 'run_task',
            #     'description': 'Run the task that suits the situation the most. action_id and action_description must match one of the provided.',
            #     'parameters': {
            #         'type': 'object',
            #         'properties': {
            #             'action_id': {
            #                 'type': 'string',
            #                 'description': 'The ID of the action to be run.'
            #             }
            #         },
            #         'required': ['action_id']
            #     }
            # }],
            # 'function_call': {'name': 'run_task'},
            'messages': messages
        }


    def get_task_id_prompt(self, response) -> str:
        messages = [
            {'role': 'system', 'content': 'User will provide you with descriptive action. You should return a single string which is an id of the action that should be taken.'},
            # {'role': 'system', 'content': 'The id must EXACTLY match those of the available actions (commands). The available actions are: '}
            {'role': 'system', 'content': "I'll send you the list of available actions, choose the number of the one that fits the situation the most."}
        ]
        for action in self.action_repostiory.get_all_actions():
            messages.append({'role': 'system', 'content': str(action)})

        messages.append({'role': 'user', 'content': response})

        return {
            'model': 'llama-13b-chat',
            # 'functions': [{
            #     'name': 'run_task',
            #     'description': 'Run the task that suits the situation the most. action_id and action_description must match one of the provided.',
            #     'parameters': {
            #         'type': 'object',
            #         'properties': {
            #             'action_id': {
            #                 'type': 'string',
            #                 'description': 'The ID of the action to be run.'
            #             }
            #         },
            #         'required': ['action_id']
            #     }
            # }],
            # 'function_call': {'name': 'run_task'},
            'messages': messages
        }