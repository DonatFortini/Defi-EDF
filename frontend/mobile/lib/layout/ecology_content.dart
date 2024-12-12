import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/ecology_provider.dart';
import 'package:frontend/widgets/ecology/car_type_selector.dart';
import 'package:frontend/widgets/ecology/km_selector.dart';
import 'package:frontend/widgets/ecology/statistics_display.dart';

class EcologyContent extends StatelessWidget {
  const EcologyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<EcologyProvider>(
        builder: (context, ecologyProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Calcul du coût du trajet écologique',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const CarTypeSelector(),
              const SizedBox(height: 16),
              const KmSelector(),
              const SizedBox(height: 16),
              StatisticsDisplay(
                cost: ecologyProvider.calculateCost(),
                emission: ecologyProvider.calculateEmissions(),
              ),
            ],
          );
        },
      ),
    );
  }
}
