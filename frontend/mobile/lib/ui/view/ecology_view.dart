import 'package:flutter/material.dart';
import 'package:mobile/ui/widgets/ecology/comparative_calculator.dart';
import 'package:mobile/ui/widgets/ecology/env_impact_section.dart';

class EcologyView extends StatefulWidget {
  const EcologyView({super.key});

  @override
  State<EcologyView> createState() => _EcologyViewState();
}

class _EcologyViewState extends State<EcologyView> {
  double _selectedDistance = 100; // Default 100 km

  final Map<String, Map<String, double>> _vehicleData = {
    'Électrique': {
      'energy_cost': 5.0, // Euros per 100 km
      'co2_emission': 0.0, // kg CO2 per 100 km
    },
    'Hybride': {
      'energy_cost': 7.5, // Euros per 100 km
      'co2_emission': 40.0, // kg CO2 per 100 km
    },
    'Thermique': {
      'energy_cost': 15.0, // Euros per 100 km
      'co2_emission': 120.0, // kg CO2 per 100 km
    },
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Écologie et Mobilité',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Distance Slider
            Text(
              'Distance parcourue : $_selectedDistance km',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _selectedDistance,
              min: 10,
              max: 500,
              divisions: 49,
              label: _selectedDistance.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _selectedDistance = value;
                });
              },
            ),

            // Comparative Calculator
            const SizedBox(height: 20),
            Text(
              'Comparaison des Véhicules',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            ComparativeCalculator(
              selectedDistance: _selectedDistance,
              vehicleData: _vehicleData,
            ),

            // Environmental Impact Section
            const SizedBox(height: 30),
            const EnvironmentalImpactSection(),
          ],
        ),
      ),
    );
  }
}
