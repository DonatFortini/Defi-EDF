import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/ecology_provider.dart';

class KmSelector extends StatelessWidget {
  const KmSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<EcologyProvider>();

    return Row(
      children: [
        const Text('Kilomètres:'),
        Slider(
          value: provider.km.toDouble(),
          min: 1,
          max: 500,
          divisions: 500,
          label: provider.km.toString(),
          onChanged: (value) {
            provider.setKm(value.toInt());
          },
        ),
        Text('${provider.km} km'),
      ],
    );
  }
}
