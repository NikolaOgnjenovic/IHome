from models.db.action_db_model import db, ActionModel
from models.action import Action
from flask import current_app


def _to_action(action_model: ActionModel) -> Action:
    return Action(action_model.id, action_model.description)


class ActionRepository:
    def __init__(self) -> None:
        self.db = db
        self.create_table_if_not_exists()

    def create_table_if_not_exists(self) -> None:
        with current_app.app_context():
            actions_count = ActionModel.query.count()
            if actions_count == 0:
                self.db.create_all()
                self.seed_data()

    def get_all_actions(self) -> list[Action]:
        with current_app.app_context():
            actions = ActionModel.query.all()
            return [_to_action(a) for a in actions]
        
    def get_action_by_id(self, id: int) -> Action:
        with current_app.app_context():
            action = ActionModel.query.filter_by(id=id).first()
            if action:
                return _to_action(action)
            return None
        
    def update_action(self, action: Action) -> bool:
        with current_app.app_context():
            action_model = ActionModel.query.filter_by(id=action.id).first()
            if action_model:
                action_model.description = action.description
                self.db.session.commit()
                return True
            return False
        
    def seed_data(self):
        with current_app.app_context():
            actions = [
                ActionModel(id='do_nothing', description='Do nothing'),
                ActionModel(id='say', description='Say suggestion out loud'),
                ActionModel(id='music', description='Turn the music on'),
                ActionModel(id='tv', description='Turn the TV on'),
                ActionModel(id='window', description='Open the window'),
                ActionModel(id='ac', description='Turn on AC'),
                ActionModel(id='vent', description='Turn on ventilation')
            ]
            for action in actions:
                self.db.session.add(action)
            self.db.session.commit()