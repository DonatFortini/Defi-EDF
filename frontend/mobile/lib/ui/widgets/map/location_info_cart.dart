import 'package:flutter/material.dart';
import 'package:mobile/data/models/map_location.dart';

class LocationInfoCard extends StatelessWidget {
  final MapLocation location;

  const LocationInfoCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    if (location.startAddress.isEmpty && location.endAddress.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (location.startAddress.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.green),
                title: const Text('Point de départ'),
                subtitle: Text(location.startAddress),
              ),
            if (location.endAddress.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.red),
                title: const Text('Point d\'arrivée'),
                subtitle: Text(location.endAddress),
              ),
            if (location.routeDuration.isNotEmpty &&
                location.routeDistance.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.directions_car, color: Colors.blue),
                title: const Text('Itinéraire'),
                subtitle: Text(
                  'Durée: ${location.routeDuration} - Distance: ${location.routeDistance}',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
