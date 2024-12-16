import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/home/presentation/bloc/fleet_bloc.dart';
import 'package:frontend/features/home/presentation/widgets/fleet_stats_widget.dart';
import 'package:frontend/core/widgets/quick_action_section.dart';
import 'package:frontend/core/widgets/recent_activity_list.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final sl = GetIt.instance;

  final List<CardProp> cardProps = [
    CardProp(
      name: 'Réserver une voiture',
      color: Colors.green,
      icon: Icons.calendar_today,
      navPath: '/rental',
    ),
    CardProp(
      name: 'Récupérer/Déposer une voiture',
      color: Colors.blue,
      icon: Icons.car_rental,
      navPath: '/scanner',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FleetStatsBloc>()..add(FetchFleetStats()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<FleetStatsBloc, FleetStatsState>(
                  builder: (context, state) {
                    if (state is FleetStatsLoaded) {
                      return FleetStatsWidget(stats: state.fleetStats);
                    } else if (state is FleetStatsError) {
                      return Text('Error: ${state.message}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(height: 20),
                QuickActionSection(actions: cardProps),
                const SizedBox(height: 20),
                Text(
                  'Historique récent',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                RecentActivityList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
