from models.preference import Preference


class PreferenceRepository:
    def __init__(self):
        self.preferences = [
            Preference(uid='pref_0', name='Eating ice cream', icon=0xe438, is_active=False),
            Preference(uid='pref_1', name='Going to the beach', icon=0xe3be, is_active=False),
            Preference(uid='pref_2', name='Listening to music', icon=0xe405, is_active=False),
            Preference(uid='pref_3', name='Reading books', icon=0xe03e, is_active=False),
            Preference(uid='pref_4', name='Playing video games', icon=0xe7fc, is_active=False),
            Preference(uid='pref_5', name='Travelling', icon=0xe195, is_active=False),
            Preference(uid='pref_6', name='Watching movies', icon=0xe40c, is_active=False),
            Preference(uid='pref_7', name='Cycling', icon=0xe52f, is_active=False),
            Preference(uid='pref_8', name='Cooking', icon=0xe56c, is_active=False),
            Preference(uid='pref_9', name='Hiking', icon=0xe3c4, is_active=False)
        ]

    def get_all_preferences(self) -> [Preference]:
        return self.preferences

    def get_preference_by_id(self, uid: str) -> Preference | None:
        for preference in self.preferences:
            if preference.uid == uid:
                return preference
        return None

    def update_preference(self, preference: Preference) -> bool:
        for idx, p in enumerate(self.preferences):
            if p.uid == preference.uid:
                self.preferences[idx] = preference
                return True
        return False
