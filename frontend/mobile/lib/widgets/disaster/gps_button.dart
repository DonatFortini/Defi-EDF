import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/disaster_provider.dart';

class GpsButton extends StatelessWidget {
  const GpsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await context.read<DisasterProvider>().fetchCurrentLocation();
        final position = context.read<DisasterProvider>().currentPosition;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(position != null
                ? 'Position : ${position.latitude}, ${position.longitude}'
                : 'Impossible de récupérer la position'),
          ),
        );
      },
      child: const Text('Obtenir la position GPS'),
    );
  }
}
