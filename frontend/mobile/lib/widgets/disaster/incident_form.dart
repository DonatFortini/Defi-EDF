import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/disaster_provider.dart';

class IncidentForm extends StatelessWidget {
  const IncidentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DisasterProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          value: provider.incidentType.isNotEmpty &&
                  ['Accident', 'Panne', 'Autre'].contains(provider.incidentType)
              ? provider.incidentType
              : null,
          items: ['Accident', 'Panne', 'Autre']
              .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              provider.updateIncidentType(value);
            }
          },
          decoration: const InputDecoration(labelText: 'Type d\'incident'),
        ),
        const SizedBox(height: 20),
        TextFormField(
          onChanged: provider.updateVehicle,
          decoration: const InputDecoration(labelText: 'Véhicule'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Logique pour envoyer les données
          },
          child: const Text('Déclarer l\'incident'),
        ),
      ],
    );
  }
}
