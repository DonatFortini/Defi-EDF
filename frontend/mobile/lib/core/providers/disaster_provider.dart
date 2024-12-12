import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class DisasterProvider extends ChangeNotifier {
  Position? _currentPosition;
  String _incidentType = '';
  String _vehicle = '';
  File? _image;
  DateTime? _dateTime;

  DateTime? get dateTime => _dateTime;
  Position? get currentPosition => _currentPosition;
  String get incidentType => _incidentType;
  String get vehicle => _vehicle;
  File? get image => _image;

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

  void updateDateTime() {
    _dateTime = DateTime.now();
    notifyListeners();
  }

  void updateImage(File file) {
    _image = file;
    notifyListeners();
  }

  void submitReport() {
    updateDateTime();
    fetchCurrentLocation();

    debugPrint('Type d\'incident: $_incidentType');
    debugPrint('Véhicule: $_vehicle');
    debugPrint('Image: ${_image?.path ?? 'Aucune image jointe'}');
    debugPrint('Date et heure: ${_dateTime?.toString() ?? 'Non défini'}');
    debugPrint(
        'Position: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
  }
}
