from models.db.db import db


class PreferenceModel(db.Model):
    __tablename__ = 'preferences'
    uid = db.Column(db.String, primary_key=True)
    name = db.Column(db.String, nullable=False)
    icon = db.Column(db.Integer, nullable=False)
    is_active = db.Column(db.Boolean, default=False)
    extra_data = db.Column(db.String, nullable=True, default=None)
    extra_data_hint = db.Column(db.String, nullable=True, default=None)

    def to_dict(self):
        return {
            'uid': self.uid,
            'name': self.name,
            'icon': self.icon,
            'is_active': self.is_active,
            'extra_data': self.extra_data,
            'extra_data_hint': self.extra_data_hint
        }
