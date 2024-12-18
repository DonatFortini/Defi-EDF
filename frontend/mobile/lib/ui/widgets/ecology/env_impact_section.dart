import 'package:flutter/material.dart';

class EnvironmentalImpactSection extends StatelessWidget {
  const EnvironmentalImpactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Impact Environnemental',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Les véhicules électriques représentent l\'avenir de la mobilité durable. Choisir un véhicule électrique permet de réduire significativement les émissions de CO2 et de contribuer à la lutte contre le changement climatique.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Principaux avantages des véhicules électriques:',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            ...[
                  'Zéro émission locale',
                  'Coût de fonctionnement réduit',
                  'Moins de dépendance aux carburants fossiles',
                  'Technologie en constante amélioration',
                ]
                .map(
                  (advantage) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green[700],
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(advantage)),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
