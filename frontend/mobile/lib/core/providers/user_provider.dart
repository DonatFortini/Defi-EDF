import 'package:flutter/foundation.dart';
import 'package:frontend/services/user_service.dart';

class UserProvider with ChangeNotifier {
  String _nomUtilisateur = '';
  String _email = '';
  String _idUtilisateur = '';
  bool _isLoading = false;
  String? _error;

  String get nomUtilisateur => _nomUtilisateur;
  String get email => _email;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUserData(String token) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userData = await UserService.getUserInfo(token);

      _nomUtilisateur = userData.nomUtilisateur;
      _email = userData.email;
      _idUtilisateur = userData.idUtilisateur;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateNomUtilisateur(String newName) {
    _nomUtilisateur = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
