from models.db.preference_db_model import db, PreferenceModel
from models.preference import Preference
from flask import current_app


def _to_preference(preference_model: PreferenceModel) -> Preference:
    return Preference(
        uid=preference_model.uid,
        name=preference_model.name,
        icon=preference_model.icon,
        is_active=preference_model.is_active,
        extra_data=preference_model.extra_data,
        extra_data_hint=preference_model.extra_data_hint
    )


class PreferenceRepository:
    def __init__(self):
        self.db = db
        self.create_table_if_not_exists()

    def create_table_if_not_exists(self):
        with current_app.app_context():
            preferences_count = PreferenceModel.query.count()
            if preferences_count == 0:
                self.db.create_all()
                self.seed_data()

    def get_all_preferences(self) -> [Preference]:
        with current_app.app_context():
            preferences = PreferenceModel.query.all()
            return [_to_preference(p) for p in preferences]

    def get_preference_by_id(self, uid: str) -> Preference:
        with current_app.app_context():
            preference = PreferenceModel.query.filter_by(uid=uid).first()
            if preference:
                return _to_preference(preference)
            return None

    def update_preference(self, preference: Preference) -> bool:
        with current_app.app_context():
            preference_model = PreferenceModel.query.filter_by(uid=preference.uid).first()
            if preference_model:
                preference_model.name = preference.name
                preference_model.icon = preference.icon
                preference_model.is_active = preference.is_active
                preference_model.extra_data = preference.extra_data
                self.db.session.commit()
                return True
            return False

    def seed_data(self):
        with current_app.app_context():
            preferences = [
                PreferenceModel(uid='pref_2', name='Showering with music', icon=0xe5a0, is_active=False,
                                extra_data_hint='Your favorite music genre'),
                PreferenceModel(uid='pref_3', name='Cooking with music', icon=0xe35e, is_active=False,
                                extra_data_hint='Your favorite playlist name'),
                PreferenceModel(uid='pref_6', name='Playing shows when you come home', icon=0xe687, is_active=False,
                                extra_data_hint='The title of your favorite show')
            ]
            for preference in preferences:
                self.db.session.add(preference)
            self.db.session.commit()
