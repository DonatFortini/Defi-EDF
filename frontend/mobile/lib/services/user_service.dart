import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/environment.dart';

class UserData {
  final String nomUtilisateur;
  final String email;
  final String idUtilisateur;

  UserData({
    required this.nomUtilisateur,
    required this.email,
    required this.idUtilisateur,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        nomUtilisateur: json['nom_utilisateur'] ?? '',
        email: json['email'] ?? '',
        idUtilisateur: json['id_utilisateur'] ?? '');
  }
}

class UserService {
  static Future<UserData> getUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${EnvironmentConfig.apiUrl}/user/info'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserData.fromJson(data);
      } else {
        throw Exception('Échec de la récupération des données utilisateur');
      }
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }
}
