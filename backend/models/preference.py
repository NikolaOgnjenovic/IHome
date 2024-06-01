class Preference:
    def __init__(self, uid: str, name: str, icon, is_active: bool):
        self.uid = uid
        self.name = name
        self.icon = icon
        self.is_active = is_active

    def to_dict(self):
        return {
            'uid': self.uid,
            'name': self.name,
            'icon': self.icon,
            'is_active': self.is_active
        }
