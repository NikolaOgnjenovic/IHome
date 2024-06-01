class Preference:
    def __init__(self, uid: str, name: str, icon, is_active: bool, extra_data: str = None, extra_data_hint: str = None):
        self.uid = uid
        self.name = name
        self.icon = icon
        self.is_active = is_active
        self.extra_data = extra_data
        self.extra_data_hint = extra_data_hint

    def to_dict(self):
        return {
            'uid': self.uid,
            'name': self.name,
            'icon': self.icon,
            'is_active': self.is_active,
            'extra_data': self.extra_data,
            'extra_data_hint': self.extra_data_hint
        }
