import 'package:flutter/material.dart';
import 'package:frontend/widgets/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/disaster_provider.dart';
import 'package:frontend/widgets/disaster/car_damage_selector.dart';

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

        // Car replica with clickable areas
        const CarDamageSelector(),

        const SizedBox(height: 20),

        // Precision field for extra details
        TextFormField(
          onChanged: provider.updateVehicle,
          decoration: const InputDecoration(
              labelText: 'Détails supplémentaires sur les dommages'),
        ),
        const SizedBox(height: 20),

        ImagePickerWidget(
          updateImageCallback: (image) {
            context.read<DisasterProvider>().updateImage(image!);
          },
        ),

        ElevatedButton(
          onPressed: () {
            provider.submitReport();
          },
          child: const Text('Déclarer l\'incident'),
        ),
      ],
    );
  }
}
