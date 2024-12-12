import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/faulty_comp_provider.dart';

class ComponentForm extends StatelessWidget {
  const ComponentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FaultyCompProvider>();
    final options = [
      'Freins',
      'Moteur',
      'Essuie-glace',
      'Pare-brise',
      'Pneu',
      'Autres'
    ];

    return DropdownButtonFormField<String>(
      value: provider.component.isNotEmpty ? provider.component : null,
      items: options
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          provider.updateComponent(value);
        }
      },
      decoration: const InputDecoration(
        labelText: 'Sélectionnez un composant',
        border: OutlineInputBorder(),
      ),
    );
  }
}
