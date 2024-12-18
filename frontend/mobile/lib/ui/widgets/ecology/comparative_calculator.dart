import 'package:flutter/material.dart';

class ComparativeCalculator extends StatelessWidget {
  final double selectedDistance;
  final Map<String, Map<String, double>> vehicleData;

  const ComparativeCalculator({
    super.key,
    required this.selectedDistance,
    required this.vehicleData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
              vehicleData.keys.map((type) {
                // Calculate scaled values based on selected distance
                double scaleFactor = selectedDistance / 100;
                double energyCost =
                    vehicleData[type]!['energy_cost']! * scaleFactor;
                double co2Emission =
                    vehicleData[type]!['co2_emission']! * scaleFactor;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          type,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coût énergétique: ${energyCost.toStringAsFixed(2)} €',
                            ),
                            Text(
                              'Émissions CO2: ${co2Emission.toStringAsFixed(1)} kg',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
