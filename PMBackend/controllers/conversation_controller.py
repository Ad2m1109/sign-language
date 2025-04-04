from flask import Blueprint, request, jsonify
from modules.conversation_module import create_conversation

conversation_bp = Blueprint('conversation', __name__)

@conversation_bp.route('/', methods=['POST'])
def create_conversation_route():
    data = request.json
    create_conversation(data['iduser1'], data['iduser2'])
    return jsonify({'message': 'Conversation created successfully'}), 201
