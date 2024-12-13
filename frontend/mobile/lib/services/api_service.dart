// lib/api/api_service.dart
import 'dart:convert';
import '../services/http_service.dart';
import '../config/environment.dart';

class ApiService {
  final _client = HttpService().client;

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse(EnvironmentConfig.loginRoute(email, password)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Échec de la connexion: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la connexion: $e');
    }
  }

  // Dashboard
  Future<Map<String, dynamic>> getDashboard() async {
    try {
      final response = await _client.get(
        Uri.parse(EnvironmentConfig.dashboardUrl),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Échec de récupération du dashboard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération du dashboard: $e');
    }
  }

  // Historique des contacts
  Future<Map<String, dynamic>> getHistoriqueContact(int idUtilisateur) async {
    try {
      final response = await _client.get(
        Uri.parse(EnvironmentConfig.getHistoriqueContactUrl(idUtilisateur)),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Échec de récupération de l\'historique: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'historique: $e');
    }
  }

  // Calcul CO2
  Future<Map<String, dynamic>> getCalculationCO2(int idPropulsion) async {
    try {
      final response = await _client.get(
        Uri.parse(EnvironmentConfig.getCalculationCO2(idPropulsion)),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Échec du calcul CO2: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors du calcul CO2: $e');
    }
  }

  // Article communauté
  Future<Map<String, dynamic>> getCommunauteArticle(int idArticle) async {
    try {
      final response = await _client.get(
        Uri.parse(EnvironmentConfig.getCommunauteArticle(idArticle)),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Échec de récupération de l\'article: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'article: $e');
    }
  }
}
