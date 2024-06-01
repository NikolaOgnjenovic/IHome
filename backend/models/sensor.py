class Sensor:
    def __init__(self, uid: str, name: str, icon):
        self.uid = uid
        self.name = name
        self.icon = icon

    def to_dict(self):
        return {
            'uid': self.uid,
            'name': self.name,
            'icon': self.icon
        }
