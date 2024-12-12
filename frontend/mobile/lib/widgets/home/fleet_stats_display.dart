import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/fleet_stats_provider.dart';

Widget buildFleetStatisticsSection() {
  return Consumer<FleetStatsProvider>(
    builder: (context, fleetStats, child) {
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
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 250, // Adjust height to allocate space for the stats
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                            icon: Icons.directions_car,
                            label: 'Véhicules',
                            value: fleetStats.totalVehicles.toString(),
                            color: Colors.blue,
                          ),
                          _buildStatItem(
                            icon: Icons.electric_bolt,
                            label: 'Véhicules électriques',
                            value: fleetStats.electricVehicles.toString(),
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
                            value: fleetStats.availableVehicles.toString(),
                            color: Colors.teal,
                          ),
                          _buildStatItem(
                            icon: Icons.access_time,
                            label: 'Louées',
                            value: fleetStats.rentedVehicles.toString(),
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
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
