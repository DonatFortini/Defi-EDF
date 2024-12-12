import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/ecology_provider.dart';

class CarTypeSelector extends StatelessWidget {
  const CarTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<EcologyProvider>();

    return DropdownButton<String>(
      value: provider.carType,
      items: ['Electric', 'Hybrid', 'Thermal']
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          provider.setCarType(value);
        }
      },
    );
  }
}
