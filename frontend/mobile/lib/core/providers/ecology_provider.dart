import 'package:flutter/foundation.dart';

class EcologyProvider extends ChangeNotifier {
  String _carType = 'Electric'; // Valeur initiale : voiture électrique
  int _km = 10; // Valeur initiale : 10 km

  String get carType => _carType;
  int get km => _km;

  // Sélectionner le type de voiture
  void setCarType(String type) {
    _carType = type;
    notifyListeners();
  }

  // Modifier le nombre de kilomètres
  void setKm(int km) {
    _km = km;
    notifyListeners();
  }

  // Calcul du coût basé sur le type de voiture et le nombre de kilomètres
  double calculateCost() {
    double costPerKm;
    switch (_carType) {
      case 'Electric':
        costPerKm = 0.05; // 0.05 € par km pour une voiture électrique
        break;
      case 'Hybrid':
        costPerKm = 0.08; // 0.08 € par km pour une voiture hybride
        break;
      case 'Thermal':
        costPerKm = 0.12; // 0.12 € par km pour une voiture thermique
        break;
      default:
        costPerKm = 0.1;
    }
    return _km * costPerKm;
  }

  // Calcul des émissions en CO2 (en grammes) basées sur le type de voiture et les kilomètres
  double calculateEmissions() {
    double emissionsPerKm;
    switch (_carType) {
      case 'Electric':
        emissionsPerKm = 0; // Voiture électrique, aucune émission
        break;
      case 'Hybrid':
        emissionsPerKm = 40; // 40g CO2 par km pour une hybride
        break;
      case 'Thermal':
        emissionsPerKm = 120; // 120g CO2 par km pour une thermique
        break;
      default:
        emissionsPerKm = 50;
    }
    return _km * emissionsPerKm;
  }
}
