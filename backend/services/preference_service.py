from models.preference import Preference
from repositories.preference_repository import PreferenceRepository


class PreferenceService:
    def __init__(self):
        self.preferenceRepository = PreferenceRepository()

    def get_all_preferences(self) -> [Preference]:
        return self.preferenceRepository.get_all_preferences()

    def activate_by_id(self, uid: str) -> bool:
        preference = self.preferenceRepository.get_preference_by_id(uid)
        if preference:
            preference.is_active = True
            self.preferenceRepository.update_preference(preference)
            return True
        return False

    def deactivate_by_id(self, uid: str) -> bool:
        preference = self.preferenceRepository.get_preference_by_id(uid)
        if preference:
            preference.is_active = False
            self.preferenceRepository.update_preference(preference)
            return True
        return False
