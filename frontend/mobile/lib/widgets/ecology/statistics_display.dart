import 'package:flutter/material.dart';

class StatisticsDisplay extends StatelessWidget {
  final double cost;
  final double emission;

  const StatisticsDisplay(
      {super.key, required this.cost, required this.emission});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Coût estimé : €${cost.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge),
        Text('Émissions estimées : ${emission.toStringAsFixed(2)} g CO2',
            style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
