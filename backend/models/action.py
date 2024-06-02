class Action:
    def __init__(self, id: int, description: str):
        self.id = id
        self.description = description
    
    def to_dict(self):
        return {
            'id': self.id,
            'description': self.description
        }
    
    def __str__(self) -> str:
        return f'Action id: {self.id} - Description: {self.description}'