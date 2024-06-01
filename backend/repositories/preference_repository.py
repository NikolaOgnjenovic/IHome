from models.db.preference_db_model import db, PreferenceModel
from models.preference import Preference
from flask import current_app
from sqlalchemy import inspect


def _to_preference(preference_model: PreferenceModel) -> Preference:
    return Preference(
        uid=preference_model.uid,
        name=preference_model.name,
        icon=preference_model.icon,
        is_active=preference_model.is_active
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
                self.db.session.commit()
                return True
            return False

    def seed_data(self):
        with current_app.app_context():
            preferences = [
                PreferenceModel(uid='pref_0', name='Eating ice cream', icon=0xe438, is_active=False),
                PreferenceModel(uid='pref_1', name='Going to the beach', icon=0xe3be, is_active=False),
                PreferenceModel(uid='pref_2', name='Listening to music', icon=0xe405, is_active=False),
                PreferenceModel(uid='pref_3', name='Reading books', icon=0xe03e, is_active=False),
                PreferenceModel(uid='pref_4', name='Playing video games', icon=0xe7fc, is_active=False),
                PreferenceModel(uid='pref_5', name='Travelling', icon=0xe195, is_active=False),
                PreferenceModel(uid='pref_6', name='Watching movies', icon=0xe40c, is_active=False),
                PreferenceModel(uid='pref_7', name='Cycling', icon=0xe52f, is_active=False),
                PreferenceModel(uid='pref_8', name='Cooking', icon=0xe56c, is_active=False),
                PreferenceModel(uid='pref_9', name='Hiking', icon=0xe3c4, is_active=False)
            ]
            for preference in preferences:
                self.db.session.add(preference)
            self.db.session.commit()
