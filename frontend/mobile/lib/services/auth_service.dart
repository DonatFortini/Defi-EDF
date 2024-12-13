import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import '../config/environment.dart';
import '../models/auth_response.dart';

class AuthService {
  static const String TOKEN_KEY = 'auth_token';
  static const String REFRESH_TOKEN_KEY = 'refresh_token';

  static Future<AuthResponse> login(String email, String password) async {
    try {
      final url = EnvironmentConfig.loginRoute(email, password);

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(data);
        if (authResponse.token != null) {
          await saveToken(authResponse.token!);
        }
        if (authResponse.refreshToken != null) {
          await saveRefreshToken(authResponse.refreshToken!);
        }
        return authResponse;
      } else {
        return AuthResponse(
          error: data['message'] ?? 'Une erreur est survenue',
        );
      }
    } catch (e) {
      return AuthResponse(
        error: 'Erreur de connexion au serveur: ${e.toString()}',
      );
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(REFRESH_TOKEN_KEY, refreshToken);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(REFRESH_TOKEN_KEY);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(REFRESH_TOKEN_KEY);
  }

  static Future<bool> isTokenValid() async {
    final token = await getToken();
    if (token == null) return false;

    try {
      final decodedToken = JwtDecoder.decode(token);
      final expirationDate =
          DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      return expirationDate.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  static Future<bool> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('${EnvironmentConfig.apiUrl}/api/public/refresh'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'refresh_token': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newToken = data['token'];
        final newRefreshToken = data['refresh_token'];

        if (newToken != null) {
          await saveToken(newToken);
          if (newRefreshToken != null) {
            await saveRefreshToken(newRefreshToken);
          }
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
