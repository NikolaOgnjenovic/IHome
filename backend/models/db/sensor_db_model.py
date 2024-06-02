from models.db.db import db
from models.sensor import SensorType


class SensorModel(db.Model):
    __tablename__ = 'sensors'
    uid = db.Column(db.String, primary_key=True)
    name = db.Column(db.String, nullable=False)
    icon = db.Column(db.Integer, nullable=False)
    is_active = db.Column(db.Boolean, default=False)
    entity_id = db.Column(db.String, nullable=False)
    type = db.Column(db.Enum(SensorType), nullable=False)
    room = db.Column(db.String, nullable=False)

    def to_dict(self):
        return {
            'uid': self.uid,
            'name': self.name,
            'icon': self.icon,
            'is_active': self.is_active,
            'entity_id': self.entity_id,
            'type': self.type.value,
            'room': self.room
        }
