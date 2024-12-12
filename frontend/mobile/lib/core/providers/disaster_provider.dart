import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class DisasterProvider extends ChangeNotifier {
  Position? _currentPosition;
  String _incidentType = '';
  String _vehicle = '';

  Position? get currentPosition => _currentPosition;
  String get incidentType => _incidentType;
  String get vehicle => _vehicle;

  Future<void> fetchCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la position GPS : $e');
    }
  }

  void updateIncidentType(String type) {
    _incidentType = type;
    notifyListeners();
  }

  void updateVehicle(String vehicle) {
    _vehicle = vehicle;
    notifyListeners();
  }
}
