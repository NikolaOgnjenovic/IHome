from models.preference import Preference
from repositories.preference_repository import PreferenceRepository


class PreferenceService:
    def __init__(self, preference_repository: PreferenceRepository):
        self.preference_repository = preference_repository

    def get_all_preferences(self) -> [Preference]:
        return self.preference_repository.get_all_preferences()

    def activate_by_id(self, uid: str) -> bool:
        preference = self.preference_repository.get_preference_by_id(uid)
        if preference:
            preference.is_active = True
            self.preference_repository.update_preference(preference)
            return True
        return False

    def deactivate_by_id(self, uid: str) -> bool:
        preference = self.preference_repository.get_preference_by_id(uid)
        if preference:
            preference.is_active = False
            self.preference_repository.update_preference(preference)
            return True
        return False
