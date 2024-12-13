import 'package:flutter/foundation.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;

  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  bool get isInitialized => _isInitialized;
  AuthProvider() {
    checkAuthStatus();
  }

  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await AuthService.login(email, password);

      if (response.error != null) {
        _error = response.error;
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (response.token != null) {
        _token = response.token;
        // Sauvegarder dans SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        _isLoading = false;
        _error = null;
        notifyListeners();
        return true;
      }

      _error = 'Une erreur inattendue est survenue';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Erreur de connexion: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Supprimer de SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');

      _token = null;
      _error = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Erreur lors de la déconnexion: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      _error = 'Erreur lors de la vérification du statut: ${e.toString()}';
      _isInitialized = true;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
