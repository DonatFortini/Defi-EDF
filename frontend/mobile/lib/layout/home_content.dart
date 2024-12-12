import 'package:flutter/material.dart';
import 'package:frontend/screens/scanner_page.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/fleet_stats_provider.dart';
import 'package:frontend/widgets/home/fleet_stats_display.dart';
import 'package:frontend/widgets/quick_action_card.dart';
import 'package:frontend/widgets/recent_activity_list.dart';
import 'package:frontend/screens/rental_page.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FleetStatsProvider(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFleetStatisticsSection(),
              SizedBox(height: 20),
              _buildQuickActionSection(context),
              SizedBox(height: 20),
              Text(
                'Historique récent',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              buildRecentActivityList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionSection(BuildContext context) {
    return Column(
      children: [
        buildQuickActionCard(
          context,
          'Louer une voiture',
          Icons.car_rental,
          Colors.green,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RentalPage()),
            );
          },
        ),
        SizedBox(height: 10),
        buildQuickActionCard(
          context,
          'Rendre une voiture',
          Icons.assignment_return,
          Colors.blue,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScannerPage()),
            );
          },
        ),
      ],
    );
  }
}
