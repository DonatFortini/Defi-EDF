import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/quick_action_section.dart';
import 'package:mobile/core/widgets/quick_action_card.dart';

class ModalActions {
  final BuildContext context;

  ModalActions(this.context);

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
    CardProps(
      textVal: 'Déclarer un accident',
      color: Colors.red,
      oIcon: Icons.car_crash,
      navigatorPath: '/disaster',
    ),
    CardProps(
      textVal: 'Déclarer un défaut',
      color: Colors.orange,
      oIcon: Icons.build,
      navigatorPath: '/faulty_comp',
    ),
  ];

  Widget buildQuickActions() {
    return Scaffold(
      appBar: AppBar(title: const Text('Actions rapides'), centerTitle: true),
      body: Center(child: QuickActionSection(quickActions: quickActions)),
    );
  }
}
