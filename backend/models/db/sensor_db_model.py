from models.db.db import db


class SensorModel(db.Model):
    __tablename__ = 'sensors'
    uid = db.Column(db.String, primary_key=True)
    name = db.Column(db.String, nullable=False)
    icon = db.Column(db.Integer, nullable=False)
    is_active = db.Column(db.Boolean, default=False)

    def to_dict(self):
        return {
            'uid': self.uid,
            'name': self.name,
            'icon': self.icon,
            'is_active': self.is_active
        }
