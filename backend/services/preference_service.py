from models.preference import Preference
from repositories.preference_repository import PreferenceRepository


class PreferenceService:
    def __init__(self):
        self.preferenceRepository = PreferenceRepository()

    def update_all_preferences(self, preferences: [Preference]):
        self.preferenceRepository.update_all_preferences(preferences)

    def get_all_preferences(self) -> [Preference]:
        return self.preferenceRepository.get_all_preferences()