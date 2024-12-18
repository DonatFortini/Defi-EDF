import 'package:flutter/material.dart';
import 'package:mobile/data/models/map_location.dart';

class LocationInfoCard extends StatelessWidget {
  final MapLocation location;
  final VoidCallback onClear;

  const LocationInfoCard({
    super.key,
    required this.location,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (location.startAddress.isNotEmpty)
              Text('Départ: ${location.startAddress}'),
            if (location.endAddress.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Arrivée: ${location.endAddress}'),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear),
                label: const Text('Effacer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
