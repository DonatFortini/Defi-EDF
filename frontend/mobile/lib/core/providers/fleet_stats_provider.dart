import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/config/environment.dart';

class FleetStatsProvider extends ChangeNotifier {
  int _totalVehicles = 0;
  int _electricVehicles = 0;
  int _availableVehicles = 0;
  int _rentedVehicles = 0;

  int get totalVehicles => _totalVehicles;
  int get electricVehicles => _electricVehicles;
  int get availableVehicles => _availableVehicles;
  int get rentedVehicles => _rentedVehicles;

  FleetStatsProvider() {
    fetchStats();
  }

  void _updateStats({
    required int totalVehicles,
    required int electricVehicles,
    required int availableVehicles,
    required int rentedVehicles,
  }) {
    _totalVehicles = totalVehicles;
    _electricVehicles = electricVehicles;
    _availableVehicles = availableVehicles;
    _rentedVehicles = rentedVehicles;

    notifyListeners();
  }

  Future<void> fetchStats() async {
    try {
      print(EnvironmentConfig.dashboardUrl);
      final response =
          await http.get(Uri.parse(EnvironmentConfig.dashboardUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final int totalVehicles =
            data['propulsion']['electric'] + data['propulsion']['thermic'];
        final int electricVehicles = data['propulsion']['electric'];
        final int availableVehicles = data['dispo']['free'];
        final int rentedVehicles = data['dispo']['leased'];

        _updateStats(
          totalVehicles: totalVehicles,
          electricVehicles: electricVehicles,
          availableVehicles: availableVehicles,
          rentedVehicles: rentedVehicles,
        );
      } else {
        throw Exception('Failed to load fleet stats');
      }
    } catch (e) {
      // Handle error appropriately
      print('Error fetching fleet stats: $e');
    }
  }
}
