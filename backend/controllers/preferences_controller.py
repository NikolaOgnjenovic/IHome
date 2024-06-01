from flask import Blueprint
from services.test import get_test_string


preferences_bp = Blueprint('preferences', __name__, url_prefix='/preferences')


@preferences_bp.route('/', methods=['GET'])
def test():
    return get_test_string()