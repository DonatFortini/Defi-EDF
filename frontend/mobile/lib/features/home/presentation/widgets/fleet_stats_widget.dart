import 'package:flutter/material.dart';
import 'package:frontend/features/home/domain/entities/fleet_entities.dart';

class FleetStatsWidget extends StatelessWidget {
  final FleetStatsEntity stats;

  const FleetStatsWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistique du parc automobile',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: Column(
                children: [
                  _buildStatsRow(
                    context,
                    stats.totalVehicles.toString(),
                    stats.electricVehicles.toString(),
                    stats.availableVehicles.toString(),
                    stats.rentedVehicles.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(
    BuildContext context,
    String totalVehicles,
    String electricVehicles,
    String availableVehicles,
    String rentedVehicles,
  ) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                icon: Icons.directions_car,
                label: 'Véhicules',
                value: totalVehicles,
                color: Colors.blue,
              ),
              _buildStatItem(
                icon: Icons.electric_bolt,
                label: 'Véhicules électriques',
                value: electricVehicles,
                color: Colors.green,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                icon: Icons.check_circle,
                label: 'Disponibles',
                value: availableVehicles,
                color: Colors.teal,
              ),
              _buildStatItem(
                icon: Icons.access_time,
                label: 'Louées',
                value: rentedVehicles,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 35),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
