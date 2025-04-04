from flask import Blueprint, request, jsonify
from modules.message_module import create_message
from modules.user_module import find_user_by_email  # Import the new function

message_bp = Blueprint('message', __name__)

@message_bp.route('/add_user', methods=['POST'])
def create_message_route():
    data = request.json
    create_message(data['idcnv'], data['contenu'])
    return jsonify({'message': 'Message created successfully'}), 201

@message_bp.route('/', methods=['GET'])
def find_user_by_email_route():
    data = request.json
    email = data['email']
    user = find_user_by_email(email)  # Use the new function
    if user:
        return jsonify({'user': user}), 200
    return jsonify({'message': 'User not found'}), 404

