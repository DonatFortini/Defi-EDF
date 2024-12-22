import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:8000/api/public';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email, // Changed from username to email
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginData = jsonDecode(response.body);
        if (loginData['success'] == true) {
          // Explicitly check for true
          // Store the token if needed
          final token = loginData['data']['token'];
          final userId = loginData['data']['id_utilisateur'];
          final username = loginData['data']['nom_utilisateur'];

          return {
            'token': token,
            'userId': userId,
            'username': username,
            'success': true,
          };
        } else {
          throw Exception(loginData['error'] ?? 'Failed to login');
        }
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? 'Authentication failed');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
