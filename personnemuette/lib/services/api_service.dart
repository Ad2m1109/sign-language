import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000";

  // Add a new user (register)
  static Future<void> addUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/add_user'), // Matches Flask route
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': userData['fullName'], // Matches Flask expected keys
        'email': userData['email'],
        'password': userData['password'],
      }),
    );

    if (response.statusCode != 201) {
      final errorData = json.decode(response.body);
      final errorMessage = errorData['message'] ?? 'Failed to add user';
      throw Exception(errorMessage);
    }
  }

  // Sign in (login)
  static Future<Map<String, dynamic>> signIn(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorData = json.decode(response.body);
      final errorMessage = errorData['message'] ?? 'Unknown error occurred';
      throw Exception(errorMessage);
    }
  }

  // Get user profile
  static Future<Map<String, dynamic>> getUserProfile(
      String userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorData = json.decode(response.body);
      final errorMessage = errorData['message'] ?? 'Failed to get user profile';
      throw Exception(errorMessage);
    }
  }
}
