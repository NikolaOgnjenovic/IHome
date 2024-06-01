from models.preference import Preference


class PreferenceRepository:
    def __init__(self):
        self.preferences = []

    def update_all_preferences(self, preferences: [Preference]):
        self.preferences.clear()
        for preference_data in preferences:
            self.preferences.append(preference_data)

    def get_all_preferences(self) -> [Preference]:
        return self.preferences
