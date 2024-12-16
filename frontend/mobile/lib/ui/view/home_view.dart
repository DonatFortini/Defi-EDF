import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/quick_action_card.dart';
import 'package:mobile/data/models/fleet_stats.dart';
import 'package:mobile/ui/widgets/home/fleet_stats.dart';
import 'package:mobile/core/widgets/quick_action_section.dart';
import 'package:mobile/core/widgets/recent_activity_list.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  final List<CardProps> quickActions = [
    CardProps(
      textVal: 'Réserver une voiture',
      color: Colors.green,
      oIcon: Icons.calendar_today,
      navigatorPath: '/rental',
    ),
    CardProps(
      textVal: 'Récupérer/Rendre une voiture',
      color: Colors.blue,
      oIcon: Icons.car_rental,
      navigatorPath: '/scanner',
    ),
  ];

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            buildFleetStatisticsSection(),
            SizedBox(height: 20),
            _buildQuickActionSection(context),
            Text(
              'Historique récent',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Card(child: RecentActivityList()),
          ],
        ),
      ),
    );
  }

  Widget buildFleetStatisticsSection() {
    const fleetStats = FleetStatsModel(
      totalVehicles: 10,
      electricVehicles: 3,
      availableVehicles: 5,
      rentedVehicles: 2,
    );
    return FleetStatisticsSection(fleetStats: fleetStats);
  }

  Widget _buildQuickActionSection(BuildContext context) {
    return QuickActionSection(quickActions: widget.quickActions);
  }
}
