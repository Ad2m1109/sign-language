from flask import Blueprint, request, jsonify
from modules.user_module import create_user

user_bp = Blueprint('user', __name__)

@user_bp.route('/add_user', methods=['POST'])
def create_user_route():
    data = request.json
    create_user(data['name'], data['email'], data['password'])
    return jsonify({'message': 'User created successfully'}), 201
