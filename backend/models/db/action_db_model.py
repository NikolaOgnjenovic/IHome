from models.db.db import db
from models.sensor import SensorType


class ActionModel(db.Model):
    __tablename__ = 'actions'
    id = db.Column(db.String, primary_key=True)
    description = db.Column(db.String, nullable=False)

    def to_dict(self):
        return {
            'id': self.id,
            'description': self.description
        }
    
    def __str__(self) -> str:
        return f'Action {self.id} - Description: {self.description}'
