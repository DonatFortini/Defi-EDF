import 'package:flutter/foundation.dart';

class FleetStatsProvider extends ChangeNotifier {
  // Mock data - in a real app, this would come from a backend or database
  int _totalVehicles = 50;
  int _electricVehicles = 15;
  int _availableVehicles = 30;
  int _rentedVehicles = 20;

  // Getters
  int get totalVehicles => _totalVehicles;
  int get electricVehicles => _electricVehicles;
  int get availableVehicles => _availableVehicles;
  int get rentedVehicles => _rentedVehicles;

  // Method to update statistics (could be called after fetching from an API)
  void updateStats({
    int? totalVehicles,
    int? electricVehicles,
    int? availableVehicles,
    int? rentedVehicles,
  }) {
    if (totalVehicles != null) _totalVehicles = totalVehicles;
    if (electricVehicles != null) _electricVehicles = electricVehicles;
    if (availableVehicles != null) _availableVehicles = availableVehicles;
    if (rentedVehicles != null) _rentedVehicles = rentedVehicles;

    notifyListeners();
  }
}
