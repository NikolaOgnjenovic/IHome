from models.sensor import SensorType


def get_data_parsing_prompt(data: dict):
    messages = [{"role": "system", "content": "You are a helpful and knowledgable assitant. You provide user with the SHORT feedback about event in their home based on available sensor data in the last 5 minutes."}]
    for key in data:
        if data[key]['sensor'].type.value == SensorType.ATMOSHPERIC_PRESSURE.value:
            messages.append({
                "role": "user",
                "content": f"Athmospheric pressure values in room {str(data[key]['sensor'].room)}: {str(data[key]['values'])}"
            })
        elif data[key]['sensor'].type.value == SensorType.RELATIVE_HUMIDITY.value:
            messages.append({
                "role": "user",
                "content": f"Relative humidity values in room {str(data[key]['sensor'].room)}: {str(data[key]['values'])}. (is someone showering?)"
            })
        elif data[key]['sensor'].type.value == SensorType.TEMPERATURE.value:
            messages.append({
                "role": "user",
                "content": f"Temperature values in room {str(data[key]['sensor'].room)}: {str(data[key]['values'])}"
            })
        elif data[key]['sensor'].type.value == SensorType.CO2_PPM.value:
            messages.append({
                "role": "user",
                "content": f"C02 PPM level values in room {str(data[key]['sensor'].room)}: {str(data[key]['values'])}"
            })
        elif data[key]['sensor'].type.value == SensorType.LIGHT.value:
            messages.append({
                "role": "user",
                "content": f"Light intensity values in room {str(data[key]['sensor'].room)}: {str(data[key]['values'])}"
            })
    return {
        "model": "llama-13b-chat",
        "messages": messages
    }