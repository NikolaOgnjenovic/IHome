from enum import Enum


class SensorType(Enum):
    ATMOSHPERIC_PRESSURE = 0
    RELATIVE_HUMIDITY = 1
    TEMPERATURE = 2
    CO2_PPM = 3
    LIGHT = 4
    

class Sensor:
    def __init__(self, uid: str, name: str, icon, is_active: bool, entity_id: str, type: SensorType, room: str):
        self.uid = uid
        self.name = name
        self.icon = icon
        self.is_active = is_active
        self.entity_id = entity_id
        self.type = type
        self.room = room

    def to_dict(self):
        return {
            'uid': self.uid,
            'name': self.name,
            'icon': self.icon,
            'is_active': self.is_active,
            'entity_id': self.entity_id,
            'type': self.type.value,
            'room': self.room
        }
